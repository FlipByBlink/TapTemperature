import SwiftUI

struct 🛠MenuButton: View {
    var body: some View {
        NavigationLink {
            🛠MenuContent()
        } label: {
            Label("Open menu", systemImage: "gearshape")
        }
        .tint(.primary)
    }
}

private struct 🛠MenuContent: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
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
            self.openHealthAppButton()
            ℹ️AboutAppLink(name: "TapTemperature", subtitle: "App for iPhone / Apple Watch")
            📣ADMenuLink()
        }
        .navigationTitle("Menu")
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
    private func openHealthAppButton() -> some View {
        Link (destination: URL(string: "x-apple-health://")!) {
            HStack {
                Label {
                    Text("Open \"Health\" app")
                } icon: {
                    Image(systemName: "app")
                        .imageScale(.large)
                        .overlay {
                            Image(systemName: "heart")
                                .resizable()
                                .font(.body.weight(.semibold))
                                .scaleEffect(0.5)
                        }
                }
                Spacer()
                Image(systemName: "arrow.up.forward.app")
                    .foregroundStyle(.secondary)
            }
        }
    }
}
