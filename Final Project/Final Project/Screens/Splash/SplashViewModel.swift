import Foundation


@MainActor
final class SplashViewModel {

    var onProgress: ((Float, String) -> Void)?
    var onFinished: (() -> Void)?

    private var loadingTask: Task<Void, Never>?

    func startLoading() {
        loadingTask = Task {
            var progress: Float = 0
            while progress < 1.0 {
                try? await Task.sleep(nanoseconds: 30_000_000)
                guard !Task.isCancelled else { return }
                progress = min(progress + 0.013, 1.0)
                let pct = Int(progress * 100)
                onProgress?(progress, "\(pct)%")
            }
            onFinished?()
        }
    }

    nonisolated func stopLoading() {
        Task { @MainActor [weak self] in
            self?.loadingTask?.cancel()
            self?.loadingTask = nil
        }
    }
}
