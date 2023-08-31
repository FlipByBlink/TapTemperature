import HealthKit

enum 📏DegreeUnit: String, CaseIterable, Identifiable {
    case ℃, ℉
    var id: Self { self }
    var hkUnit: HKUnit {
        switch self {
            case .℃: .degreeCelsius()
            case .℉: .degreeFahrenheit()
        }
    }
}
