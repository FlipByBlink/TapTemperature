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
            Text(📱.🌡value.description + " " + 📱.📏unitOption.rawValue)
            Spacer()
        }
        .onLongPressGesture {
            print("Undo?")
        }
        .toolbar(.hidden, for: .automatic)
        //Digital crown 押し込みでsheetを閉じれる
    }
}

//TODO: BT/BBT切り替え機能 実装
//TODO: Undo機能 実装
//TODO: ResultViewを適切に実装

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
