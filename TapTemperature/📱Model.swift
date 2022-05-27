
import SwiftUI
import HealthKit


class 📱Model: ObservableObject {
    
    @AppStorage("Unit") var 💾Unit: 📏EnumUnit = .℃
    
    @AppStorage("BasalTemp") var 🚩BasalTemp: Bool = false
    
    @AppStorage("2ndDecimalPlace") var 🚩2DecimalPlace: Bool = false
    
    @AppStorage("AutoComplete") var 🚩AutoComplete: Bool = false
    
    
    @Published var 🧩Temp: [Int] = []
    
    
    @Published var 🛏BasalIs: Bool = true
    
    @Published var 🚩InputDone: Bool = false
    
    @Published var 🚩Success: Bool = false
    
    @Published var 🚩Canceled: Bool = false
    
    
    @AppStorage("history") var 🄷istoryTemp: String = ""
    
    @AppStorage("historyBasal") var 🄷istoryBasalTemp: String = ""
    
    
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
            }
        }
    }
    
    
    var 🅀uantity: HKQuantity {
        HKQuantity(unit: 💾Unit.ⒽKUnit, doubleValue: 🌡Temp)
    }
    
    var 🅃ype: HKQuantityType {
        if 🚩BasalTemp && 🛏BasalIs {
            return HKQuantityType(.basalBodyTemperature)
        } else {
            return HKQuantityType(.bodyTemperature)
        }
    }
    
    var 📃Sample: HKQuantitySample?
    
    func 🚀Done() {
        UISelectionFeedbackGenerator().selectionChanged()
        
        if 🚩BasalTemp && self.🛏BasalIs {
            🄷istoryBasalTemp += Date.now.formatted(date: .numeric, time: .shortened) + ", "
        } else {
            🄷istoryTemp += Date.now.formatted(date: .numeric, time: .shortened) + ", "
        }
        
        if 🚩BasalTemp && self.🛏BasalIs {
            if 🏥HealthStore.authorizationStatus(for: HKQuantityType(.basalBodyTemperature)) == .sharingDenied {
                🚩Success = false
                🚩InputDone = true
                self.🄷istoryBasalTemp += ".authorization: Error?!\n"
                return
            }
        } else {
            if 🏥HealthStore.authorizationStatus(for: HKQuantityType(.bodyTemperature)) == .sharingDenied {
                🚩Success = false
                🚩InputDone = true
                self.🄷istoryTemp += ".authorization: Error?!\n"
                return
            }
        }
        
        📃Sample = HKQuantitySample(type: 🅃ype,
                                    quantity: 🅀uantity,
                                    start: .now,
                                    end: .now)
        
        if let 📃 = 📃Sample {
            🏥HealthStore.save(📃) { 🙆, 🙅 in
                if 🙆 {
                    print(".save: Success")
                    
                    DispatchQueue.main.async {
                        if self.🚩BasalTemp && self.🛏BasalIs {
                            self.🄷istoryBasalTemp += self.🌡Temp.description + " " + self.💾Unit.rawValue + "\n"
                        } else {
                            self.🄷istoryTemp += self.🌡Temp.description + " " + self.💾Unit.rawValue + "\n"
                        }
                        
                        self.🚩Success = true
                        self.🚩InputDone = true
                    }
                } else {
                    print("🙅:", 🙅.debugDescription)
                    
                    DispatchQueue.main.async {
                        if self.🚩BasalTemp && self.🛏BasalIs {
                            self.🄷istoryBasalTemp += ".save: Error?!\n"
                        } else {
                            self.🄷istoryTemp += ".save: Error?!\n"
                        }
                        
                        self.🚩Success = false
                        self.🚩InputDone = true
                    }
                }
            }
        } else {
            if 🚩BasalTemp && 🛏BasalIs {
                🄷istoryBasalTemp += "HKQuantitySample: Error?!\n"
            } else {
                🄷istoryTemp += "HKQuantitySample: Error?!\n"
            }
            
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
