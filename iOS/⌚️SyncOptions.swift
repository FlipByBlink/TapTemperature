import SwiftUI

struct 🅂yncOptions: ViewModifier {
    @EnvironmentObject var model: 📱AppModel
    func body(content: Content) -> some View {
        content
            .onChange(of: self.model.ableBBT) { _ in self.model.syncAppleWatch() }
            .onChange(of: self.model.ableSecondDecimalPlace) { _ in self.model.syncAppleWatch() }
            .onChange(of: self.model.ableAutoComplete) { _ in self.model.syncAppleWatch() }
            .task { self.model.syncAppleWatch() }
    }
}
