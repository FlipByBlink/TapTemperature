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
            🪧ValueLabel()
                .padding(.bottom, 32)
            Spacer()
            Divider()
            👆Keypad()
                .padding(.horizontal)
                .padding(.vertical, 8)
                .frame(height: 400)
        }
        .navigationTitle(📱.ⓣarget.isBT ? "Body temperature" : "BBT")
        .toolbar {
            ToolbarItemGroup(placement: .navigationBarTrailing) {
                🛏BBTSwitchButton()
                💟OpenHealthAppButton()
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
