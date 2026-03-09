

import Foundation
import UIKit

enum OnboardingStep: Int, CaseIterable {
    case monitor = 0
    case logs    = 1
    case alerts  = 2

    var accentColor: UIColor {
        switch self {
        case .monitor: return UIColor(hex: "#4F7CFF")
        case .logs:    return UIColor(hex: "#0992C2")
        case .alerts:  return UIColor(hex: "#28C76F")
        }
    }
}
