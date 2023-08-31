import SwiftUI

struct 🟥AutoCompleteHintView: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        GeometryReader { ⓟroxy in
            VStack {
                Spacer()
                if self.model.ableAutoComplete {
                    if self.model.components.count == (self.model.ableSecondDecimalPlace ? 3 : 2) {
                        Rectangle()
                            .frame(height: 8 + ⓟroxy.safeAreaInsets.bottom)
                            .foregroundColor(.pink)
                            .shadow(radius: 3)
                            .transition(.asymmetric(insertion: .move(edge: .bottom),
                                                    removal: .opacity))
                    }
                }
            }
            .ignoresSafeArea()
            .animation(.default.speed(2), value: self.model.components.count)
        }
    }
}
