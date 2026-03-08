//
//  ServerSetupViewModel.swift
//  Final Project
//
//  Created by SabinaKarimli on 02.03.26.
//


import Foundation

@MainActor
final class ServerSetupViewModel: ObservableObject {

    @Published private(set) var pingState: PingState = .idle
    @Published var urlText: String = ServerConfig.shared.baseURL

    private var pingTask: Task<Void, Never>?
    private(set) var pingInFlight = false

    enum PingState: Equatable {
        case idle
        case loading
        case success(message: String)
        case failure(message: String)
    }

    var pingPassed: Bool {
        if case .success = pingState { return true }
        return false
    }

    func urlDidChange() {
        pingState = .failure(message: "⚠️  URL changed — please test again")
        ServerConfig.shared.invalidatePing()
    }

    func startPing() {
        let raw = urlText.trimmingCharacters(in: .whitespacesAndNewlines)

        guard !raw.isEmpty else {
            pingState = .failure(message: "⚠️  Please enter a URL first")
            return
        }
        guard raw.hasPrefix("http://") || raw.hasPrefix("https://") else {
            pingState = .failure(message: "⚠️  URL must start with http:// or https://")
            return
        }
        guard URL(string: raw) != nil else {
            pingState = .failure(message: "⚠️  Invalid URL — e.g. http://165.x.x.x:8324")
            return
        }

        pingTask?.cancel()
        pingTask = nil
        pingInFlight = true
        pingState = .loading

        pingTask = Task { [weak self] in
            guard let self else { return }
            do {
                let result = try await self.doPing(baseURL: raw)
                guard !Task.isCancelled else { return }
                self.pingInFlight = false
                switch result {
                case .ok:
                    self.pingState = .success(message: "✅  Server reachable — Continue is active")
                case .httpOkWsSkipped(let reason):
                    self.pingState = .success(message: "⚠️  HTTP OK, WebSocket unclear (\(reason))")
                case .wrongEndpoint(let code):
                    self.pingState = .failure(message: "❌  Server responded \(code) — check port number")
                case .noResponse:
                    self.pingState = .failure(message: "❌  No response — check IP address and port")
                }
            } catch is URLError {
                guard !Task.isCancelled else { return }
                self.pingInFlight = false
                self.pingState = .failure(message: "❌  Cannot connect — verify the URL is correct")
            } catch {
                guard !Task.isCancelled else { return }
                self.pingInFlight = false
                self.pingState = .failure(message: "❌  Connection failed — \(error.localizedDescription)")
            }
        }
    }

    func saveAndProceed() {
        var url = urlText.trimmingCharacters(in: .whitespacesAndNewlines)
        if url.isEmpty { url = ServerConfig.shared.baseURL }
        if url.hasSuffix("/") { url = String(url.dropLast()) }
        ServerConfig.shared.baseURL = url
        ServerConfig.shared.pingVerified = true
    }

    func viewWillDisappear() {
        if !pingInFlight && !pingPassed {
            ServerConfig.shared.invalidatePing()
        }
    }

    deinit { pingTask?.cancel() }

    private enum PingResult {
        case ok
        case httpOkWsSkipped(String)
        case wrongEndpoint(Int)
        case noResponse
    }

    private enum PingError: Error, CustomStringConvertible {
        case message(String)
        var description: String {
            if case .message(let m) = self { return m }
            return "Unknown"
        }
    }

    private func doPing(baseURL: String) async throws -> PingResult {
        let base = baseURL.hasSuffix("/") ? String(baseURL.dropLast()) : baseURL
        guard let httpURL = URL(string: "\(base)/containers") else { return .noResponse }

        var req = URLRequest(url: httpURL)
        req.timeoutInterval = 8
        req.httpMethod = "GET"
        req.setValue("application/json", forHTTPHeaderField: "Accept")

        let (_, response) = try await URLSession.shared.data(for: req)
        guard let http = response as? HTTPURLResponse else { return .noResponse }
        guard (200...299).contains(http.statusCode) else { return .wrongEndpoint(http.statusCode) }

        let wsResult = await pingWebSocket(baseHTTP: base)
        switch wsResult {
        case .success: return .ok
        case .failure(let e): return .httpOkWsSkipped(e.description)
        }
    }

    private func pingWebSocket(baseHTTP: String) async -> Result<Void, PingError> {
        guard var components = URLComponents(string: baseHTTP) else {
            return .failure(.message("Invalid base URL"))
        }
        components.scheme = components.scheme == "https" ? "wss" : "ws"
        components.path = "/stats"
        components.queryItems = [URLQueryItem(name: "containerId", value: "ping_check")]

        guard let wsURL = components.url else {
            return .failure(.message("Cannot build WS URL"))
        }

        let wsTask = URLSession.shared.webSocketTask(with: wsURL)
        wsTask.resume()

        return await withTaskGroup(of: Result<Void, PingError>.self) { group in
            group.addTask {
                do {
                    _ = try await wsTask.receive()
                    wsTask.cancel(with: .goingAway, reason: nil)
                    return .success(())
                } catch {
                    let nsErr = error as NSError
                    if nsErr.domain == NSURLErrorDomain, nsErr.code == NSURLErrorCancelled {
                        return .success(())
                    }
                    return .failure(.message(error.localizedDescription))
                }
            }

            group.addTask {
                try? await Task.sleep(nanoseconds: 4_000_000_000)
                wsTask.cancel(with: .goingAway, reason: nil)
                return .failure(.message("WS timeout (4s)"))
            }

            let result = await group.next() ?? .failure(.message("Unknown"))
            group.cancelAll()
            return result
        }
    }
}
