import SwiftUI

struct 🅂yncOptions: ViewModifier {
    @EnvironmentObject var delegate: 🅂yncDelegate
    @EnvironmentObject var model: 📱AppModel
    func body(content: Content) -> some View {
        content
            .onChange(of: self.model.🚩bbtOption) { _ in self.delegate.sync() }
            .onChange(of: self.model.🚩secondDecimalPlaceOption) { _ in self.delegate.sync() }
            .onChange(of: self.model.🚩autoCompleteOption) { _ in self.delegate.sync() }
            .task { self.delegate.sync() }
    }
}
