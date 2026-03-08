

import SwiftUI
import FirebaseAuth

@MainActor
final class ContainersViewModel: ObservableObject {

    @Published private(set) var containers:  [ContainerInfo] = []
    @Published private(set) var latestStats: [String: ContainerStats] = [:]

    @Published var searchText:  String      = "" { didSet { applyFilter() } }
    @Published var filterState: FilterState = .all { didSet { applyFilter() } }
    @Published private(set) var filtered:   [ContainerInfo] = []

    @Published var isLoading:    Bool    = false
    @Published var errorMessage: String? = nil
    @Published var actionError:  String? = nil

    enum FilterState: String, CaseIterable {
        case all     = "All"
        case running = "Running"
        case stopped = "Stopped"

        var icon: String {
            switch self {
            case .all:     return "square.stack"
            case .running: return "checkmark.circle"
            case .stopped: return "stop.circle"
            }
        }
    }

    private let service:       LumenService
    private let statsStreaming: StatsStreaming
    private var streamTasks:   [String: Task<Void, Never>] = [:]
    private var loadTask:      Task<Void, Never>?

    private var refreshObserver: NSObjectProtocol?

    init(
        service:       LumenService   = AppEnvironment.makeLumenService(),
        statsStreaming: StatsStreaming = AppEnvironment.makeStatsStreaming()
    ) {
        self.service       = service
        self.statsStreaming = statsStreaming
        observeRefresh()
    }

    private func observeRefresh() {
        refreshObserver = NotificationCenter.default.addObserver(
            forName: Notification.Name("containersNeedsRefresh"),
            object: nil,
            queue: nil
        ) { [weak self] _ in
            Task { @MainActor [weak self] in
                self?.refresh()
            }
        }
    }

    deinit {
        if let observer = refreshObserver {
            NotificationCenter.default.removeObserver(observer)
        }
    }

    // MARK: - Lifecycle

    func onAppear() {
        loadTask?.cancel()
        loadTask = Task { await load() }
    }

    func onDisappear() {
        loadTask?.cancel()
        loadTask = nil
    }

    func refresh() {
        cancelStreams()
        latestStats.removeAll()
        loadTask?.cancel()
        loadTask = Task { await load() }
    }

    // MARK: - Load

    private func load() async {
        isLoading    = true
        errorMessage = nil

        do {
            let list = try await service.listContainers()
            containers = list
            applyFilter()

            let running    = list.filter { $0.isRunning }
            let runningIds = Set(running.map { $0.id })

            reconcileStreams(runningIds: runningIds)
            startStreams(for: running)

        } catch {
            guard !Task.isCancelled else { return }
            errorMessage = error.localizedDescription
        }

        isLoading = false
    }

    // MARK: - Streams

    private func reconcileStreams(runningIds: Set<String>) {
        for (id, task) in streamTasks where !runningIds.contains(id) {
            task.cancel()
            streamTasks.removeValue(forKey: id)
            latestStats.removeValue(forKey: id)
        }
    }

    private func startStreams(for running: [ContainerInfo]) {
        let userEmail = Auth.auth().currentUser?.email ?? "guest@local"

        for c in running {
            guard streamTasks[c.id] == nil else { continue }
            let cid = c.id

            streamTasks[cid] = Task { [weak self] in
                guard let self else { return }
                let stream = self.statsStreaming.stream(containerId: cid, email: userEmail)
                do {
                    for try await stats in stream {
                        guard !Task.isCancelled else { break }
                        self.latestStats[cid] = stats
                    }
                } catch { }
            }
        }
    }

    private func cancelStreams() {
        streamTasks.values.forEach { $0.cancel() }
        streamTasks.removeAll()
    }

    // MARK: - Filter

    private func applyFilter() {
        var result = containers

        switch filterState {
        case .running: result = result.filter {  $0.isRunning }
        case .stopped: result = result.filter { !$0.isRunning }
        case .all:     break
        }

        let q = searchText.trimmingCharacters(in: .whitespacesAndNewlines)
        if !q.isEmpty {
            result = result.filter {
                $0.name.localizedCaseInsensitiveContains(q) ||
                $0.image.localizedCaseInsensitiveContains(q)
            }
        }

        filtered = result
    }

    // MARK: - Actions

    func start(_ id: String) async {
        do    { try await service.startContainer(id: id);   refresh() }
        catch { actionError = error.localizedDescription }
    }

    func stop(_ id: String) async {
        do    { try await service.stopContainer(id: id);    refresh() }
        catch { actionError = error.localizedDescription }
    }

    func restart(_ id: String) async {
        do    { try await service.restartContainer(id: id); refresh() }
        catch { actionError = error.localizedDescription }
    }

    func remove(_ id: String) async {
        do    { try await service.removeContainer(id: id);  refresh() }
        catch { actionError = error.localizedDescription }
    }

    // MARK: - Computed

    var runningCount: Int { containers.filter {  $0.isRunning }.count }
    var stoppedCount: Int { containers.filter { !$0.isRunning }.count }
}
