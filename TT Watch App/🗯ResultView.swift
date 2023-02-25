import SwiftUI

struct 🗯ResultView: View {
    @EnvironmentObject var 📱: 📱AppModel
    @State private var ⓢhowUndoAlert: Bool = false
    var body: some View {
        VStack {
            Spacer()
            Image(systemName: "checkmark")
                .font(.largeTitle.bold())
            Text("DONE")
                .font(.title.bold())
            Spacer()
            if 📱.🚩bbtOption {
                Text(📱.ⓣarget.isBT ? "Body temperature" : "Basal body temperature")
                    .font(.caption.weight(.semibold))
                    .minimumScaleFactor(0.66)
            }
            Text(📱.🌡value.description + " " + 📱.📏unitOption.rawValue)
            Spacer()
        }
        .opacity(📱.🚩canceled ? 0.25 : 1)
        .overlay(alignment: .bottom) {
            if 📱.🚩canceled {
                VStack {
                    Text("Canceled")
                        .fontWeight(.semibold)
                    if 📱.🚨cancelError {
                        Text("(perhaps error)")
                    }
                }
            }
        }
        .onTapGesture {
            if !📱.🚩canceled {
                self.ⓢhowUndoAlert = true
            }
        }
        .confirmationDialog("Undo?", isPresented: self.$ⓢhowUndoAlert) {
            Button("Yes, undo") {
                📱.🗑cancel()
            }
        }
        .toolbar(.hidden, for: .automatic)
        //Digital Crown 押し込みでsheetを閉じれる
    }
}
