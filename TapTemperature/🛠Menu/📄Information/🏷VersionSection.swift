
import SwiftUI

struct 🏷VersionSection: View {
    var body: some View {
        Section {
            NavigationLink {
                ScrollView {
                    Text(🕒VersionHistory)
                        .padding()
                }
                .navigationBarTitle("Version History")
                .navigationBarTitleDisplayMode(.inline)
                .textSelection(.enabled)
            } label: {
                Label(🕒LatestVersionNumber, systemImage: "signpost.left")
            }
            .accessibilityLabel("Version History")
        } header: {
            Text("Version")
        } footer: {
            let 📅 = Date.now.formatted(date: .numeric, time: .omitted)
            Text("builded on \(📅)")
        }
    }
}


let 🕒LatestVersionNumber = "1.0.2"

let 🕒LatestVersionDescription = """
Add main 3 words localization(Body Temperature/Basal body temperature/Health).
Build on latest development environment(iOS16).
==== Japanese(native) ====
メイン単語のローカライズ(体温/基礎体温/ヘルスケア)を追加。
最新開発環境(iOS16)でビルドしました。
"""

var 🕒VersionHistory: String {
    var 📃 = "🕒 Version " + 🕒LatestVersionNumber + " : "
    📃 += "(builded on " + Date.now.formatted(date: .numeric, time: .omitted) + ")\n"
    📃 += 🕒LatestVersionDescription + "\n\n\n"
    📃 += 🕒PastVersionHistory
    return 📃
}

let 🕒PastVersionHistory = """
🕒 Version 1.0.1 : 2022-06-30
- Add AD banner
- Add "Hide AD banner" option. (In-App Purchase)
- Refactoring
==== Japanese(native) ====
- 広告バナーの追加
- 広告バナー非表示オプション(アプリ内課金)を追加
- リファクタリング
🕒 Version 1.0 : 2022-06-01
Initial release
"""
