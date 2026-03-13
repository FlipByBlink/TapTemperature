import SwiftUI

struct 📣ADSheet: ViewModifier {
    @EnvironmentObject var 🛒: 🛒InAppPurchaseModel
    @State private var isSheetPresented: Bool = false
    @State private var app: 📣ADTargetApp = .pickUpAppWithout(.TapTemperature)
    func body(content: Content) -> some View {
        content
            .sheet(isPresented: self.$isSheetPresented) {
                📣ADView(self.app, second: 3)
            }
            .onAppear {
                if 🛒.checkToShowADSheet() { self.isSheetPresented = true }
            }
    }
}
