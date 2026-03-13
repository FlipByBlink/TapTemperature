import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: 📱AppModel
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
            .modifier(🚏NavigationTitle())
            .toolbar {
                ToolbarItemGroup(placement: .navigationBarTrailing) {
                    🛏BBTSwitchButton()
                    💟OpenHealthApp.buttonOnToolbar()
                    🛠MenuButton()
                }
            }
            .background { 🟥AutoCompleteHintView() }
            .sheet(isPresented: self.$model.isMenuPresented) { 🛠Menu() }
            .fullScreenCover(isPresented: self.$model.isResultScreenPresented) { 🗯ResultScreen() }
            .modifier(📏LoadPrefferedUnit())
            .modifier(🗑️ResetOnBackground())
        }
        .modifier(📣ADSheet())
        .modifier(🚨UnsupportAlert())
        .environment(\.layoutDirection, .leftToRight)
    }
}
