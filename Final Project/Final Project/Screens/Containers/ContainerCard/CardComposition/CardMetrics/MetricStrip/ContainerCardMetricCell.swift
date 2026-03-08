//
//  ContainerCardMetricCell.swift
//  Final Project
//
//  Created by SabinaKarimli on 04.03.26.
//



import SwiftUI

struct ContainerCardMetricCell: View {
    let icon: String
    let label: String
    let value: String
    let progress: Double
    let color: Color

    var body: some View {
        HStack(spacing: 8) {
            VStack(alignment: .leading, spacing: 3) {
                HStack(spacing: 3) {
                    Image(systemName: icon)
                        .font(.system(size: 8, weight: .bold))
                        .foregroundColor(DS.Color.textMuted)

                    Text(label)
                        .font(DS.Font.label(8))
                        .foregroundColor(DS.Color.textMuted)
                        .tracking(0.8)
                }

                Text(value)
                    .font(.system(size: 13, weight: .bold, design: .rounded))
                    .foregroundColor(color)
            }

            GeometryReader { g in
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(DS.Color.bg4)
                        .frame(height: 4)

                    Capsule()
                        .fill(
                            LinearGradient(
                                colors: [color.opacity(0.7), color],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                        .frame(
                            width: max(0, g.size.width * CGFloat(min(1, max(0, progress)))),
                            height: 4
                        )
                        .shadow(color: color.opacity(0.5), radius: 3)
                        .animation(DS.Anim.smooth, value: progress)
                }
                .frame(maxHeight: .infinity, alignment: .center)
            }
            .frame(height: 16)
        }
        .padding(.horizontal, 14)
        .frame(maxWidth: .infinity)
        .padding(.vertical, 9)
    }
}
