import SwiftUI
import HealthKit

class 📱AppModel: NSObject, ObservableObject {
    private let api = HKHealthStore()
    
    @AppStorage(🔑Key.ableBBT) var ableBBT: Bool = false
    @AppStorage(🔑Key.ableSecondDecimalPlace) var ableSecondDecimalPlace: Bool = false
    @AppStorage(🔑Key.ableAutoComplete) var ableAutoComplete: Bool = false
    
    @Published var degreeUnit: 📏DegreeUnit = .℃
    
    @Published var bbtMode: Bool = true
    
    @Published var showResult: Bool = false
    @Published var registrationSuccess: Bool = false
    @Published var canceled: Bool = false
    @Published var cancelError: Bool = false
    
    @Published var components: [Int] = [3]
    
    private var sampleCache: HKQuantitySample? = nil
}

extension 📱AppModel {
    var activeMode: 🏳️Mode {
        self.ableBBT && self.bbtMode ? .basalBodyTemperature : .bodyTemperature
    }
    
    var inputValue: Double {
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
    
    func resetComponents() {
        switch self.degreeUnit {
            case .℃: self.components = [3]
            case .℉: self.components = []
        }
    }
    
    func append(_ ⓒomponent: Int) {
        self.components.append(ⓒomponent)
        if self.ableAutoComplete {
            if self.components.count == (self.ableSecondDecimalPlace ? 4 : 3) {
                Task { await self.register() }
                return
            }
        }
        💥Feedback.light()
    }
    
    @MainActor
    func register() async {
        do {
            guard self.api.authorizationStatus(for: self.activeMode.type) == .sharingAuthorized else {
                self.registrationSuccess = false
                self.showResult = true
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
            self.showResult = true
            💥Feedback.success()
        } catch {
            Task { @MainActor in
                print(#function, error)
                self.registrationSuccess = false
                self.showResult = true
            }
        }
    }
    
    func setUpHealthStore(_ ⓜode: 🏳️Mode) async {
        await self.requestAuthorization(ⓜode)
        self.loadPreferredUnit()
    }
    
    func loadPreferredUnit() {
        Task { @MainActor in
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
    
    @MainActor
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
                    self.cancelError = true
                }
            }
        }
    }
    
    func reset() {
        self.showResult = false
        self.canceled = false
        self.cancelError = false
        self.resetComponents()
        self.sampleCache = nil
    }
}

#if os(iOS)
extension 📱AppModel: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Task {
            await self.setUpHealthStore(.bodyTemperature)
            self.observePreferredUnits()
        }
        return true
    }
}

#elseif os(watchOS)
extension 📱AppModel: WKApplicationDelegate {
    func applicationDidBecomeActive() {
        Task {
            await self.setUpHealthStore(.bodyTemperature)
            self.observePreferredUnits()
        }
    }
}
#endif

private extension 📱AppModel {
    private func requestAuthorization(_ ⓜode: 🏳️Mode) async {
        if self.api.authorizationStatus(for: ⓜode.type) == .notDetermined {
            do {
                try await self.api.requestAuthorization(toShare: [ⓜode.type], read: [])
            } catch {
                print(#function, error)
            }
        }
    }
    
    private func observePreferredUnits() { //MARK: うまく動作してないかも？
        Task {
            for ⓣype: HKQuantityType in [.init(.bodyTemperature), .init(.basalBodyTemperature)] {
                let ⓠuery = HKObserverQuery(sampleType: ⓣype, predicate: nil) { _, ⓒompletionHandler, ⓔrror in
                    if let ⓔrror {
                        print("🚨", ⓔrror, ⓔrror.localizedDescription)
                        return
                    }
                    self.loadPreferredUnit()
                    ⓒompletionHandler()
                }
                self.api.execute(ⓠuery)
                //try await self.api.enableBackgroundDelivery(for: ⓣype, frequency: .immediate) //TODO: 削除検討
            }
        }
    }
}
