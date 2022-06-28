
import SwiftUI
import HealthKit

class 📱AppModel: ObservableObject {
    
    @AppStorage("Unit") var 📏Unit: 📏DegreeUnit = .℃
    
    @AppStorage("BasalTemp") var 🚩BasalTemp: Bool = false
    
    @AppStorage("2DecimalPlace") var 🚩2DecimalPlace: Bool = false
    
    @AppStorage("AutoComplete") var 🚩AutoComplete: Bool = false
    
    
    @Published var 🧩Temp: [Int] = []
    
    
    @Published var 🛏BasalSwitch: Bool = true
    
    @Published var 🚩ShowResult: Bool = false
    
    @Published var 🚩Success: Bool = false
    
    @Published var 🚩Canceled: Bool = false
    
    
    @AppStorage("history") var 🕒History: String = ""
    
    
    let 🏥HealthStore = HKHealthStore()
    
    
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
    
    
    func 🧩Reset() {
        switch 📏Unit {
            case .℃: 🧩Temp = [3]
            case .℉: 🧩Temp = []
        }
    }
    
    
    func 🧩Append(_ 🔢: Int) {
        🧩Temp.append(🔢)
        
        if 🚩AutoComplete {
            if 🧩Temp.count == (🚩2DecimalPlace ? 4 : 3) {
                🚀Done()
                return
            }
        }
        
        UISelectionFeedbackGenerator().selectionChanged()
    }
    
    
    var 📃Sample: HKQuantitySample?
    
    func 🚀Done() {
        let 🚩BasalTempInput = 🚩BasalTemp && 🛏BasalSwitch
        
        🕒History += Date.now.formatted(date: .numeric, time: .shortened) + ", "
        🕒History += 🚩BasalTempInput ? "BBT, " : "BT, "
        
        
        let 🅃ype = HKQuantityType(🚩BasalTempInput ? .basalBodyTemperature : .bodyTemperature)
        
        if 🏥HealthStore.authorizationStatus(for: 🅃ype) == .sharingDenied {
            🚩Success = false
            🚩ShowResult = true
            
            🕒History += ".authorization: Error?!\n"
            
            return
        }
        
        let 📃 = HKQuantitySample(type: 🅃ype,
                                    quantity: HKQuantity(unit: 📏Unit.ⒽKUnit, doubleValue: 🌡Temp),
                                    start: .now,
                                    end: .now)
        
        📃Sample = 📃
        
        🏥HealthStore.save(📃) { 🙆, 🙅 in
            if 🙆 {
                print(".save: Success")
                
                DispatchQueue.main.async {
                    self.🕒History += self.📏Unit.rawValue + ", " + self.🌡Temp.description + "\n"
                    
                    self.🚩Success = true
                    self.🚩ShowResult = true
                }
                
                UINotificationFeedbackGenerator().notificationOccurred(.success)
            } else {
                print("🙅:", 🙅.debugDescription)
                
                DispatchQueue.main.async {
                    self.🕒History += ".save: Error?!\n"
                    
                    self.🚩Success = false
                    self.🚩ShowResult = true
                }
            }
        }
    }
    
    
    func 🗑Cancel() {
        guard let 📃 = 📃Sample else { return }
        
        🏥HealthStore.delete(📃) { 🙆, 🙅 in
            if 🙆 {
                print(".delete: Success")
                
                DispatchQueue.main.async {
                    self.🚩Canceled = true
                    self.🕒History += "Cancellation: success\n"
                }
                
                UINotificationFeedbackGenerator().notificationOccurred(.error)
            } else {
                print("🙅:", 🙅.debugDescription)
                
                DispatchQueue.main.async {
                    self.🕒History += "Cancellation: error\n"
                }
            }
        }
    }
    
    
    func 🏥RequestAuthorization(_ ⓣype: HKQuantityType) {
        🏥HealthStore.requestAuthorization(toShare: [ⓣype], read: nil) { 🙆, 🙅 in
            if 🙆 {
                print(".requestAuthorization: Success")
            } else {
                print("🙅:", 🙅.debugDescription)
            }
        }
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
