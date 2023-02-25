import SwiftUI

struct ContentView: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                HStack {
                    🪧ValueLabel()
                    🛏BasalSwitchButton()
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

struct 🛏BasalSwitchButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        if !📱.🚩bbtOption {
            Spacer()
            Button {
                📱.🛏bbtSwitch.toggle()
                💥Feedback.light()
            } label: {
                Image(systemName: "bed.double")
                    .foregroundStyle(📱.🛏bbtSwitch ? .primary : .quaternary)
                    .overlay {
                        if 📱.🛏bbtSwitch == false {
                            Image(systemName: "xmark")
                                .scaleEffect(1.2)
                        }
                    }
                    .tint(.primary)
            }
            .accessibilityLabel("Switch type")
            .onChange(of: 📱.🛏bbtSwitch) { _ in
                📱.🏥loadPreferredUnit()
            }
            .onChange(of: 📱.📏unitOption) { _ in
                📱.🧩resetComponents()
            }
            .buttonStyle(.plain)
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
