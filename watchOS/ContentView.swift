import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Spacer(minLength: 4)
                HStack {
                    🪧ValueLabel()
                        .padding(.leading, 12)
                    if #unavailable(watchOS 10.0) {
                        Spacer()
                        🛠MenuButton()
                            .buttonStyle(.plain)
                    }
                }
                .minimumScaleFactor(0.6)
                Spacer(minLength: 4)
                Divider()
                👆Keypad()
                    .buttonStyle(.plain)
                    .padding(.horizontal, 8)
                    .padding(.bottom, 4)
            }
            .navigationTitle(self.model.activeMode == .bodyTemperature ? "Temperature" : "BBT")
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(edges: .bottom)
            .frame(maxHeight: .infinity)
            .toolbar {
                if #available(watchOS 10.0, *) {
                    ToolbarItem(placement: .topBarLeading) { 🛠MenuButton() }
                }
            }
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
