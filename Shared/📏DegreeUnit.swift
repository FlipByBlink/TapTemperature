import HealthKit

enum 📏DegreeUnit: String, CaseIterable, Identifiable {
    case ℃, ℉
    var id: Self { self }
    var value: HKUnit {
        switch self {
            case .℃: .degreeCelsius()
            case .℉: .degreeFahrenheit()
        }
    }
    mutating func set(_ ⓗkUnit: HKUnit) {
        switch ⓗkUnit {
            case .degreeCelsius(): self = .℃
            case .degreeFahrenheit(): self = .℉
            default: assertionFailure()
        }
    }
}
