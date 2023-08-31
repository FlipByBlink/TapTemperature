import SwiftUI
import HealthKit

class 📱AppModel: ObservableObject {
    private let 🏥healthStore = HKHealthStore()
    
    @AppStorage(🔑BasalBodyTemperature) var 🚩bbtOption: Bool = false
    @AppStorage(🔑SecondDecimalPlace) var 🚩secondDecimalPlaceOption: Bool = false
    @AppStorage(🔑AutoComplete) var 🚩autoCompleteOption: Bool = false
    
    @Published var 📏unitOption: 📏DegreeUnit = .℃
    
    @Published var 🛏bbtSwitch: Bool = true
    
    var ⓣarget: 🅃arget {
        self.🚩bbtOption && self.🛏bbtSwitch ? .basalBodyTemperature : .bodyTemperature
    }
    
    @Published var 🚩showResult: Bool = false
    @Published var 🚩registerSuccess: Bool = false
    @Published var 🚩canceled: Bool = false
    @Published var 🚨cancelError: Bool = false
    
    @Published var 🧩components: [Int] = [3]
    
    var 🌡value: Double {
        if self.🧩components.count < 3 { return 0.0 }
        var ⓥalue = Double(self.🧩components[0].description
                           + self.🧩components[1].description
                           + "."
                           + self.🧩components[2].description)!
        if self.🧩components.indices.contains(3) {
            ⓥalue = Double(ⓥalue.description + self.🧩components[3].description)!
        }
        return ⓥalue
    }
    
    func 🧩resetComponents() {
        switch self.📏unitOption {
            case .℃: self.🧩components = [3]
            case .℉: self.🧩components = []
        }
    }
    
    func 🧩appendComponent(_ ⓘnt: Int) {
        self.🧩components.append(ⓘnt)
        if self.🚩autoCompleteOption {
            if self.🧩components.count == (self.🚩secondDecimalPlaceOption ? 4 : 3) {
                Task { await self.👆register() }
                return
            }
        }
        💥Feedback.light()
    }
    
    private var 📦sampleCache: HKQuantitySample?
    
    @MainActor
    func 👆register() async {
        do {
            if self.🏥healthStore.authorizationStatus(for: self.ⓣarget.quantityType) == .sharingDenied {
                self.🚩registerSuccess = false
                self.🚩showResult = true
                return
            }
            
            let 📦sample = HKQuantitySample(type: self.ⓣarget.quantityType,
                                            quantity: HKQuantity(unit: self.📏unitOption.hkUnit,
                                                                 doubleValue: self.🌡value),
                                            start: .now,
                                            end: .now)
            
            self.📦sampleCache = 📦sample
            try await self.🏥healthStore.save(📦sample)
            
            self.🚩registerSuccess = true
            self.🚩showResult = true
            💥Feedback.success()
        } catch {
            DispatchQueue.main.async {
                print(#function, error)
                self.🚩registerSuccess = false
                self.🚩showResult = true
            }
        }
    }
    
    func 🏥setUp(_ ⓘdentifier: HKQuantityTypeIdentifier) async {
        await self.🏥requestAuthorization(ⓘdentifier)
        self.🏥loadPreferredUnit()
    }
    
    private func 🏥requestAuthorization(_ ⓘdentifier: HKQuantityTypeIdentifier) async {
        if self.🏥healthStore.authorizationStatus(for: self.ⓣarget.quantityType) == .notDetermined {
            do {
                try await self.🏥healthStore.requestAuthorization(toShare: [self.ⓣarget.quantityType],
                                                                  read: [])
            } catch {
                print(#function, error)
            }
        }
    }
    
    func 🏥loadPreferredUnit() {
        Task { @MainActor in
            let ⓤnits = try await self.🏥healthStore.preferredUnits(for: [self.ⓣarget.quantityType])
            if let ⓤnit = ⓤnits[self.ⓣarget.quantityType] {
                if ⓤnit != self.📏unitOption.hkUnit {
                    switch ⓤnit {
                        case .degreeCelsius(): self.📏unitOption = .℃
                        case .degreeFahrenheit(): self.📏unitOption = .℉
                        default: assertionFailure()
                    }
                    self.🧩resetComponents()
                }
            } else {
                assertionFailure()
            }
        }
    }
    
    func 🏥observePreferredUnits() {
        Task {
            for ⓣype in [HKQuantityType(.bodyTemperature), HKQuantityType(.basalBodyTemperature)] {
                let ⓠuery = HKObserverQuery(sampleType: ⓣype, predicate: nil) { _, ⓒompletionHandler, ⓔrror in
                    if ⓔrror != nil { return }
                    self.🏥loadPreferredUnit()
                    ⓒompletionHandler()
                }
                self.🏥healthStore.execute(ⓠuery)
                try await self.🏥healthStore.enableBackgroundDelivery(for: ⓣype,
                                                                      frequency: .immediate)
            }
        }
    }
    
    @MainActor
    func 🗑cancel() {
        Task {
            do {
                guard let 📦 = self.📦sampleCache else { return }
                self.🚩canceled = true
                try await self.🏥healthStore.delete(📦)
                self.📦sampleCache = nil
                💥Feedback.error()
            } catch {
                DispatchQueue.main.async {
                    print(#function, error)
                    self.🚨cancelError = true
                }
            }
        }
    }
    
    func ⓡeset() {
        self.🚩showResult = false
        self.🚩canceled = false
        self.🚨cancelError = false
        self.🧩resetComponents()
        self.📦sampleCache = nil
    }
    
    init() {
        Task {
            await self.🏥setUp(.bodyTemperature)
            self.🏥observePreferredUnits()
        }
    }
}

enum 🅃arget {
    case bodyTemperature, basalBodyTemperature
    var isBT: Bool { self == .bodyTemperature }
    var quantityType: HKQuantityType {
        HKQuantityType(self.isBT ? .bodyTemperature : .basalBodyTemperature)
    }
}

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

// Key for data.
let 🔑BasalBodyTemperature = "BasalTemp"
let 🔑SecondDecimalPlace = "2DecimalPlace"
let 🔑AutoComplete = "AutoComplete"
