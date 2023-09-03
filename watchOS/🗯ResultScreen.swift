import SwiftUI

struct 🗯ResultScreen: View {
    @EnvironmentObject var model: 📱AppModel
    @State private var showUndoAlert: Bool = false
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: self.model.registrationSuccess ? "checkmark" : "exclamationmark.triangle")
                .font(.largeTitle.bold())
            Text(self.model.registrationSuccess ? "DONE!" : "Error!?")
                .font(.title.bold())
                .strikethrough(self.model.undid)
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
                Text(self.model.registeredValueLabel)
                    .strikethrough(self.model.undid)
            }
            Spacer()
        }
        .opacity(self.model.undid ? 0.25 : 1)
        .overlay(alignment: .bottom) {
            if self.model.undid {
                VStack {
                    Text("Undid")
                        .fontWeight(.semibold)
                    if self.model.failedUndo {
                        Text("(perhaps error)")
                    }
                }
            }
        }
        .onTapGesture {
            if !self.model.undid || !self.model.registrationSuccess {
                self.showUndoAlert = true
            }
        }
        .confirmationDialog("Undo?", isPresented: self.$showUndoAlert) {
            Button("Yes, undo") {
                self.model.undo()
            }
        }
        .overlay { if self.model.processingUndo { ProgressView() } }
        .onDisappear { self.model.clearRegistrationState() }
        .toolbar(self.showToolbar, for: .automatic)
        //watchOS9: DigitalCrown押し込みでsheetを閉じる事が可能
    }
}

private extension 🗯ResultScreen {
    private var showToolbar: Visibility {
        if #available(watchOS 10.0, *) {
            .visible
        } else {
            .hidden
        }
    }
}
