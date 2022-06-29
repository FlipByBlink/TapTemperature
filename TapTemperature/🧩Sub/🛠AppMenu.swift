
import SwiftUI

struct 🛠AppMenu: View {
    @EnvironmentObject var 📱: 📱AppModel
    
    var body: some View {
        Section {
            Picker(selection: $📱.📏Unit) {
                ForEach(📏DegreeUnit.allCases) { 📏 in
                    Text(📏.rawValue)
                }
            } label: {
                Label("℃  /  ℉", systemImage: "ruler")
            }
            .accessibilityLabel("Unit")
            
            
            Toggle(isOn: $📱.🚩BasalTemp) {
                Label("Basal body temperature", systemImage: "bed.double")
            }
            .onChange(of: 📱.🚩BasalTemp) { _ in
                📱.🏥RequestAuthorization(.basalBodyTemperature)
            }
            
            
            Toggle(isOn: $📱.🚩2DecimalPlace) {
                let 🪧: String = {
                    switch 📱.📏Unit {
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
                Image(systemName: "app")
                    .overlay {
                        Image(systemName: "heart")
                            .scaleEffect(0.55)
                            .font(.body.bold())
                    }
                    .imageScale(.large)
                    .padding(.horizontal, 2)
                
                Text("Open \"Health\" app")
                
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
        if 📱.🕒History == "" {
            Image(systemName: "text.append")
                .foregroundStyle(.tertiary)
                .font(.system(size: 64))
                .navigationTitle("History")
                .navigationBarTitleDisplayMode(.inline)
        } else {
            ScrollView {
                ScrollView(.horizontal, showsIndicators: false) {
                    Text(📱.🕒History)
                        .font(.subheadline)
                        .padding()
                        .textSelection(.enabled)
                        .navigationTitle("History")
                        .navigationBarTitleDisplayMode(.inline)
                        .toolbar {
                            ToolbarItem(placement: .navigationBarTrailing) {
                                Button {
                                    📱.🕒History = ""
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
