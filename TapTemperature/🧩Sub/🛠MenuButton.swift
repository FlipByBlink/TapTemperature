import SwiftUI

struct 🛠MenuButton: View {
    @State private var 🚩showMenu = false
    var body: some View {
        Button {
            self.🚩showMenu = true
            UISelectionFeedbackGenerator().selectionChanged()
        } label: {
            Label("Open menu", systemImage: "gearshape")
                .font(.title)
                .labelStyle(.iconOnly)
                .padding(.vertical)
        }
        .tint(.primary)
        .sheet(isPresented: self.$🚩showMenu) {
            🛠MenuSheet()
                .onDisappear {
                    self.🚩showMenu = false
                }
        }
    }
}

struct 🛠MenuSheet: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        if #available(iOS 16.0, *) {
            NavigationStack { self.ⓒontent() }
        } else {
            NavigationView { self.ⓒontent() }
        }
    }
    private func ⓒontent() -> some View {
        List {
            🛠AppMenu()
            ℹ️AboutAppLink(name: "TapTemperature", subtitle: "App for iPhone")
            📣ADMenuLink()
        }
        .navigationTitle("Body Temperature")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    self.dismiss()
                } label: {
                    Image(systemName: "chevron.down")
                        .foregroundStyle(.secondary)
                        .grayscale(1.0)
                        .padding(8)
                }
                .accessibilityLabel("Dismiss")
            }
        }
    }
}
