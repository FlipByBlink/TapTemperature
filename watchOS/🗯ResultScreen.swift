import SwiftUI

struct 🗯ResultScreen: View {
    @EnvironmentObject var model: 📱AppModel
    @State private var showUndoAlert: Bool = false
    @State private var undoProcessing: Bool = false
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: self.model.registrationSuccess ? "checkmark" : "exclamationmark.triangle")
                .font(.largeTitle.bold())
            Text(self.model.registrationSuccess ? "DONE!" : "Error!?")
                .font(.title.bold())
                .strikethrough(self.model.canceled)
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
                    .strikethrough(self.model.canceled)
            }
            Spacer()
        }
        .opacity(self.model.canceled ? 0.25 : 1)
        .overlay(alignment: .bottom) {
            if self.model.canceled {
                VStack {
                    Text("Canceled")
                        .fontWeight(.semibold)
                    if self.model.failedCancellation {
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
                Task {
                    self.undoProcessing = true
                    await self.model.cancel()
                    self.undoProcessing = false
                }
            }
        }
        .overlay { if self.undoProcessing { ProgressView() } }
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
