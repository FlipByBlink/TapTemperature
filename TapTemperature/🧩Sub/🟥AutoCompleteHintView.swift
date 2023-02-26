import SwiftUI

struct 🟥AutoCompleteHintView: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        GeometryReader { 📐 in
            VStack {
                Spacer()
                if 📱.🚩autoCompleteOption {
                    if 📱.🧩components.count == (📱.🚩secondDecimalPlaceOption ? 3 : 2) {
                        Rectangle()
                            .frame(height: 8 + 📐.safeAreaInsets.bottom)
                            .foregroundColor(.pink)
                            .shadow(radius: 3)
                            .transition(.asymmetric(insertion: .move(edge: .bottom),
                                                    removal: .opacity))
                    }
                }
            }
            .ignoresSafeArea()
            .animation(.default.speed(2), value: 📱.🧩components.count)
        }
    }
}
