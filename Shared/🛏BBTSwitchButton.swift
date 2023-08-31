import SwiftUI

struct 🛏BBTSwitchButton: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        if self.model.🚩bbtOption {
            Button {
                self.model.🛏bbtSwitch.toggle()
                💥Feedback.light()
            } label: {
                Image(systemName: "bed.double")
                    .foregroundStyle(self.model.🛏bbtSwitch ? .primary : .quaternary)
                    .overlay {
                        if self.model.🛏bbtSwitch == false {
                            Image(systemName: "xmark")
                                .scaleEffect(1.2)
                        }
                    }
                    .tint(.primary)
            }
            .accessibilityLabel("Switch type")
            .onChange(of: self.model.🛏bbtSwitch) { _ in
                self.model.🏥loadPreferredUnit()
            }
            .onChange(of: self.model.📏unitOption) { _ in
                self.model.🧩resetComponents()
            }
        }
    }
}
