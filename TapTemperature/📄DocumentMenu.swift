
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
                            📋PageView(📄About, "About")
                        }
                    } label: {
                        Text(📄About)
                            .font(.subheadline)
                            .lineLimit(10)
                            .padding(8)
                    }
                } header: {
                    Text("About")
                }
                
                
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
                            
                            (English)This application don't collect user infomation.
                            
                            (Japanese)このアプリ自身において、ユーザーの情報を一切収集しません。
                            """)
                                .padding(32)
                                .textSelection(.enabled)
                                .navigationTitle("Privacy Policy")
                    } label: {
                        Label("Privacy Policy", systemImage: "person.text.rectangle")
                    }
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
            
            
            let 🔗Repository = "https://github.com/FlipByBlink/TapTemperature"
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


let 📄About = """
                This application is designed to register body temperature data to the Apple "Health" application pre-installed on iPhone in the fastest possible way (as manual).
                
                People frequently measure their body temperature (and basal body temperature) daily using a thermometer. Many iPhone users register their temperature data on "Health" app. The best solution is to use a smart thermometer that works with "Health" app and automatically stores measurements, but they are expensive and almost non-existent. Manual data registration is possible in "Health" app, but "Health" app is not designed for daily manual data registration. Therefore, manually entering data that occur continuously daily, such as temperature measurements, is a very time-consuming and stressful experience. This app was developed to solve such problems.
                
                This app cannot read, view, or manage past data in "Health" app. This app is intended only to register data to the "Health" app. Please check the registered data on the "Health" app.
                
                【Target/Use-case】
                
                No "smart" thermometer.
                
                Frequently measure my temperature (and basal body temperature) using a thermometer almost every day.
                
                Intend to register the data into "Health" app every time, after measuring by a thermometer.
                
                【OPTION】
                
                Unit: ℃, ℉
                
                Mode as basal body temperature.
                
                Mode for second decimal places.
                
                Auto complete function.
                
                【OTHERS】
                
                Launch "Health" app by one tap.
                
                Local history for the purpose of "operation check" / "temporary backup".
                
                Cancellation by one tap just after you registered a data.
                
                Check source code in app.
                
                All feature is completely free. Non ad. Non tracking.
                
                
                ==== Native(japanese) ====
                
                iPhoneにプリインストールされているApple「ヘルスケア」アプリに体温データを(手動としては)最速で登録するためのアプリです。
                
                人々は体温計を用いて体温(や基礎体温)は日々頻繁に計測します。多くのiPhoneユーザーは「ヘルスケア」アプリ上に体温(や基礎体温)のデータを登録しています。「ヘルスケア」アプリと連携して自動的に計測データを保存してくれるスマート体温計を用いることが最高の解決策ではありますが、それらは高価であったり入手性が低かったりします。「ヘルスケア」アプリ上で手動でもデータ登録は可能ですが、残念ながら「ヘルスケア」アプリは計測データを日常的に手動で登録することを想定されていません。そのため、体温測定のような日々継続的に発生するデータを手動で入力することは大いに手間が掛かりストレスフルな体験になります。そうした課題を解決するためにこのアプリは開発しました。
                
                このアプリでは「ヘルスケア」アプリ上の過去のデータの読み込みや閲覧、管理等は出来ません。このアプリは「ヘルスケア」アプリへのデータ登録のみを目的としています。登録したデータは「ヘルスケア」アプリ上で確認してください。
                
                【想定ユーザー/ユースケース】
                
                スマート体温計を持っていない。
                
                日常的に体温(か基礎体温)を体温計で計測している。
                
                普通の体温計で測定した直後、毎回手動で測定結果を「ヘルスケア」アプリに登録する事を検討している。
                
                【オプション】
                
                単位: ℃, ℉
                
                基礎体温モード。
                
                小数点以下2桁モード。
                
                数字入力だけで自動的に完了する機能。
                
                【その他】
                
                このアプリ内からApple「ヘルスケア」アプリをワンタップで立ち上げ可能。
                
                動作確認や簡易バックアップを想定した端末内での履歴機能。
                
                データ登録直後にワンタップで登録取り消しする機能。
                
                アプリ内でアプリ自身のソースコードを確認できる機能。
                
                すべての機能を無料で利用できます。無広告。無トラッキング。
                
                """
