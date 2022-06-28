
import SwiftUI
import HealthKit

class 📱AppModel: ObservableObject {
    
    let 🏥HealthStore = HKHealthStore()
    
    
    @AppStorage("Unit") var 📏Unit: 📏DegreeUnit = .℃
    
    @AppStorage("BasalTemp") var 🚩BasalTemp: Bool = false
    
    @AppStorage("2DecimalPlace") var 🚩2DecimalPlace: Bool = false
    
    @AppStorage("AutoComplete") var 🚩AutoComplete: Bool = false
    
    
    @Published var 🛏BasalSwitch: Bool = true
    
    @Published var 🚩ShowResult: Bool = false
    
    @Published var 🚩RegisterSuccess: Bool = false //TODO: Optionalにするか検討
    
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
        switch 📏Unit {
            case .℃: 🧩Temp = [3]
            case .℉: 🧩Temp = []
        }
    }
    
    
    func 🧩AppendTemp(_ 🔢: Int) {
        🧩Temp.append(🔢)
        
        if 🚩AutoComplete {
            if 🧩Temp.count == (🚩2DecimalPlace ? 4 : 3) {
                Task {
                    await 👆Register()
                }
                return
            }
        }
        
        UISelectionFeedbackGenerator().selectionChanged()
    }
    
    
    var 📦Sample: HKQuantitySample?
    
    @MainActor
    func 👆Register() async {
        do {
            let 🚩BasalTempInput = 🚩BasalTemp && 🛏BasalSwitch
            
            🕒History += Date.now.formatted(date: .numeric, time: .shortened) + ", "
            🕒History += 🚩BasalTempInput ? "BBT, " : "BT, "
            
            let 🅃ype = HKQuantityType(🚩BasalTempInput ? .basalBodyTemperature : .bodyTemperature)
            
            if 🏥HealthStore.authorizationStatus(for: 🅃ype) == .sharingDenied {
                🚩RegisterSuccess = false
                🚩ShowResult = true
                
                🕒History += ".authorization: Error?!\n"
                
                return
            }
            
            let 📦 = HKQuantitySample(type: 🅃ype,
                                        quantity: HKQuantity(unit: 📏Unit.ⒽKUnit, doubleValue: 🌡Temp),
                                        start: .now, end: .now)
            
            📦Sample = 📦
            
            try await 🏥HealthStore.save(📦)
            
            🕒History += 📏Unit.rawValue + ", " + 🌡Temp.description + "\n"
            
            🚩RegisterSuccess = true
            🚩ShowResult = true
        
            UINotificationFeedbackGenerator().notificationOccurred(.success)
        } catch {
            DispatchQueue.main.async {
                print(#function, error)
                self.🚩RegisterSuccess = false
                self.🕒History += ".save Error?! " + error.localizedDescription + "\n"
                self.🚩ShowResult = true
            }
        }
//        🏥HealthStore.save(📦) { 🙆, 🙅 in
//            if 🙆 {
//                print(".save: Success")
//
//                DispatchQueue.main.async {
//                    self.🕒History += self.📏Unit.rawValue + ", " + self.🌡Temp.description + "\n"
//
//                    self.🚩RegisterSuccess = true
//                    self.🚩ShowResult = true
//                }
//
//                UINotificationFeedbackGenerator().notificationOccurred(.success)
//            } else {
//                print("🙅:", 🙅.debugDescription)
//
//                DispatchQueue.main.async {
//                    self.🕒History += ".save: Error?!\n"
//
//                    self.🚩RegisterSuccess = false
//                    self.🚩ShowResult = true
//                }
//            }
//        }
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
                guard let 📦 = 📦Sample else { return }
            
                🚩Canceled = true
                
                try await 🏥HealthStore.delete(📦)
                
                📦Sample = nil
                
                🕒History += Date.now.formatted(date: .numeric, time: .shortened) + ", "
                🕒History += "Cancel: Success\n"
                
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
        🚩RegisterSuccess = false
        //🚨RegisterError = false
        🚩Canceled = false
        🚨CancelError = false
        🧩ResetTemp()
        📦Sample = nil
    }
}


enum 📏DegreeUnit: String, CaseIterable {
    case ℃
    case ℉
    
    var ⒽKUnit: HKUnit {
        switch self {
            case .℃: return .degreeCelsius()
            case .℉: return .degreeFahrenheit()
        }
    }
}
