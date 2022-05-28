
import SwiftUI
import HealthKit


class 📱Model: ObservableObject {
    
    @AppStorage("Unit") var 💾Unit: 📏EnumUnit = .℃
    
    @AppStorage("BasalTemp") var 🚩BasalTemp: Bool = false
    
    @AppStorage("2DecimalPlace") var 🚩2DecimalPlace: Bool = false
    
    @AppStorage("AutoComplete") var 🚩AutoComplete: Bool = false
    
    
    @Published var 🧩Temp: [Int] = []
    
    
    @Published var 🛏BasalSwitch: Bool = true
    
    @Published var 🚩InputDone: Bool = false
    
    @Published var 🚩Success: Bool = false
    
    @Published var 🚩Canceled: Bool = false
    
    
    @AppStorage("history") var 🄷istory: String = ""
    
    
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
        switch 💾Unit {
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
        
        🄷istory += Date.now.formatted(date: .numeric, time: .shortened) + ", "
        🄷istory += 🚩BasalTempInput ? "BBT, " : "BT, "
        
        
        let 🅃ype = HKQuantityType(🚩BasalTempInput ? .basalBodyTemperature : .bodyTemperature)
        
        if 🏥HealthStore.authorizationStatus(for: 🅃ype) == .sharingDenied {
            🚩Success = false
            🚩InputDone = true
            
            🄷istory += ".authorization: Error?!\n"
            
            return
        }
        
        
        📃Sample = HKQuantitySample(type: 🅃ype,
                                    quantity: HKQuantity(unit: 💾Unit.ⒽKUnit, doubleValue: 🌡Temp),
                                    start: .now,
                                    end: .now)
        
        if let 📃 = 📃Sample {
            🏥HealthStore.save(📃) { 🙆, 🙅 in
                if 🙆 {
                    print(".save: Success")
                    
                    DispatchQueue.main.async {
                        self.🄷istory += self.🌡Temp.description + " " + self.💾Unit.rawValue + "\n"
                        
                        self.🚩Success = true
                        self.🚩InputDone = true
                    }
                    
                    UINotificationFeedbackGenerator().notificationOccurred(.success)
                } else {
                    print("🙅:", 🙅.debugDescription)
                    
                    DispatchQueue.main.async {
                        self.🄷istory += ".save: Error?!\n"
                        
                        self.🚩Success = false
                        self.🚩InputDone = true
                    }
                }
            }
        } else {
            🄷istory += "HKQuantitySample: Error?!\n"
            
            🚩Success = false
            🚩InputDone = true
        }
    }
    
    
    func 🗑Cancel() {
        if let 📃 = 📃Sample {
            🏥HealthStore.delete(📃) { 🙆, 🙅 in
                if 🙆 {
                    print(".delete: Success")
                    
                    DispatchQueue.main.async {
                        self.🚩Canceled = true
                    }
                    
                    UINotificationFeedbackGenerator().notificationOccurred(.error)
                } else {
                    print("🙅:", 🙅.debugDescription)
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


enum 📏EnumUnit: String, CaseIterable {
    case ℃
    case ℉
    
    var ⒽKUnit: HKUnit {
        switch self {
            case .℃: return .degreeCelsius()
            case .℉: return .degreeFahrenheit()
        }
    }
}
