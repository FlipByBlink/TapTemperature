import SwiftUI

struct 🛏BBTSwitchButton: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        if self.model.ableBBT {
            Button {
                self.model.bbtMode.toggle()
                💥Feedback.light()
            } label: {
                Image(systemName: "bed.double")
                    .foregroundStyle(self.model.bbtMode ? .primary : .quaternary)
                    .overlay {
                        if self.model.bbtMode == false {
                            Image(systemName: "xmark")
                                .scaleEffect(1.2)
                        }
                    }
                    .tint(.primary)
            }
            .accessibilityLabel("Switch type")
        }
    }
}
