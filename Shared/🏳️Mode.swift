import SwiftUI
import HealthKit

enum 🏳️Mode {
    case bodyTemperature, basalBodyTemperature
}

extension 🏳️Mode {
    var quantityType: HKQuantityType {
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
    var navigationTitle: LocalizedStringKey {
        switch self {
#if os(iOS)
            case .bodyTemperature: "Body temperature"
#elseif os(watchOS)
            case .bodyTemperature: "Temperature"
#endif
            case .basalBodyTemperature: "BBT"
        }
    }
}
