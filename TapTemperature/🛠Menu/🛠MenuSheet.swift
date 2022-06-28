
import SwiftUI
import HealthKit

struct 🛠MenuSheet: View {
    @EnvironmentObject var 📱: 📱AppModel
    
    @Environment(\.dismiss) var 🔙: DismissAction
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Picker(selection: $📱.💾Unit) {
                        ForEach(📏EnumUnit.allCases, id: \.self) { 📏 in
                            Text(📏.rawValue)
                        }
                    } label: {
                        Label("℃  /  ℉", systemImage: "ruler")
                    }
                    .accessibilityLabel("Unit")
                    .onChange(of: 📱.💾Unit) { _ in
                        📱.🧩Reset()
                    }


                    Toggle(isOn: $📱.🚩BasalTemp) {
                        Label("Basal body temperature", systemImage: "bed.double")
                    }
                    .onChange(of: 📱.🚩BasalTemp) { _ in
                        📱.🏥RequestAuthorization(HKQuantityType(.basalBodyTemperature))
                    }


                    Toggle(isOn: $📱.🚩2DecimalPlace) {
                        let 🪧: String = {
                            switch 📱.💾Unit {
                                case .℃: return "36.1 ℃  →  36.12︭ ℃"
                                case .℉: return "100.1 ℉  →  100.12︭ ℉"
                            }
                        }()

                        Label(🪧, systemImage: "character.cursor.ibeam")
                    }
                    .accessibilityLabel("Second decimal places mode")


                    Toggle(isOn: $📱.🚩AutoComplete) {
                        Label("Auto complete", systemImage: "checkmark.circle.trianglebadge.exclamationmark")
                    }
                } header: {
                    Text("Option")
                }


                Link (destination: URL(string: "x-apple-health://")!) {
                    HStack {
                        Label("Open \"Health\" app", systemImage: "heart")

                        Spacer()

                        Image(systemName: "arrow.up.forward.app")
                    }
                    .font(.body.weight(.medium))
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
                
                
                📣ADMenu()
                
                
                📄InformationMenu()
            }
            .navigationTitle("TapTemperature")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        🔙.callAsFunction()
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
}
