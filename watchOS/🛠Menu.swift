import SwiftUI

struct 🛠MenuButton: View {
    @State private var showSheet: Bool = false
    var body: some View {
        Button {
            self.showSheet = true
            💥Feedback.light()
        } label: {
            Label("Open menu", systemImage: "gearshape")
                .labelStyle(.iconOnly)
        }
        .tint(.primary)
        .buttonStyle(.plain)
        .sheet(isPresented: self.$showSheet) {
            🛠Menu()
        }
    }
}

private struct 🛠Menu: View {
    @EnvironmentObject var model: 📱AppModel
    @Environment(\.dismiss) var dismiss
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Toggle(isOn: self.$model.ableBBT) {
                        Label("Basal body temperature", systemImage: "bed.double")
                    }
                    .onChange(of: self.model.ableBBT) { _ in
                        Task { await self.model.setUpHealthStore(.basalBodyTemperature) }
                    }
                } header: {
                    Text("Option")
                }
                self.secondDecimalPlaceToggle()
                self.autoCompleteToggle()
                NavigationLink {
                    ℹ️AboutAppMenu()
                } label: {
                    Label(String(localized: "About App", table: "🌐AboutApp"),
                          systemImage: "doc")
                }
            }
            .navigationTitle("Menu")
        }
    }
}

private extension 🛠Menu {
    private func secondDecimalPlaceToggle() -> some View {
        Section {
            Toggle(isOn: self.$model.ableSecondDecimalPlace) {
                Label("Input second decimal place", systemImage: "character.cursor.ibeam")
            }
        } footer: {
            Text(self.model.degreeUnit == .℃ ? "36.1 ℃  →  36.12︭ ℃" : "100.1 ℉  →  100.12︭ ℉")
        }
    }
    private func autoCompleteToggle() -> some View {
        Section {
            Toggle(isOn: self.$model.ableAutoComplete) {
                Label("Auto complete",
                      systemImage: "checkmark.circle.trianglebadge.exclamationmark")
            }
        } footer: {
            Text("Save 1 step.")
        }
    }
}
