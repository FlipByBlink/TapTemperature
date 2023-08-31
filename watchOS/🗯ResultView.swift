import SwiftUI

struct 🗯ResultView: View {
    @EnvironmentObject var model: 📱AppModel
    @State private var showUndoAlert: Bool = false
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: self.model.🚩registerSuccess ? "checkmark" : "exclamationmark.triangle")
                .font(.largeTitle.bold())
            Text(self.model.🚩registerSuccess ? "DONE!" : "Error!?")
                .font(.title.bold())
            if !self.model.🚩registerSuccess {
                Text("Please check permission on \"Health\" app")
                    .font(.footnote)
            }
            Spacer()
            if self.model.🚩bbtOption {
                Text(self.model.ⓣarget.isBT ? "Body temperature" : "Basal body temperature")
                    .font(.caption.weight(.semibold))
                    .minimumScaleFactor(0.66)
            }
            if self.model.🚩registerSuccess {
                Text(self.model.🌡value.description + " " + self.model.📏unitOption.rawValue)
            }
            Spacer()
        }
        .opacity(self.model.🚩canceled ? 0.25 : 1)
        .overlay(alignment: .bottom) {
            if self.model.🚩canceled {
                VStack {
                    Text("Canceled")
                        .fontWeight(.semibold)
                    if self.model.🚨cancelError {
                        Text("(perhaps error)")
                    }
                }
            }
        }
        .onTapGesture {
            if !self.model.🚩canceled || !self.model.🚩registerSuccess {
                self.showUndoAlert = true
            }
        }
        .confirmationDialog("Undo?", isPresented: self.$showUndoAlert) {
            Button("Yes, undo") {
                self.model.🗑cancel()
            }
        }
        .toolbar(.hidden, for: .automatic)
        //Digital Crown 押し込みでsheetを閉じれる
    }
}
