import SwiftUI

struct 🛠MenuButton: View {
    @State private var showSheet: Bool = false
    var body: some View {
        Button {
            self.showSheet = true
            💥Feedback.light()
        } label: {
            Label("Open menu", systemImage: "gearshape")
        }
        .tint(.primary)
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
                💟OpenHealthApp.buttonOnList()
                self.aboutAppMenuLink()
                🛒InAppPurchaseMenuLink()
            }
            .navigationTitle("Menu")
            .toolbar { self.dismissButton() }
        }
    }
}

private extension 🛠Menu {
    private func dismissButton() -> some View {
        Button {
            self.dismiss()
            💥Feedback.light()
        } label: {
            Image(systemName: "xmark.circle.fill")
                .symbolRenderingMode(.hierarchical)
                .foregroundStyle(Color.secondary)
        }
    }
    private func basalBodyTemperatureToggle() -> some View {
        Toggle(isOn: self.$model.ableBBT) {
            Label("Basal body temperature", systemImage: "bed.double")
        }
        .onChange(of: self.model.ableBBT) {
            if $0 { self.model.setUpHealthStore(.basalBodyTemperature) }
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
        Section {
            ℹ️IconAndName()
            ℹ️AppStoreLink()
            NavigationLink {
                List { ℹ️AboutAppContent() }
                    .navigationTitle(String(localized: "About App", table: "🌐AboutApp"))
            } label: {
                Label(String(localized: "About App", table: "🌐AboutApp"),
                      systemImage: "doc")
            }
        }
    }
}
