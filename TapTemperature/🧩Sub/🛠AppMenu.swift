import SwiftUI

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
            Toggle(isOn: $📱.🚩2DecimalPlaceOption) {
                Label(📱.📏unitOption.menuLabel, systemImage: "character.cursor.ibeam")
            }
            .accessibilityLabel("Second decimal places mode")
            Toggle(isOn: $📱.🚩autoCompleteOption) {
                Label("Auto complete", systemImage: "checkmark.circle.trianglebadge.exclamationmark")
            }
        } header: {
            Text("Option")
        }
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
        Section {
            NavigationLink {
                🕛HistoryView()
            } label: {
                Label("Local history", systemImage: "clock")
            }
        } footer: {
            Text("\"Local history\" is for the porpose of \"operation check\" / \"temporary backup\"")
        }
    }
}

struct 🕛HistoryView: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        if 📱.🕒history == "" {
            Image(systemName: "text.append")
                .foregroundStyle(.tertiary)
                .font(.system(size: 64))
                .navigationTitle("History")
                .navigationBarTitleDisplayMode(.inline)
        } else {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    Text(📱.🕒history)
                        .font(.subheadline)
                        .padding()
                        .textSelection(.enabled)
                        .navigationTitle("History")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    📱.🕒history = ""
                                } label: {
                                    Image(systemName: "trash")
                                        .tint(.red)
                                }
                            }
                        }
                }
            }
        }
    }
}
