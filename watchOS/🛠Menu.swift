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
                .padding(8)
        }
        .padding(.trailing, 4)
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
                    self.basalBodyTemperatureToggle()
                } header: {
                    Text("Option")
                }
                self.secondDecimalPlaceToggle()
                self.autoCompleteToggle()
                self.aboutAppMenuLink()
            }
            .navigationTitle("Menu")
        }
    }
}

private extension 🛠Menu {
    private func basalBodyTemperatureToggle() -> some View {
        Toggle(isOn: self.$model.ableBBT) {
            Label("Basal body temperature", systemImage: "bed.double")
        }
        .onChange(of: self.model.ableBBT) { _ in
            self.model.setUpHealthStore(.basalBodyTemperature)
        }
    }
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
    private func aboutAppMenuLink() -> some View {
        NavigationLink {
            ℹ️AboutAppMenu()
        } label: {
            Label(String(localized: "About App", table: "🌐AboutApp"),
                  systemImage: "doc")
        }
    }
}
