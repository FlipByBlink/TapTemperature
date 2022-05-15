
import SwiftUI
import HealthKit


enum 🄴numUnit: String, CaseIterable {
    case ℃
    case ℉
}


struct ContentView: View {
    
    let 🏥HealthStore = HKHealthStore()
    
    var 🅄nit: HKUnit {
        switch 🛠Unit {
        case .℃: return .degreeCelsius()
        case .℉: return .kelvin()
        }
    }
    
    var 🅀uantityTemp: HKQuantity {
        HKQuantity(unit: 🅄nit, doubleValue: 📝Temp)
    }
    
    var 🄳ataTemp: HKQuantitySample {
        HKQuantitySample(type: HKQuantityType(.bodyTemperature),
                         quantity: 🅀uantityTemp,
                         start: .now,
                         end: .now)
    }
    
    @AppStorage("Temp") var 📝Temp = 36.0
    
    @AppStorage("Unit") var 🛠Unit: 🄴numUnit = .℃
    
    @State private var 体温: [Int] = [3]
    
    var body: some View {
        VStack {
            Spacer()
            
            HStack(alignment: .firstTextBaseline) {
                Group {
                    Text("3")
                    
                    Text("_")
                    
                    Text(".")
                    
                    Text("_")
                        .opacity(0)
                }
                .font(.system(size: 72).weight(.black))
                
                Text("℃")
                    .font(.system(size: 48).weight(.black))
            }
            .padding(32)
            
            Spacer()
            
            Divider()
            
            KeyboardView()
                .onTapGesture {
                    🏥HealthStore.save(🄳ataTemp) { 🆗, 👿 in
                        if 🆗 {
                            print(".save/.bodyTemp: Success")
                        } else {
                            print("👿:", 👿.debugDescription)
                        }
                    }
                }
        }
        .onAppear {
            let 🅃ype: Set<HKSampleType> = [HKQuantityType(.bodyTemperature)]
            🏥HealthStore.requestAuthorization(toShare: 🅃ype, read: nil) { 🆗, 👿 in
                if 🆗 {
                    print("requestAuthorization/bodyTemp: Success")
                } else {
                    print("👿:", 👿.debugDescription)
                }
            }
        }
    }
}




struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
