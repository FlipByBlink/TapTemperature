
import SwiftUI
import HealthKit


struct ContentView: View {
    
    @EnvironmentObject var 📱:📱Model
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                🛠MenuButton()
                
                if 📱.🚩BasalTemp {
                    Button {
                        📱.🛏isActive.toggle()
                    } label: {
                        Image(systemName: "bed.double")
                            .foregroundStyle(📱.🛏isActive ? .primary : .quaternary)
                            .overlay {
                                if 📱.🛏isActive == false {
                                    Image(systemName: "xmark")
                                        .scaleEffect(1.2)
                                }
                            }
                            .font(.title)
                            .tint(.primary)
                    }
                }
                
                Spacer()
                
                💟JumpButton()
            }
            .padding(.top)
            .padding(.horizontal, 20)
            
            
            Spacer()
            
            
            HStack(alignment: .firstTextBaseline) {
                if 📱.🧩Temp.indices.contains(0) {
                    Text(📱.🧩Temp[0].description)
                }  else {
                    Text("0").opacity(0)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .frame(height: 4)
                        }
                }
                
                if 📱.🧩Temp.indices.contains(1) {
                    Text(📱.🧩Temp[1].description)
                }  else {
                    Text("0").opacity(0)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .frame(height: 4)
                                .opacity(📱.🧩Temp.count < 1 ? 0 : 1)
                        }
                }
                
                Text(".")
                
                if 📱.🧩Temp.indices.contains(2) {
                    Text(📱.🧩Temp[2].description)
                }  else {
                    Text("0").opacity(0)
                        .overlay(alignment: .bottom) {
                            Rectangle()
                                .frame(height: 4)
                                .opacity(📱.🧩Temp.count < 2 ? 0 : 1)
                        }
                }
                
                if 📱.🧩Temp.indices.contains(3) {
                    Text(📱.🧩Temp[3].description)
                } else {
                    if 📱.🚩2ndDecimalPlace {
                        Text("0").opacity(0)
                            .overlay(alignment: .bottom) {
                                Rectangle()
                                    .frame(height: 4)
                                    .opacity(📱.🧩Temp.count < 3 ? 0 : 1)
                            }
                    } else {
                        EmptyView()
                    }
                }
                
                Text(📱.🛠Unit.rawValue)
                    .font(.system(size: 54, weight: .bold))
                    .minimumScaleFactor(0.1)
                    .scaledToFit()
            }
            .font(.system(size: 81, weight: .bold))
            .monospacedDigit()
            .padding(.horizontal, 32)
            .padding(.bottom)
            
            
            Spacer()
            
            Divider()
            
            
            let 列 = Array(repeating: GridItem(.flexible()), count: 3)
            LazyVGrid(columns: 列, spacing: 32) {
                ForEach(1..<13) { 🪧 in
                    if 🪧 == 10 {
                        Button {
                            📱.💾Temp = 📱.🌡Temp
                            📱.🏥HealthStore.save(📱.🄳ataTemp) { 🆗, 👿 in
                                if 🆗 {
                                    print(".save/.bodyTemp: Success")
                                    DispatchQueue.main.async {
                                        📱.🚩Success = true
                                    }
                                } else {
                                    print("👿:", 👿.debugDescription)
                                }
                            }
                            📱.🚩InputDone = true
                        } label: {
                            Image(systemName: "checkmark.circle")
                                .symbolVariant(📱.🧩Temp.count > 2 ? .fill : .none)
                                .scaleEffect(📱.🧩Temp.count > 2 ? 1.15 : 1)
                        }
                        .tint(.pink)
                        .disabled(📱.🧩Temp.count < 3)
                    } else if 🪧 == 11 {
                        Button {
                            if 📱.🧩Temp.count < 4 {
                                📱.🧩Temp.append(0)
                            }
                        } label: {
                            Text("0")
                                .fontWeight(📱.🧩Temp.count==1 && 📱.🧩Temp.first==3 ? .regular:nil)
                                .fontWeight(📱.🧩Temp.count >= 3 && (📱.🚩2ndDecimalPlace == false) ? .regular:nil)
                        }
                        .tint(.primary)
                        .disabled(📱.🧩Temp.count == 0)
                        .disabled(📱.🧩Temp.count == 4)
                    } else if 🪧 == 12 {
                        Button {
                            📱.🧩Temp.removeLast()
                        } label: {
                            Text("⌫")
                                .fontWeight(📱.🧩Temp.count <= 1 ? .regular:nil)
                                .scaleEffect(0.8)
                        }
                        .tint(.primary)
                        .disabled(📱.🧩Temp.isEmpty)
                    } else {
                        Button {
                            if 📱.🧩Temp.count < 4 {
                                📱.🧩Temp.append(🪧)
                            }
                        } label: {
                            Text(🪧.description)
                                .fontWeight(📱.🧩Temp.count == 1 && 📱.🧩Temp.first==3 && !(4<🪧 && 🪧<=9) ? .regular:nil)
                                .fontWeight(📱.🧩Temp.count >= 3 && (📱.🚩2ndDecimalPlace == false) ? .regular:nil)
                        }
                        .tint(.primary)
                        .disabled(📱.🧩Temp.count==0 && !(🪧==3 || 🪧==4))
                        .disabled(📱.🧩Temp.count == 1 && 📱.🧩Temp.first==4 && 🪧 != 1)
                        .disabled(📱.🧩Temp.count == 4)
                    }
                }
                .font(.system(size: 48, weight: .heavy, design: .rounded))
            }
            .padding()
            .padding(.vertical, 12)
        }
        .fullScreenCover(isPresented: $📱.🚩InputDone) {
            🆗Result()
        }
        .onAppear {
            let 🅃ype: Set<HKSampleType> = [HKQuantityType(.bodyTemperature)]
            📱.🏥HealthStore.requestAuthorization(toShare: 🅃ype, read: nil) { 🆗, 👿 in
                if 🆗 {
                    print("requestAuthorization/bodyTemp: Success")
                } else {
                    print("👿:", 👿.debugDescription)
                }
            }
        }
    }
}


struct 💟JumpButton: View {
    var body: some View {
        Link(destination: URL(string: "x-apple-health://")!) {
            Image(systemName: "app")
                .imageScale(.large)
                .overlay {
                    Image(systemName: "heart")
                        .imageScale(.small)
                }
        }
        .font(.title)
        .foregroundStyle(.primary)
        .accessibilityLabel("🌏Open \"Health\" app")
    }
}








struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
