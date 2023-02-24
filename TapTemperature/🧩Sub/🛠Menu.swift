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
            🅂heet()
                .onDisappear { self.🚩showMenu = false }
        }
    }
    private struct 🅂heet: View {
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
            }
            .navigationTitle("Menu")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        self.dismiss()
                    } label: {
                        Image(systemName: "chevron.down")
                    }
                    .foregroundStyle(.secondary)
                    .accessibilityLabel("Dismiss")
                }
            }
        }
    }
}

struct 🛠AppMenu: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Section {
            Picker(selection: $📱.📏unitOption) {
                ForEach(📏DegreeUnit.allCases) { Text($0.rawValue) }
            } label: {
                Label("Unit", systemImage: "ruler")
            }
            Toggle(isOn: $📱.🚩basalTempOption) {
                Label("Basal body temperature", systemImage: "bed.double")
            }
            .onChange(of: 📱.🚩basalTempOption) { _ in
                📱.🏥requestAuthorization(.basalBodyTemperature)
            }
            Toggle(isOn: $📱.🚩secondDecimalPlaceOption) {
                Label(📱.📏unitOption == .℃ ? "36.1 ℃  →  36.12︭ ℃" : "100.1 ℉  →  100.12︭ ℉",
                      systemImage: "character.cursor.ibeam")
            }
            .accessibilityLabel("Second decimal places mode")
            Toggle(isOn: $📱.🚩autoCompleteOption) {
                Label("Auto complete", systemImage: "checkmark.circle.trianglebadge.exclamationmark")
            }
        } header: {
            Text("Option")
        }
        self.ⓞpenHealthAppButton()
        ℹ️AboutAppLink(name: "TapTemperature", subtitle: "App for iPhone")
        📣ADMenuLink()
    }
    private func ⓞpenHealthAppButton() -> some View {
        Link (destination: URL(string: "x-apple-health://")!) {
            HStack {
                Label {
                    Text("Open \"Health\" app")
                } icon: {
                    Image(systemName: "app")
                        .overlay {
                            Image(systemName: "heart")
                                .scaleEffect(0.55)
                                .font(.body.bold())
                        }
                        .imageScale(.large)
                }
                Spacer()
                Image(systemName: "arrow.up.forward.app")
                    .foregroundStyle(.secondary)
            }
        }
    }
}
