import SwiftUI

struct 🗯ResultView: View {
    @EnvironmentObject var model: 📱AppModel
    @State private var showUndoAlert: Bool = false
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: self.model.registrationSuccess ? "checkmark" : "exclamationmark.triangle")
                .font(.largeTitle.bold())
            Text(self.model.registrationSuccess ? "DONE!" : "Error!?")
                .font(.title.bold())
            if !self.model.registrationSuccess {
                Text(#"Please check permission on "Health" app"#)
                    .font(.footnote)
            }
            Spacer()
            if self.model.ableBBT {
                Text(self.model.activeMode.label)
                    .font(.caption.weight(.semibold))
                    .minimumScaleFactor(0.66)
            }
            if self.model.registrationSuccess {
                Text("\(self.model.inputValue) " + self.model.degreeUnit.rawValue)
            }
            Spacer()
        }
        .opacity(self.model.canceled ? 0.25 : 1)
        .overlay(alignment: .bottom) {
            if self.model.canceled {
                VStack {
                    Text("Canceled")
                        .fontWeight(.semibold)
                    if self.model.cancelError {
                        Text("(perhaps error)")
                    }
                }
            }
        }
        .onTapGesture {
            if !self.model.canceled || !self.model.registrationSuccess {
                self.showUndoAlert = true
            }
        }
        .confirmationDialog("Undo?", isPresented: self.$showUndoAlert) {
            Button("Yes, undo") {
                self.model.cancel()
            }
        }
        .toolbar(self.showToolbar, for: .automatic)
        //watchOS9: DigitalCrown押し込みでsheetを閉じる事が可能
    }
}

private extension 🗯ResultView {
    private var showToolbar: Visibility {
        if #available(watchOS 10.0, *) {
            .visible
        } else {
            .hidden
        }
    }
}
