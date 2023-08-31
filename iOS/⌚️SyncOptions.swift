import SwiftUI

struct 🅂yncOptions: ViewModifier {
    @EnvironmentObject var delegate: 🅂yncDelegate
    @EnvironmentObject var model: 📱AppModel
    func body(content: Content) -> some View {
        content
            .onChange(of: self.model.ableBBT) { _ in self.delegate.sync() }
            .onChange(of: self.model.ableSecondDecimalPlace) { _ in self.delegate.sync() }
            .onChange(of: self.model.ableAutoComplete) { _ in self.delegate.sync() }
            .task { self.delegate.sync() }
    }
}
