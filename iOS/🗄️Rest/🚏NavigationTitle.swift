import SwiftUI

struct 🚏NavigationTitle: ViewModifier {
    @EnvironmentObject var model: 📱AppModel
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    func body(content: Content) -> some View {
        content
            .navigationTitle(self.title)
    }
    private var title: LocalizedStringKey {
        switch self.model.activeMode {
            case .bodyTemperature: 
                "Body temperature"
            case .basalBodyTemperature:
                self.horizontalSizeClass == .compact ? "BBT" : "Basal body temperature"
        }
    }
}
