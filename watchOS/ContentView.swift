import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    🪧ValueLabel()
                    if self.model.ableBBT { Spacer() }
                    🛏BBTSwitchButton()
                        .buttonStyle(.plain)
                }
                .padding(.horizontal, 8)
                Divider()
                    .padding(.vertical, 6)
                👆Keypad()
                    .buttonStyle(.plain)
            }
            .navigationTitle(self.model.target.isBT ? "Temperature" : "BBT")
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(edges: .bottom)
        }
        .ignoresSafeArea(edges: .bottom)
        .sheet(isPresented: self.$model.showResult) {
            self.model.reset()
        } content: {
            🗯ResultView()
        }
        .environment(\.layoutDirection, .leftToRight)
    }
}
