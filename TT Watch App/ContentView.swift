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
        .sheet(isPresented: $📱.🚩showResult) {
            self.ⓡesultView()
        }
    }
    private func ⓡesultView() -> some View {
        VStack {
            Spacer()
            Image(systemName: "checkmark")
                .font(.largeTitle.bold())
            Text("DONE")
                .font(.title.bold())
            Spacer()
            🪧ValueLabel()
                .foregroundStyle(.secondary)
            Spacer()
        }
        .onLongPressGesture {
            print("Undo?")
        }
        .toolbar(.hidden, for: .automatic)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
