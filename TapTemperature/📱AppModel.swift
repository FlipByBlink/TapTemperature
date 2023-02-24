import SwiftUI
import HealthKit

class 📱AppModel: ObservableObject {
    private let 🏥healthStore = HKHealthStore()
    
    @AppStorage("BasalTemp") var 🚩basalTempOption: Bool = false
    @AppStorage("2DecimalPlace") var 🚩secondDecimalPlaceOption: Bool = false
    @AppStorage("AutoComplete") var 🚩autoCompleteOption: Bool = false
    @AppStorage("Unit") var 📏unitOption: 📏DegreeUnit = .℃ {
        didSet { self.🧩resetComponents() }
    }
    
    @Published var 🛏basalSwitch: Bool = true
    @Published var 🚩showResult: Bool = false
    @Published var 🚩registerSuccess: Bool = false
    @Published var 🚩canceled: Bool = false
    @Published var 🚨cancelError: Bool = false
    @AppStorage("history") var 🕒history: String = ""
    
    @Published var 🧩components: [Int] = []
    
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
            case .℃:
                self.🧩components = [3]
            case .℉:
                self.🧩components = []
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
        UISelectionFeedbackGenerator().selectionChanged()
    }
    
    private var 📦sampleCache: HKQuantitySample?
    
    @MainActor
    func 👆register() async {
        do {
            let 🚩basalTempInput = self.🚩basalTempOption && self.🛏basalSwitch
            
            self.🕒history += Date.now.formatted(date: .numeric, time: .shortened) + ", "
            self.🕒history += 🚩basalTempInput ? "BBT, " : "BT, "
            
            let ⓣype = HKQuantityType(🚩basalTempInput ? .basalBodyTemperature : .bodyTemperature)
            
            if self.🏥healthStore.authorizationStatus(for: ⓣype) == .sharingDenied {
                self.🚩registerSuccess = false
                self.🚩showResult = true
                self.🕒history += ".authorization: Error?!\n"
                return
            }
            
            let 📦sample = HKQuantitySample(type: ⓣype,
                                            quantity: HKQuantity(unit: self.📏unitOption.hkUnit,
                                                                 doubleValue: self.🌡value),
                                            start: .now,
                                            end: .now)
            
            self.📦sampleCache = 📦sample
            try await self.🏥healthStore.save(📦sample)
            
            self.🕒history += self.📏unitOption.rawValue + ", " + self.🌡value.description + "\n"
            self.🚩registerSuccess = true
            self.🚩showResult = true
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        } catch {
            DispatchQueue.main.async {
                print(#function, error)
                self.🕒history += ".save Error?! " + error.localizedDescription + "\n"
                self.🚩registerSuccess = false
                self.🚩showResult = true
            }
        }
    }
    
    func 🏥requestAuthorization(_ ⓘdentifier: HKQuantityTypeIdentifier) {
        let ⓣype: HKSampleType = HKQuantityType(ⓘdentifier)
        if self.🏥healthStore.authorizationStatus(for: ⓣype) == .notDetermined {
            Task {
                do {
                    try await self.🏥healthStore.requestAuthorization(toShare: [ⓣype], read: [])
                } catch {
                    print(#function, error)
                }
            }
        }
    }
    
    @MainActor
    func 🗑cancel() {
        Task {
            do {
                guard let 📦 = self.📦sampleCache else { return }
                self.🚩canceled = true
                self.🕒history += Date.now.formatted(date: .numeric, time: .shortened) + ", "
                try await self.🏥healthStore.delete(📦)
                self.🕒history += "Cancel: Success\n"
                self.📦sampleCache = nil
                UINotificationFeedbackGenerator().notificationOccurred(.error)
            } catch {
                DispatchQueue.main.async {
                    print(#function, error)
                    self.🕒history += "Cancel: Error?! " + error.localizedDescription + "\n"
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
}

enum 📏DegreeUnit: String, CaseIterable, Identifiable {
    case ℃, ℉
    var id: Self { self }
    var hkUnit: HKUnit {
        switch self {
            case .℃: return .degreeCelsius()
            case .℉: return .degreeFahrenheit()
        }
    }
}
