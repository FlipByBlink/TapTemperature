import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    @Environment(\.scenePhase) var scenePhase
    var body: some View {
        NavigationStack {
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
            .navigationTitle(self.model.ⓣarget.isBT ? "Body temperature" : "BBT")
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    🛏BBTSwitchButton()
                    💟OpenHealthAppButton()
                    🛠MenuButton()
                }
            }
            .background { 🟥AutoCompleteHintView() }
            .fullScreenCover(isPresented: self.$model.🚩showResult) { 🗯ResultView() }
            .onChange(of: self.scenePhase) {
                if $0 == .background { self.model.ⓡeset() }
            }
        }
        .modifier(📣ADSheet())
        .modifier(🅂yncOptions())
        .environment(\.layoutDirection, .leftToRight)
    }
}
