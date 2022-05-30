
import SwiftUI


struct 📄DocumentMenu: View {
    var body: some View {
        NavigationLink {
            List {
                Section {
                    Label("1.0" , systemImage: "signpost.left")
                } header: {
                    Text("Version")
                } footer: {
                    let 📅 = Date.now.formatted(date: .numeric, time: .omitted)
                    Text("builded on \(📅)")
                }
                
                
                Section {
                    NavigationLink {
                        ScrollView {
                            📋PageView(📄AboutEN, "About app")
                        }
                    } label: {
                        Text(📄AboutEN)
                            .font(.subheadline)
                            .lineLimit(7)
                            .padding(8)
                    }
                    
                    NavigationLink {
                        ScrollView {
                            📋PageView(📄AboutJA, "アプリのついて")
                        }
                    } label: {
                        Text(📄AboutJA)
                            .font(.subheadline)
                            .lineLimit(7)
                            .padding(8)
                    }
                } header: {
                    Text("About")
                }
                
                
                let 🔗 = "https://apps.apple.com/developer/idPLACEHOLDER"
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
                    Text("""
                        2022-0?-??
                        (English)This application don't collect user infomation.
                        (Japanese)このアプリ自身において、ユーザーの情報を一切収集しません。
                        """)
                    .font(.subheadline)
                    .padding(8)
                    .textSelection(.enabled)
                } header: {
                    Text("Privacy Policy")
                }
                
                
                NavigationLink {
                    📓SourceCodeDoc()
                } label: {
                    Label("Source code", systemImage: "doc.plaintext")
                }
            }
            .navigationTitle("App Document")
        } label: {
            Label("App Document", systemImage: "doc")
        }
    }
}


struct 📓SourceCodeDoc: View {
    @Environment(\.dismiss) var 🔙: DismissAction
    
    var body: some View {
        List {
            📰CodeSection("📁Primary")
            
            📰CodeSection("📁Secondary")
            
            📄BundleMainInfoDictionary()
            
            
            let 🔗HealthKit = "https://developer.apple.com/documentation/healthkit"
            Section {
                Link(destination: URL(string: 🔗HealthKit)!) {
                    HStack {
                        Label("HealthKit document link", systemImage: "link")
                        
                        Spacer()
                        
                        Image(systemName: "arrow.up.forward.app")
                    }
                }
            } footer: {
                Text(🔗HealthKit)
            }
            
            
            let 🔗Repository = "https://github.com/FlipByBlink/PLACEHOLDER"
            Section {
                Link(destination: URL(string: 🔗Repository)!) {
                    HStack {
                        Label("Web Repository link", systemImage: "link")
                        
                        Spacer()
                        
                        Image(systemName: "arrow.up.forward.app")
                    }
                }
            } footer: {
                Text(🔗Repository)
            }
        }
        .navigationTitle("Source code")
    }
}


struct 📰CodeSection: View {
    var 🄳irectoryPath: String
    
    var 📁URL: URL {
        Bundle.main.bundleURL.appendingPathComponent(🄳irectoryPath)
    }
    
    var 🏷Name: [String] {
        try! FileManager.default.contentsOfDirectory(atPath: 📁URL.path)
    }
    
    var body: some View {
        Section {
            ForEach(🏷Name, id: \.self) { 🏷 in
                NavigationLink(🏷) {
                    let 📍 = 📁URL.appendingPathComponent(🏷)
                    
                    ScrollView(.vertical) {
                        ScrollView(.horizontal, showsIndicators: false) {
                            📋PageView(try! String(contentsOf: 📍), 🏷)
                        }
                    }
                }
            }
        }
    }
    
    init(_ ⓓirectoryPath: String) {
        🄳irectoryPath = ⓓirectoryPath
    }
}


let 🄱undleMainInfoDictionary = Bundle.main.infoDictionary!.description
struct 📄BundleMainInfoDictionary: View {
    var body: some View {
        Section {
            NavigationLink("Bundle.main.infoDictionary") {
                ScrollView {
                    📋PageView(🄱undleMainInfoDictionary, "Bundle.main.infoDictionary")
                }
            }
        }
    }
}


let 📄AboutEN = """
                    AboutEN PLACEHOLDER
                    """

let 📄AboutJA = """
                    AboutJA PLACEHOLDER
                    """
