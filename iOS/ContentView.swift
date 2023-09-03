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
            .navigationTitle(self.model.activeMode.navigationTitle)
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    🛏BBTSwitchButton()
                    💟OpenHealthApp.buttonOnToolbar()
                    🛠MenuButton()
                }
            }
            .background { 🟥AutoCompleteHintView() }
            .fullScreenCover(isPresented: self.$model.showResult) { 🗯ResultView() }
            .modifier(📏LoadPrefferedUnit())
            .onChange(of: self.scenePhase) {
                if $0 == .background { self.model.reset() }
            }
        }
        .modifier(📣ADSheet())
        .environment(\.layoutDirection, .leftToRight)
    }
}
