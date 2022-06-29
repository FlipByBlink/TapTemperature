
import SwiftUI

struct 📄InformationMenu: View {
    var body: some View {
        NavigationLink {
            List {
                Section {
                    NavigationLink {
                        ScrollView {
                            Text(📄AppDescription)
                                .padding()
                        }
                        .navigationBarTitle("About")
                        .navigationBarTitleDisplayMode(.inline)
                        .textSelection(.enabled)
                    } label: {
                        Text(📄AppDescription)
                            .font(.subheadline)
                            .lineLimit(4)
                            .padding(8)
                            .accessibilityLabel("About")
                    }
                } header: {
                    Text("About")
                }
                
                
                🏷VersionSection()
                
                
                let 🔗 = "https://apps.apple.com/app/id1626760566"
                Section {
                    Link(destination: URL(string: 🔗)!) {
                        HStack {
                            Label("Open AppStore page", systemImage: "link")
                            
                            Spacer()
                            
                            Image(systemName: "arrow.up.forward.app")
                        }
                    }
                } footer: {
                    Text(🔗)
                }
                
                
                Section {
                    NavigationLink {
                        Text("""
                            2022-05-31
                            
                            ### Japanese
                            このアプリ自身において、ユーザーの情報を一切収集しません。
                            
                            ### English
                            This application don't collect user infomation.
                            """)
                        .padding(32)
                        .textSelection(.enabled)
                        .navigationTitle("Privacy Policy")
                    } label: {
                        Label("Privacy Policy", systemImage: "person.text.rectangle")
                    }
                }
                
                
                NavigationLink {
                    📓SourceCodeMenu()
                } label: {
                    Label("Source code", systemImage: "doc.plaintext")
                }
                
                
                NavigationLink {
                    🧑‍💻AboutDeveloperPublisher()
                } label: {
                    Label("Developer / Publisher", systemImage: "person")
                }
            }
            .navigationTitle("Information")
        } label: {
            Label("Information", systemImage: "doc")
        }
    }
}


struct 🧑‍💻AboutDeveloperPublisher: View {
    var body: some View {
        List {
            Section {
                Text("Individual")
            } header: {
                Text("The System")
            }
            
            
            Section {
                Text("山下 亮")
                
                Text("やました りょう (ひらがな)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                Text("Yamashita Ryo (alphabet)")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            } header: {
                Text("Name")
            } footer: {
                Text("only one person")
            }
            
            
            Section {
                HStack {
                    Text("age")
                    Spacer()
                    Text("about 28")
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Text("country")
                    Spacer()
                    Text("Japan")
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Text("native language")
                    Spacer()
                    Text("Japanese")
                        .foregroundStyle(.secondary)
                }
                
                HStack {
                    Text("income")
                    Spacer()
                    Text("almost nothing")
                        .foregroundStyle(.secondary)
                }
            } header: {
                Text("identity / circumstance / background")
            } footer: {
                Text("As of 2021")
            }
            
            
            Section {
                Image("Developer_Publisher")
                    .resizable()
                    .frame(width: 90, height: 90)
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                    .padding()
                    .opacity(0.5)
            } header: {
                Text("Image")
            } footer: {
                Text("Taken on 2021-11")
            }
        }
        .navigationTitle("Developer / Publisher")
    }
}
