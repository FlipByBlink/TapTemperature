
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
        case .℉: return .degreeFahrenheit()
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
                if 体温.indices.contains(0) {
                    Text(体温[0].description)
                }  else {
                    Text("0").opacity(0)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .frame(height: 4)
                        }
                }
                
                if 体温.indices.contains(1) {
                    Text(体温[1].description)
                }  else {
                    Text("0").opacity(0)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .frame(height: 4)
                        }
                }
                
                Text(".")
                
                if 体温.indices.contains(2) {
                    Text(体温[2].description)
                }  else {
                    Text("0").opacity(0)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .frame(height: 4)
                        }
                }
                
                if 体温.indices.contains(3) {
                    Text(体温[3].description)
                } else {
                    EmptyView()
                }
                
                Text(🛠Unit.rawValue)
                    .font(.system(size: 54, weight: .bold))
                    .minimumScaleFactor(0.1)
                    .scaledToFit()
            }
            .font(.system(size: 81, weight: .bold))
            .monospacedDigit()
            .padding(32)
            
            Spacer()
            
            Divider()
            
            KeyboardView()
                .padding(.vertical)
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
