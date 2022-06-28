
import SwiftUI
import HealthKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                🛠MenuButton()
                
                if 📱.🚩BasalTemp {
                    Button {
                        📱.🛏BasalSwitch.toggle()
                        UISelectionFeedbackGenerator().selectionChanged()
                    } label: {
                        Image(systemName: "bed.double")
                            .foregroundStyle(📱.🛏BasalSwitch ? .primary : .quaternary)
                            .padding(.vertical)
                            .overlay {
                                if 📱.🛏BasalSwitch == false {
                                    Image(systemName: "xmark")
                                        .scaleEffect(1.2)
                                }
                            }
                            .font(.title)
                            .tint(.primary)
                    }
                    .accessibilityLabel("Switch type")
                }
                
                Spacer()
                
                💟JumpButton()
            }
            .padding(.horizontal, 20)
            
            Spacer()
            
            🪧TemperatureLabel()
                .padding(.horizontal)
                .padding(.trailing)
                .padding(.bottom)
            
            Spacer()
            
            Divider()
            
            👆Keypad()
        }
        .background {
            GeometryReader { 📐 in
                VStack {
                    Spacer()
                    
                    if 📱.🚩AutoComplete {
                        if 📱.🧩Temp.count == (📱.🚩2DecimalPlace ? 3 : 2) {
                            Rectangle()
                                .frame(height: 8 + 📐.safeAreaInsets.bottom)
                                .foregroundColor(.pink)
                                .shadow(radius: 3)
                                .transition(.asymmetric(insertion: .move(edge: .bottom),
                                                        removal: .opacity))
                        }
                    }
                }
                .ignoresSafeArea()
                .animation(.default.speed(2), value: 📱.🧩Temp.count)
            }
        }
        .fullScreenCover(isPresented: $📱.🚩ShowResult) {
            🗯ResultView()
        }
        .onAppear {
            📱.🏥RequestAuthorization(.bodyTemperature)
            
            📱.🧩ResetTemp()
        }
    }
}
