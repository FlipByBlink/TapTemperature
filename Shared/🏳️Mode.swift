import SwiftUI
import HealthKit

enum 🏳️Mode {
    case bodyTemperature, basalBodyTemperature
}

extension 🏳️Mode {
    var type: HKQuantityType {
        switch self {
            case .bodyTemperature: .init(.bodyTemperature)
            case .basalBodyTemperature: .init(.basalBodyTemperature)
        }
    }
    var label: LocalizedStringKey {
        switch self {
            case .bodyTemperature: "Body temperature"
            case .basalBodyTemperature: "Basal body temperature"
        }
    }
}
