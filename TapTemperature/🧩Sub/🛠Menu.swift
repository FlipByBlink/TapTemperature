import SwiftUI

struct 🛠MenuButton: View {
    var body: some View {
        NavigationLink {
            List { 🛠MenuContent() }
                .navigationTitle("Menu")
        } label: {
            Label("Open menu", systemImage: "gearshape")
        }
        .tint(.primary)
    }
}

struct 🛠MenuContent: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        Section {
            //Picker(selection: $📱.📏unitOption) {
            //    ForEach(📏DegreeUnit.allCases) { Text($0.rawValue) }
            //} label: {
            //    Label("Unit", systemImage: "ruler")
            //}
            Toggle(isOn: $📱.🚩bbtOption) {
                Label("Basal body temperature", systemImage: "bed.double")
            }
            .onChange(of: 📱.🚩bbtOption) { _ in
                Task { await 📱.🏥setUp(.basalBodyTemperature) }
            }
        } header: {
            Text("Option")
        }
        self.ⓢecondDecimalPlaceToggle()
        self.ⓐutoCompleteToggle()
        self.ⓞpenHealthAppButton()
        ℹ️AboutAppLink(name: "TapTemperature", subtitle: "App for iPhone")
        📣ADMenuLink()
    }
    private func ⓢecondDecimalPlaceToggle() -> some View {
        Section {
            Toggle(isOn: $📱.🚩secondDecimalPlaceOption) {
                Label("Second decimal place mode", systemImage: "character.cursor.ibeam")
            }
        } footer: {
            Text(📱.📏unitOption == .℃ ? "36.1 ℃  →  36.12︭ ℃" : "100.1 ℉  →  100.12︭ ℉")
        }
    }
    private func ⓐutoCompleteToggle() -> some View {
        Section {
            Toggle(isOn: $📱.🚩autoCompleteOption) {
                Label("Auto complete",
                      systemImage: "checkmark.circle.trianglebadge.exclamationmark")
            }
        } footer: {
            Text("Save 1 step.")
        }
    }
    private func ⓞpenHealthAppButton() -> some View {
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
