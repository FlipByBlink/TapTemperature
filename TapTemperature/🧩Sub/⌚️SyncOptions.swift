import SwiftUI

struct 🅂yncOptions: ViewModifier {
    @EnvironmentObject var ⓓelegate: 🅂yncDelegate
    @EnvironmentObject var 📱: 📱AppModel
    func body(content: Content) -> some View {
        content
            .onChange(of: 📱.🚩bbtOption) { _ in ⓓelegate.ⓢync() }
            .onChange(of: 📱.🚩secondDecimalPlaceOption) { _ in ⓓelegate.ⓢync() }
            .onChange(of: 📱.🚩autoCompleteOption) { _ in ⓓelegate.ⓢync() }
            .task { ⓓelegate.ⓢync() }
    }
}
