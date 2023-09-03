import SwiftUI
import HealthKit

@MainActor
class 📱AppModel: NSObject, ObservableObject {
    private let api = HKHealthStore()
    
    @AppStorage(🔑Key.ableBBT) var ableBBT: Bool = false
    @AppStorage(🔑Key.ableSecondDecimalPlace) var ableSecondDecimalPlace: Bool = false
    @AppStorage(🔑Key.ableAutoComplete) var ableAutoComplete: Bool = false
    
    @Published private(set) var degreeUnit: 📏DegreeUnit = .℃
    
    @Published private(set) var bbtMode: Bool = true
    
    @Published var showResultScreen: Bool = false
    @Published private(set) var registrationSuccess: Bool = false
    @Published private(set) var processingUndo: Bool = false
    @Published private(set) var undid: Bool = false
    @Published private(set) var failedUndo: Bool = false
    
    @Published private(set) var components: [Int] = [3]
    
    private var sampleCache: HKQuantitySample? = nil
}

extension 📱AppModel {
    var activeMode: 🏳️Mode {
        self.ableBBT && self.bbtMode ? .basalBodyTemperature : .bodyTemperature
    }
    
    func toggleBBTMode() {
        self.bbtMode.toggle()
        💥Feedback.light()
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
    
    func removeLast() {
        self.components.removeLast()
        💥Feedback.light()
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
                print(#function, error)
                self.registrationSuccess = false
                self.showResultScreen = true
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
    
    func undo() {
        Task {
            guard let ⓢample = self.sampleCache else { return }
            self.processingUndo = true
            do {
                try await self.api.delete(ⓢample)
                self.undid = true
                💥Feedback.error()
            } catch {
                print(#function, error)
                self.undid = true
                self.failedUndo = true
            }
            self.processingUndo = false
        }
    }
    
    var registeredValueLabel: String {
        if let ⓓoubleValue = self.sampleCache?.quantity.doubleValue(for: self.degreeUnit.value) {
            "\(ⓓoubleValue) \(self.degreeUnit)"
        } else {
            "🐛"
        }
    }
    
    func reset() {
        self.showResultScreen = false
        self.undid = false
        self.failedUndo = false
        self.resetComponents()
        self.sampleCache = nil
    }
    
    func clearRegistrationState() {
        self.registrationSuccess = false
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
