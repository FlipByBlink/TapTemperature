import SwiftUI

struct ContentView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                Spacer(minLength: 0)
                HStack {
                    🪧ValueLabel()
                    Spacer()
                    🛠MenuButton()
                }
                .padding(.horizontal, 12)
                Divider()
                    .padding(.vertical, 6)
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
        .sheet(isPresented: self.$model.showResult) {
            self.model.reset()
        } content: {
            🗯ResultView()
        }
        .environment(\.layoutDirection, .leftToRight)
    }
}
