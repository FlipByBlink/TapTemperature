
import SwiftUI
import HealthKit

class 📱AppModel: ObservableObject {
    
    let 🏥HealthStore = HKHealthStore()
    
    
    @AppStorage("BasalTemp") var 🚩BasalTempOption: Bool = false
    
    @AppStorage("2DecimalPlace") var 🚩2DecimalPlaceOption: Bool = false
    
    @AppStorage("AutoComplete") var 🚩AutoCompleteOption: Bool = false
    
    @AppStorage("Unit") var 📏UnitOption: 📏DegreeUnit = .℃ {
        didSet {
            🧩ResetTemp()
        }
    }
    
    
    @Published var 🛏BasalSwitch: Bool = true
    
    @Published var 🚩ShowResult: Bool = false
    
    @Published var 🚩RegisterSuccess: Bool = false
    
    @Published var 🚩Canceled: Bool = false
    
    @Published var 🚨CancelError: Bool = false
    
    @AppStorage("history") var 🕒History: String = ""
    
    
    @Published var 🧩Temp: [Int] = []
    
    var 🌡Temp: Double {
        if 🧩Temp.count < 3 { return 0.0 }
        
        var 🌡 = Double(🧩Temp[0].description
                        + 🧩Temp[1].description
                        + "."
                        + 🧩Temp[2].description)!
        
        if 🧩Temp.indices.contains(3) {
            🌡 = Double(🌡.description + 🧩Temp[3].description)!
        }
        
        return 🌡
    }
    
    
    func 🧩ResetTemp() {
        switch 📏UnitOption {
            case .℃: 🧩Temp = [3]
            case .℉: 🧩Temp = []
        }
    }
    
    
    func 🧩AppendTemp(_ 🔢: Int) {
        🧩Temp.append(🔢)
        
        if 🚩AutoCompleteOption {
            if 🧩Temp.count == (🚩2DecimalPlaceOption ? 4 : 3) {
                Task {
                    await 👆Register()
                }
                return
            }
        }
        
        UISelectionFeedbackGenerator().selectionChanged()
    }
    
    
    var 📦SampleCache: HKQuantitySample?
    
    @MainActor
    func 👆Register() async {
        do {
            let 🚩BasalTempInput = 🚩BasalTempOption && 🛏BasalSwitch
            
            🕒History += Date.now.formatted(date: .numeric, time: .shortened) + ", "
            🕒History += 🚩BasalTempInput ? "BBT, " : "BT, "
            
            let 🅃ype = HKQuantityType(🚩BasalTempInput ? .basalBodyTemperature : .bodyTemperature)
            
            if 🏥HealthStore.authorizationStatus(for: 🅃ype) == .sharingDenied {
                🚩RegisterSuccess = false
                🚩ShowResult = true
                
                🕒History += ".authorization: Error?!\n"
                
                return
            }
            
            let 📦Sample = HKQuantitySample(type: 🅃ype,
                                        quantity: HKQuantity(unit: 📏UnitOption.ⒽKUnit, doubleValue: 🌡Temp),
                                        start: .now, end: .now)
            
            📦SampleCache = 📦Sample
            
            try await 🏥HealthStore.save(📦Sample)
            
            🕒History += 📏UnitOption.rawValue + ", " + 🌡Temp.description + "\n"
            
            🚩RegisterSuccess = true
            🚩ShowResult = true
        
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        } catch {
            DispatchQueue.main.async {
                print(#function, error)
                self.🕒History += ".save Error?! " + error.localizedDescription + "\n"
                self.🚩RegisterSuccess = false
                self.🚩ShowResult = true
            }
        }
    }
    
    
    func 🏥RequestAuthorization(_ ⓘdentifier: HKQuantityTypeIdentifier) {
        let 🅃ype: HKSampleType = HKQuantityType(ⓘdentifier)
        if 🏥HealthStore.authorizationStatus(for: 🅃ype) == .notDetermined {
            Task {
                do {
                    try await 🏥HealthStore.requestAuthorization(toShare: [🅃ype], read: [])
                } catch {
                    print(#function, error)
                }
            }
        }
    }
    
    
    @MainActor
    func 🗑Cancel() {
        Task {
            do {
                guard let 📦 = 📦SampleCache else { return }
            
                🚩Canceled = true
                
                🕒History += Date.now.formatted(date: .numeric, time: .shortened) + ", "
                
                try await 🏥HealthStore.delete(📦)
                
                🕒History += "Cancel: Success\n"
                
                📦SampleCache = nil
                
                UINotificationFeedbackGenerator().notificationOccurred(.error)
            } catch {
                DispatchQueue.main.async {
                    print(#function, error)
                    self.🕒History += "Cancel: Error?! " + error.localizedDescription + "\n"
                    self.🚨CancelError = true
                }
            }
        }
    }
    
    
    func 🅁eset() {
        🚩ShowResult = false
        🚩Canceled = false
        🚨CancelError = false
        🧩ResetTemp()
        📦SampleCache = nil
    }
}


enum 📏DegreeUnit: String, CaseIterable, Identifiable {
    case ℃
    case ℉
    
    var id: Self { self }
    
    var ⒽKUnit: HKUnit {
        switch self {
            case .℃: return .degreeCelsius()
            case .℉: return .degreeFahrenheit()
        }
    }
}
