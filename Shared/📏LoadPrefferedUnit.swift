import SwiftUI

struct 📏LoadPrefferedUnit: ViewModifier {
    @EnvironmentObject var model: 📱AppModel
    @Environment(\.scenePhase) var scenePhase
    func body(content: Content) -> some View {
        content
            .onChange(of: self.scenePhase) {
                if $1 == .active {
                    self.model.loadPreferredUnit()
                }
            }
            .onChange(of: self.model.activeMode) { _, _ in
                self.model.loadPreferredUnit()
            }
    }
}
