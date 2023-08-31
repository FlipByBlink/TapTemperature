import SwiftUI
import HealthKit
import WatchConnectivity

class 📱AppModel: NSObject, ObservableObject {
    private let healthStore = HKHealthStore()
    
    @AppStorage(🔑BasalBodyTemperature) var ableBBT: Bool = false
    @AppStorage(🔑SecondDecimalPlace) var ableSecondDecimalPlace: Bool = false
    @AppStorage(🔑AutoComplete) var ableAutoComplete: Bool = false
    
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
    var target: 🅃arget {
        self.ableBBT && self.bbtMode ? .basalBodyTemperature : .bodyTemperature
    }
    
    var inputValue: Double {
        if self.components.count < 3 { return 0.0 }
        var ⓥalue = Double(self.components[0].description
                           + self.components[1].description
                           + "."
                           + self.components[2].description)!
        if self.components.indices.contains(3) {
            ⓥalue = Double(ⓥalue.description + self.components[3].description)!
        }
        return ⓥalue
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
            if self.healthStore.authorizationStatus(for: self.target.quantityType) == .sharingDenied {
                self.registrationSuccess = false
                self.showResult = true
                return
            }
            let ⓢample = HKQuantitySample(type: self.target.quantityType,
                                          quantity: .init(unit: self.degreeUnit.hkUnit,
                                                          doubleValue: self.inputValue),
                                          start: .now,
                                          end: .now)
            self.sampleCache = ⓢample
            try await self.healthStore.save(ⓢample)
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
    
    func setUpHealthStore(_ ⓘdentifier: HKQuantityTypeIdentifier) async {
        await self.requestAuthorization(ⓘdentifier)
        self.loadPreferredUnit()
    }
    
    func loadPreferredUnit() {
        Task { @MainActor in
            let ⓤnits = try await self.healthStore.preferredUnits(for: [self.target.quantityType])
            if let ⓤnit = ⓤnits[self.target.quantityType] {
                if ⓤnit != self.degreeUnit.hkUnit {
                    switch ⓤnit {
                        case .degreeCelsius(): self.degreeUnit = .℃
                        case .degreeFahrenheit(): self.degreeUnit = .℉
                        default: assertionFailure()
                    }
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
                guard let 📦 = self.sampleCache else { return }
                self.canceled = true
                try await self.healthStore.delete(📦)
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
    
    func syncAppleWatch() {
        do {
            try WCSession.default.updateApplicationContext([🔑BasalBodyTemperature: self.ableBBT,
                                                              🔑SecondDecimalPlace: self.ableSecondDecimalPlace,
                                                                    🔑AutoComplete: self.ableAutoComplete])
        } catch {
            print("🚨", error.localizedDescription)
        }
    }
}

extension 📱AppModel: WCSessionDelegate {
    //==== Required(watchOS, iOS) ====
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print(#function)
    }
#if os(iOS)
    //==== Required ====
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    
    //==== Required ====
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
#elseif os(watchOS)
    //==== Optional ====
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("🖨️", #function, applicationContext.description)
        Task { @MainActor in
            if let ⓥalue = applicationContext[🔑BasalBodyTemperature] as? Bool {
                self.ableBBT = ⓥalue
            }
            if let ⓥalue = applicationContext[🔑SecondDecimalPlace] as? Bool {
                self.ableSecondDecimalPlace = ⓥalue
            }
            if let ⓥalue = applicationContext[🔑AutoComplete] as? Bool {
                self.ableAutoComplete = ⓥalue
            }
        }
    }
#endif
}

#if os(iOS)
extension 📱AppModel: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        Task { 
            await self.setUpHealthStore(.bodyTemperature)
            self.observePreferredUnits()
        }
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
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
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
}
#endif

private extension 📱AppModel {
    private func requestAuthorization(_ ⓘdentifier: HKQuantityTypeIdentifier) async { //TODO: 引数おかしい？
        if self.healthStore.authorizationStatus(for: self.target.quantityType) == .notDetermined {
            do {
                try await self.healthStore.requestAuthorization(toShare: [self.target.quantityType],
                                                                read: [])
            } catch {
                print(#function, error)
            }
        }
    }
    
    private func observePreferredUnits() {
        Task {
            for ⓣype: HKQuantityType in [.init(.bodyTemperature), .init(.basalBodyTemperature)] {
                let ⓠuery = HKObserverQuery(sampleType: ⓣype, predicate: nil) { _, ⓒompletionHandler, ⓔrror in
                    if ⓔrror != nil { return }
                    self.loadPreferredUnit()
                    ⓒompletionHandler()
                }
                self.healthStore.execute(ⓠuery)
                try await self.healthStore.enableBackgroundDelivery(for: ⓣype,
                                                                    frequency: .immediate)
            }
        }
    }
}

enum 🅃arget {
    case bodyTemperature, basalBodyTemperature
    var isBT: Bool { self == .bodyTemperature }
    var quantityType: HKQuantityType {
        .init(self.isBT ? .bodyTemperature : .basalBodyTemperature)
    }
}

// Key for data.
let 🔑BasalBodyTemperature = "BasalTemp"
let 🔑SecondDecimalPlace = "2DecimalPlace"
let 🔑AutoComplete = "AutoComplete"
