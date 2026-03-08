
import Foundation

final class MockStatsHub: StatsStreaming {

    static let shared = MockStatsHub()

    private struct Profile {
        let baseCPU:      Double
        let cpuAmplitude: Double
        let spikeChance:  Double
        let spikeMult:    Double
        let baseMem:      Int
        let memAmplitude: Int
        let memLimit:     Int
    }

    private static let memLimit = 3917
    private let profiles: [String: Profile] = [
        "lumen-app":                Profile(baseCPU: 3.0,  cpuAmplitude: 0.8, spikeChance: 0.05, spikeMult: 7.0, baseMem: 195, memAmplitude: 30, memLimit: memLimit),
        "lumen-minio":              Profile(baseCPU: 5.0,  cpuAmplitude: 1.0, spikeChance: 0.00, spikeMult: 1.0, baseMem: 100, memAmplitude: 15, memLimit: memLimit),
        
        "lumen-postgres":           Profile(baseCPU: 5.5,  cpuAmplitude: 1.2, spikeChance: 0.05, spikeMult: 2.5, baseMem: 135, memAmplitude: 25, memLimit: memLimit),
        "log-cpu-heavy":            Profile(baseCPU: 22.0, cpuAmplitude: 4.0, spikeChance: 0.00, spikeMult: 1.0, baseMem: 45,  memAmplitude: 10, memLimit: memLimit),
        
        "log-memory-heavy":         Profile(baseCPU: 2.8,  cpuAmplitude: 1.0, spikeChance: 0.03, spikeMult: 3.0, baseMem: 320, memAmplitude: 45, memLimit: memLimit),
        
        "log-mongodb":              Profile(baseCPU: 2.2,  cpuAmplitude: 0.6, spikeChance: 0.06, spikeMult: 6.0, baseMem: 215, memAmplitude: 30, memLimit: memLimit),
        "log-redis-cache":          Profile(baseCPU: 2.2,  cpuAmplitude: 0.5, spikeChance: 0.00, spikeMult: 1.0, baseMem: 35,  memAmplitude: 8,  memLimit: memLimit),
        "log-auth-service":         Profile(baseCPU: 2.0,  cpuAmplitude: 0.5, spikeChance: 0.00, spikeMult: 1.0, baseMem: 28,  memAmplitude: 6,  memLimit: memLimit),
        "log-notification-service": Profile(baseCPU: 1.8,  cpuAmplitude: 0.4, spikeChance: 0.00, spikeMult: 1.0, baseMem: 24,  memAmplitude: 5,  memLimit: memLimit),
        
        "log-analytics":            Profile(baseCPU: 2.5,  cpuAmplitude: 0.8, spikeChance: 0.06, spikeMult: 5.0, baseMem: 42,  memAmplitude: 12, memLimit: memLimit),
        "log-worker-jobs":          Profile(baseCPU: 2.2,  cpuAmplitude: 0.5, spikeChance: 0.00, spikeMult: 1.0, baseMem: 32,  memAmplitude: 8,  memLimit: memLimit),
        "log-queue-processor":      Profile(baseCPU: 2.0,  cpuAmplitude: 0.5, spikeChance: 0.00, spikeMult: 1.0, baseMem: 25,  memAmplitude: 6,  memLimit: memLimit),
        "log-api-gateway":          Profile(baseCPU: 2.5,  cpuAmplitude: 0.6, spikeChance: 0.00, spikeMult: 1.0, baseMem: 22,  memAmplitude: 5,  memLimit: memLimit),
        "log-nginx-web":            Profile(baseCPU: 1.8,  cpuAmplitude: 0.4, spikeChance: 0.00, spikeMult: 1.0, baseMem: 16,  memAmplitude: 4,  memLimit: memLimit),
        "log-cleaner":              Profile(baseCPU: 1.6,  cpuAmplitude: 0.4, spikeChance: 0.05, spikeMult: 4.0, baseMem: 12,  memAmplitude: 3,  memLimit: memLimit),
        "log-payment-service":      Profile(baseCPU: 2.0,  cpuAmplitude: 0.5, spikeChance: 0.00, spikeMult: 1.0, baseMem: 24,  memAmplitude: 5,  memLimit: memLimit),
        
        "log-search-service":       Profile(baseCPU: 2.0,  cpuAmplitude: 0.6, spikeChance: 0.06, spikeMult: 6.5, baseMem: 26,  memAmplitude: 6,  memLimit: memLimit),
        "log-metrics":              Profile(baseCPU: 1.6,  cpuAmplitude: 0.3, spikeChance: 0.00, spikeMult: 1.0, baseMem: 18,  memAmplitude: 4,  memLimit: memLimit),
    ]

    private let defaultProfile = Profile(
        baseCPU: 1.8, cpuAmplitude: 0.4, spikeChance: 0.00, spikeMult: 1.0,
        baseMem: 22, memAmplitude: 5, memLimit: memLimit
    )

    // MARK: - Stream

    func stream(containerId: String, email: String?) -> AsyncThrowingStream<ContainerStats, Error> {
        AsyncThrowingStream { [weak self] continuation in
            guard let self else { continuation.finish(); return }

            let containerName = MockData.containers
                .first(where: { $0.id == containerId })?.name ?? containerId
            let profile = self.profiles[containerName] ?? self.defaultProfile

            let task = Task {
                var phase          = Double.random(in: 0...(2 * .pi))
                let speed          = Double.random(in: 0.05...0.12)
                var spikeTicksLeft = 0
                var spikeCPU       = 0.0

                while !Task.isCancelled {

                    if spikeTicksLeft > 0 {
                        spikeTicksLeft -= 1
                    } else if profile.spikeChance > 0,
                              Double.random(in: 0...1) < profile.spikeChance {
                        spikeTicksLeft = Int.random(in: 4...8)
                        spikeCPU = profile.baseCPU * profile.spikeMult
                    }

                    let noise  = Double.random(in: -0.2...0.2)
                    let sinVal = profile.baseCPU + profile.cpuAmplitude * sin(phase) + noise

                    let rawCPU = spikeTicksLeft > 0
                        ? spikeCPU + profile.cpuAmplitude * sin(phase) + noise
                        : sinVal

                    let clampedCPU = max(0.1, min(rawCPU, 99.9))

                    let memNoise   = Int.random(in: -4...4)
                    let mem        = profile.baseMem
                        + Int(Double(profile.memAmplitude) * sin(phase * 0.25))
                        + memNoise
                    let clampedMem = max(1, mem)

                    phase += speed

                    let memBytes   = Int64(clampedMem) * 1_048_576
                    let limitBytes = Int64(profile.memLimit) * 1_048_576

                    let stats = ContainerStats(
                        containerId:   containerId,
                        cpuUsage:      clampedCPU,
                        memoryUsage:   memBytes,
                        memoryLimit:   limitBytes,
                        memoryPercent: Double(clampedMem) / Double(profile.memLimit) * 100.0,
                        networkRx:     Int64.random(in: 3000...100000),
                        networkTx:     Int64.random(in: 1000...40000)
                    )

                    continuation.yield(stats)

                    do {
                        try await Task.sleep(nanoseconds: 1_000_000_000)
                    } catch { break }
                }
                continuation.finish()
            }

            continuation.onTermination = { _ in task.cancel() }
        }
    }
}
