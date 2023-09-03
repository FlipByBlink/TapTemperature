import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Spacer(minLength: 4)
                HStack {
                    🪧ValueLabel()
                    Spacer()
                    🛠MenuButton()
                }
                .minimumScaleFactor(0.6)
                .padding(.horizontal, 12)
                Spacer(minLength: 4)
                Divider()
                👆Keypad()
                    .buttonStyle(.plain)
                    .padding(.horizontal, 8)
                    .padding(.bottom, 4)
            }
            .navigationTitle(self.model.activeMode.navigationTitle)
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(edges: .bottom)
            .frame(maxHeight: .infinity)
        }
        .sheet(isPresented: self.$model.showResultScreen) {
            self.model.reset()
        } content: {
            🗯ResultScreen()
        }
        .modifier(📏LoadPrefferedUnit())
        .modifier(🗑️ResetOnBackground())
        .environment(\.layoutDirection, .leftToRight)
    }
}
