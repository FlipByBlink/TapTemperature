import SwiftUI

struct 🗑️ResetOnBackground: ViewModifier {
    @EnvironmentObject var model: 📱AppModel
    @Environment(\.scenePhase) var scenePhase
    func body(content: Content) -> some View {
        content
            .onChange(of: self.scenePhase) {
                if $0 == .background { self.model.reset() }
            }
    }
}
