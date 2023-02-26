import SwiftUI

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    🪧ValueLabel()
                    if 📱.🚩bbtOption { Spacer() }
                    🛏BBTSwitchButton()
                        .buttonStyle(.plain)
                }
                .padding(.horizontal, 8)
                Divider()
                    .padding(.vertical, 6)
                👆Keypad()
                    .buttonStyle(.plain)
            }
            .navigationTitle(📱.ⓣarget.isBT ? "Temperature" : "BBT")
            .navigationBarTitleDisplayMode(.inline)
            .ignoresSafeArea(edges: .bottom)
        }
        .ignoresSafeArea(edges: .bottom)
        .sheet(isPresented: $📱.🚩showResult) {
            📱.ⓡeset()
        } content: {
            🗯ResultView()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static let ⓜodel = 📱AppModel()
    static var previews: some View {
        ContentView()
            .environmentObject(self.ⓜodel)
    }
}
