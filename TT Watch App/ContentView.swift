import SwiftUI

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                🪧ValueLabel()
                Divider()
                    .padding(.vertical, 6)
                👆Keypad()
                    .buttonStyle(.plain)
            }
            .navigationTitle("Temperature")
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

//TODO: BT/BBT切り替え機能 実装
//TODO: Undo機能 実装
//TODO: ResultViewを適切に実装

struct ContentView_Previews: PreviewProvider {
    static let ⓜodel = 📱AppModel()
    static var previews: some View {
        ContentView()
            .environmentObject(self.ⓜodel)
    }
}
