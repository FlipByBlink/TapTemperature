import SwiftUI
import HealthKit

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack { ⓒontent() }
        } else {
            NavigationView { ⓒontent() }
        }
    }
    private func ⓒontent() -> some View {
        VStack {
            Spacer()
            🪧TemperatureLabel()
                .padding(.horizontal)
                .padding(.trailing)
                .padding(.bottom)
            Spacer()
            Divider()
            👆Keypad()
        }
        .navigationTitle(📱.🛏bbtInputMode ? "BBT" : "Body temperature")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                🛏BasalSwitchButton()
                💟JumpButton()
                🛠MenuButton()
            }
        }
        .background { 🟥AutoCompleteHintView() }
        .fullScreenCover(isPresented: $📱.🚩showResult) { 🗯ResultView() }
        .onChange(of: self.scenePhase) {
            if $0 == .background { 📱.ⓡeset() }
        }
    }
}

struct 🛏BasalSwitchButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        if 📱.🚩bbtOption {
            Button {
                📱.🛏bbtSwitch.toggle()
                UISelectionFeedbackGenerator().selectionChanged()
            } label: {
                Image(systemName: "bed.double")
                    .foregroundStyle(📱.🛏bbtSwitch ? .primary : .quaternary)
                    .overlay {
                        if 📱.🛏bbtSwitch == false {
                            Image(systemName: "xmark")
                                .scaleEffect(1.2)
                        }
                    }
                    .tint(.primary)
            }
            .accessibilityLabel("Switch type")
            .onChange(of: 📱.🛏bbtSwitch) { _ in
                📱.🏥loadPreferredUnit()
            }
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
