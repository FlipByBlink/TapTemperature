
import SwiftUI
import HealthKit


struct 🛠MenuButton: View { // ⚙️
    
    @State private var 🚩Menu: Bool = false
    
    var body: some View {
        Button {
            🚩Menu = true
        } label: {
            Image(systemName: "gearshape")
                .font(.title)
        }
        .tint(.primary)
        .popover(isPresented: $🚩Menu) {
            🛠Menu()
        }
    }
}


enum 📏EnumUnit: String, CaseIterable {
    case ℃
    case ℉
}


struct 🛠Menu: View {
    @EnvironmentObject var 📱:📱Model
    
    @Environment(\.dismiss) var 🔚: DismissAction
    
    var body: some View {
        NavigationView {
            List {
                Section {
                    Picker(selection: $📱.💾Unit) {
                        ForEach(📏EnumUnit.allCases, id: \.self) { 🏷 in
                            Text(🏷.rawValue)
                        }
                    } label: {
                        Label("℃  /  ℉", systemImage: "ruler")
                    }
                    .onChange(of: 📱.💾Unit) { _ in
                        📱.🧩Reset()
                    }
                    
                    Toggle(isOn: $📱.🚩BasalTemp) {
                        Label("Basal body temperature", systemImage: "bed.double")
                    }
                    .onChange(of: 📱.🚩BasalTemp) { _ in
                        📱.🏥RequestAuthorization(HKQuantityType(.basalBodyTemperature))
                    }
                } header: {
                    Text("Option")
                }
                
                
                Section {
                    Toggle(isOn: $📱.🚩AutoComplete) {
                        Label("Auto complete", systemImage: "checkmark.circle.trianglebadge.exclamationmark")
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
                }
                
                
                Section {
                    NavigationLink {
                        List {
                            NavigationLink {
                                🕛HistoryView(🄷istory: $📱.🄷istoryTemp)
                            } label: {
                                Text("Body temperature")
                            }
                            
                            NavigationLink {
                                🕛HistoryView(🄷istory: $📱.🄷istoryBasalTemp)
                            } label: {
                                Text("Basal body temperature")
                            }
                        }
                    } label: {
                        Label("Local history", systemImage: "doc")
                    }
                }
                
                
                Link (destination: URL(string: "x-apple-health://")!) {
                    HStack {
                        Label("🌏Open \"Health\" app", systemImage: "heart")
                        
                        Spacer()
                        
                        Image(systemName: "arrow.up.forward.app")
                    }
                    .font(.body.weight(.medium))
                }
                
                
                Section {
                    Label("App Document", systemImage: "doc")
                        .foregroundStyle(.secondary)
                }
            }
            .navigationTitle("TapTemperature")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button {
                        🔚.callAsFunction()
                    } label: {
                        Image(systemName: "chevron.down")
                            .foregroundStyle(.secondary)
                            .grayscale(1.0)
                            .padding(8)
                    }
                    .accessibilityLabel("🌏Dismiss")
                }
            }
        }
    }
}


struct 🕛HistoryView: View {
    @Binding var 🄷istory: String
    
    var body: some View {
        if 🄷istory == "" {
            Image(systemName: "text.append")
                .foregroundStyle(.tertiary)
                .font(.system(size: 64))
                .navigationTitle("History")
                .navigationBarTitleDisplayMode(.inline)
        } else {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    📄PageView(🄷istory, "History")
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    🄷istory = ""
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


struct 📄PageView: View {
    var 📄: String
    
    var 🏷: String
    
    var body: some View {
        Text(📄)
            .navigationBarTitle(🏷)
            .navigationBarTitleDisplayMode(.inline)
            .font(.caption.monospaced())
            .padding()
            .textSelection(.enabled)
    }
    
    init(_ 📄: String, _ 🏷: String) {
        self.📄 = 📄
        self.🏷 = 🏷
    }
}
