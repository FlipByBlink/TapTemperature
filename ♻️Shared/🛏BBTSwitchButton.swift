import SwiftUI

struct 🛏BBTSwitchButton: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        if 📱.🚩bbtOption {
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
        }
    }
}
