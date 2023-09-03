import SwiftUI
import HealthKit

@MainActor
class 📱AppModel: NSObject, ObservableObject {
    private let api = HKHealthStore()
    
    @AppStorage(🔑Key.ableBBT) var ableBBT: Bool = false
    @AppStorage(🔑Key.ableSecondDecimalPlace) var ableSecondDecimalPlace: Bool = false
    @AppStorage(🔑Key.ableAutoComplete) var ableAutoComplete: Bool = false
    
    @Published private(set) var degreeUnit: 📏DegreeUnit = .℃
    
    @Published var bbtMode: Bool = true
    
    @Published var showResultScreen: Bool = false
    @Published var registrationSuccess: Bool = false
    @Published var canceled: Bool = false
    @Published var failedCancellation: Bool = false
    
    @Published var components: [Int] = [3]
    
    private var sampleCache: HKQuantitySample? = nil
}

extension 📱AppModel {
    var activeMode: 🏳️Mode {
        self.ableBBT && self.bbtMode ? .basalBodyTemperature : .bodyTemperature
    }
    
    func resetComponents() {
        switch self.degreeUnit {
            case .℃: self.components = [3]
            case .℉: self.components = []
        }
    }
    
    func append(_ ⓒomponent: Int) {
        self.components.append(ⓒomponent)
        if self.satisfyAutoComplete {
            self.register()
        } else {
            💥Feedback.light()
        }
    }
    
    func register() {
        Task {
            do {
                guard self.api.authorizationStatus(for: self.activeMode.type) == .sharingAuthorized else {
                    self.registrationSuccess = false
                    self.showResultScreen = true
                    return
                }
                let ⓢample = HKQuantitySample(type: self.activeMode.type,
                                              quantity: .init(unit: self.degreeUnit.value,
                                                              doubleValue: self.inputValue),
                                              start: .now,
                                              end: .now)
                self.sampleCache = ⓢample
                try await self.api.save(ⓢample)
                self.registrationSuccess = true
                self.showResultScreen = true
                💥Feedback.success()
            } catch {
                Task { @MainActor in
                    print(#function, error)
                    self.registrationSuccess = false
                    self.showResultScreen = true
                }
            }
        }
    }
    
    func setUpHealthStore(_ ⓜode: 🏳️Mode) {
        Task {
            await self.requestAuthorization(ⓜode)
            self.loadPreferredUnit()
        }
    }
    
    func loadPreferredUnit() {
        guard self.api.authorizationStatus(for: self.activeMode.type) == .sharingAuthorized else { return }
        Task {
            let ⓤnits = try await self.api.preferredUnits(for: [self.activeMode.type])
            if let ⓤnit = ⓤnits[self.activeMode.type] {
                if ⓤnit != self.degreeUnit.value {
                    self.degreeUnit.set(ⓤnit)
                    self.resetComponents()
                }
            } else {
                assertionFailure()
            }
        }
    }
    
    func cancel() {
        Task {
            do {
                guard let ⓢample = self.sampleCache else { return }
                self.canceled = true
                try await self.api.delete(ⓢample)
                self.sampleCache = nil
                💥Feedback.error()
            } catch {
                Task { @MainActor in
                    print(#function, error)
                    self.failedCancellation = true
                }
            }
        }
    }
    
    func reset() {
        self.showResultScreen = false
        self.canceled = false
        self.failedCancellation = false
        self.resetComponents()
        self.sampleCache = nil
    }
    
    var registeredValueLabel: String {
        if let ⓓoubleValue = self.sampleCache?.quantity.doubleValue(for: self.degreeUnit.value) {
            "\(ⓓoubleValue) \(self.degreeUnit)"
        } else {
            "🐛"
        }
    }
}

#if os(iOS)
extension 📱AppModel: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        self.setUpHealthStore(.bodyTemperature)
        return true
    }
}

#elseif os(watchOS)
extension 📱AppModel: WKApplicationDelegate {
    func applicationDidBecomeActive() {
        self.setUpHealthStore(.bodyTemperature)
    }
}
#endif

private extension 📱AppModel {
    private var inputValue: Double {
        switch self.components.count {
            case 3:
                Double("\(self.components[0])"
                       + "\(self.components[1])"
                       + "."
                       + "\(self.components[2])") ?? 0.0
            case 4:
                Double("\(self.components[0])"
                       + "\(self.components[1])"
                       + "."
                       + "\(self.components[2])"
                       + "\(self.components[3])") ?? 0.0
            default:
                0.0
        }
    }
    private var satisfyAutoComplete: Bool {
        self.ableAutoComplete
        && self.components.count == (self.ableSecondDecimalPlace ? 4 : 3)
    }
    private func requestAuthorization(_ ⓜode: 🏳️Mode) async {
        if self.api.authorizationStatus(for: ⓜode.type) == .notDetermined {
            do {
                try await self.api.requestAuthorization(toShare: [ⓜode.type], read: [])
            } catch {
                print(#function, error)
            }
        }
    }
}
