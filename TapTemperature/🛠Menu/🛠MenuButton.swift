
import SwiftUI

struct 🛠MenuButton: View {
    @State private var 🚩ShowMenu = false
    
    var body: some View {
        Button {
            UISelectionFeedbackGenerator().selectionChanged()
            🚩ShowMenu = true
        } label: {
            Label("Open menu", systemImage: "gearshape")
                .font(.title)
                .labelStyle(.iconOnly)
                .padding(.vertical)
            
        }
        .tint(.primary)
        .accessibilityLabel("Open menu")
        .sheet(isPresented: $🚩ShowMenu) {
            🛠MenuSheet()
                .onDisappear {
                    🚩ShowMenu = false
                }
        }
    }
}
