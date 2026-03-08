
import SwiftUI

struct ContainerCard: View {
    let container: ContainerInfo
    let stats: ContainerStats?
    var index: Int = 0
    var onTap: (() -> Void)? = nil

    @State private var appeared = false
    @State private var pressed  = false

    private var cpuThr: Double { AlertSeverityHelper.Threshold.cpuHigh }
    private var memThr: Double { AlertSeverityHelper.Threshold.memHigh }

    private var cpuPct: Double {
        guard let s = stats else { return 0 }
        
        return min(max(s.cpuUsage, 0), 100)
    }

    private var memPct: Double {
        guard let s = stats else { return 0 }
        if s.memoryLimit > 0 {
            let computed = Double(s.memoryUsage) / Double(s.memoryLimit) * 100.0
            if computed.isFinite { return min(max(computed, 0), 100) }
        }
        
        return min(max(s.memoryPercent, 0), 100)
    }

    private var stateColor: Color {
        container.isRunning ? DS.Color.success : DS.Color.textMuted
    }

    private var cpuColor: Color {
        cpuPct >= cpuThr ? DS.Color.danger
            : cpuPct >= cpuThr * 0.85 ? DS.Color.warning
            : DS.Color.success
    }

    private var memColor: Color {
        memPct >= memThr ? DS.Color.danger
            : memPct >= memThr * 0.85 ? DS.Color.warning
            : DS.Color.accentSoft
    }

    private var iconStyle: ContainerCardIconStyle {
        ContainerCardIconStyle(
            container: container,
            isSystemCritical: container.isSystemCritical
        )
    }

    var body: some View {
        Button(action: { onTap?() }) {
            HStack(spacing: 0) {
                RoundedRectangle(cornerRadius: 2)
                    .fill(LinearGradient(
                        colors: [stateColor, stateColor.opacity(0.3)],
                        startPoint: .top, endPoint: .bottom
                    ))
                    .frame(width: 3)
                    .padding(.vertical, 12)

                VStack(spacing: 0) {
                    ContainerCardMainRow(
                        container: container,
                        iconColor: iconStyle.iconColor,
                        iconSymbol: iconStyle.iconSymbol,
                        isSystemCritical: container.isSystemCritical
                    )

                    if container.isRunning {
                        Rectangle().fill(DS.Color.cardBorder).frame(height: 1)
                        ContainerCardMetricStrip(
                            stats: stats,
                            cpuPct: cpuPct,
                            memPct: memPct,
                            cpuColor: cpuColor,
                            memColor: memColor
                        )
                    }
                }
            }
            .background(ContainerCardBackground(
                isRunning: container.isRunning,
                stateColor: stateColor
            ))
            .clipShape(RoundedRectangle(cornerRadius: DS.Radius.md))
            .overlay(
                RoundedRectangle(cornerRadius: DS.Radius.md)
                    .stroke(
                        LinearGradient(
                            colors: [
                                stateColor.opacity(container.isRunning ? 0.25 : 0.08),
                                DS.Color.cardBorder.opacity(0.5)
                            ],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        ),
                        lineWidth: 1
                    )
            )
            .shadow(
                color: container.isRunning ? stateColor.opacity(0.08) : .black.opacity(0.28),
                radius: pressed ? 4 : 16, x: 0, y: pressed ? 2 : 6
            )
            .scaleEffect(pressed ? 0.985 : 1)
            .animation(DS.Anim.fast, value: pressed)
        }
        .buttonStyle(.plain)
        .onLongPressGesture(
            minimumDuration: 0,
            maximumDistance: 10,
            pressing: { isPressing in
                withAnimation(DS.Anim.fast) { pressed = isPressing }
            },
            perform: {}
        )
        .opacity(appeared ? 1 : 0)
        .offset(y: appeared ? 0 : 12)
        .onAppear {
            withAnimation(DS.Anim.spring.delay(Double(index) * 0.04)) { appeared = true }
        }
    }
}
