import SwiftUI
import HealthKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                🛠MenuButton()
                🛏BasalSwitchButton()
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
        .background { 🟥AutoCompleteHintView() }
        .fullScreenCover(isPresented: $📱.🚩showResult) {
            🗯ResultView()
        }
        .onAppear {
            📱.🏥requestAuthorization(.bodyTemperature)
            📱.🧩resetComponents()
        }
        .onChange(of: self.scenePhase) {
            if $0 == .background {
                📱.ⓡeset()
            }
        }
    }
}

struct 🛏BasalSwitchButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        if 📱.🚩basalTempOption {
            Button {
                📱.🛏basalSwitch.toggle()
                UISelectionFeedbackGenerator().selectionChanged()
            } label: {
                Image(systemName: "bed.double")
                    .foregroundStyle(📱.🛏basalSwitch ? .primary : .quaternary)
                    .padding(.vertical)
                    .overlay {
                        if 📱.🛏basalSwitch == false {
                            Image(systemName: "xmark")
                                .scaleEffect(1.2)
                        }
                    }
                    .font(.title)
                    .tint(.primary)
            }
            .accessibilityLabel("Switch type")
        }
    }
}

struct 🟥AutoCompleteHintView: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        GeometryReader { 📐 in
            VStack {
                Spacer()
                if 📱.🚩autoCompleteOption {
                    if 📱.🧩components.count == (📱.🚩secondDecimalPlaceOption ? 3 : 2) {
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
            .animation(.default.speed(2), value: 📱.🧩components.count)
        }
    }
}
