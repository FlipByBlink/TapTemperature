import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Spacer(minLength: 4)
                🪧ValueLabel()
                    .padding(.leading, 12)
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
                ToolbarItem(placement: .topBarLeading) { 🛠MenuButton() }
            }
        }
        .sheet(isPresented: self.$model.isResultScreenPresented) {
            self.model.reset()
        } content: {
            🗯ResultScreen()
        }
        .modifier(📏LoadPrefferedUnit())
        .modifier(🗑️ResetOnBackground())
        .environment(\.layoutDirection, .leftToRight)
    }
}
