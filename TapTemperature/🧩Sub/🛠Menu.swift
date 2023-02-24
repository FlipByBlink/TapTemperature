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
