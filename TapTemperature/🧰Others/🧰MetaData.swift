import Foundation

let 📜versionInfos = 📜VersionInfo.history(("1.1", "2023-02-24"),
                                           ("1.0.3", "2022-12-09"),
                                           ("1.0.2", "2022-09-20"),
                                           ("1.0.1", "2022-06-30"),
                                           ("1.0", "2022-06-01"))

let 🔗appStoreProductURL = URL(string: "https://apps.apple.com/app/id1626760566")!

let 👤privacyPolicy = """
2022-05-31
                            
### Japanese
このアプリ自身において、ユーザーの情報を一切収集しません。

### English
This application don't collect user infomation.
"""

let 🔗webRepositoryURL = URL(string: "https://github.com/FlipByBlink/TapTemperature")!
let 🔗webRepositoryURL_Mirror = URL(string: "https://gitlab.com/FlipByBlink/TapTemperature_Mirror")!

enum 📁SourceCodeCategory: String, CaseIterable, Identifiable {
    case main, Shared, Sub, Others, WatchApp, WatchComplication
    var id: Self { self }
    var fileNames: [String] {
        switch self {
            case .main:
                return ["TapTemperatureApp.swift",
                        "ContentView.swift"]
            case .Shared:
                return ["📱AppModel.swift",
                        "🪧ValueLabel.swift",
                        "👆Keypad.swift",
                        "🛏BBTSwitchButton.swift",
                        "⌚️SyncDelegate.swift",
                        "💥Feedback.swift"]
            case .Sub:
                return ["🗯ResultView.swift",
                        "💟OpenHealthAppButton.swift",
                        "🛠Menu.swift",
                        "⌚️SyncOptions.swift",
                        "📣ADSheet.swift",
                        "🟥AutoCompleteHintView.swift"]
            case .Others:
                return ["🧰MetaData.swift",
                        "ℹ️AboutApp.swift",
                        "📣AD.swift",
                        "🛒InAppPurchase.swift"]
            case .WatchApp:
                return ["WatchApp/TTApp.swift",
                        "WatchApp/ContentView.swift",
                        "WatchApp/🗯ResultView.swift"]
            case .WatchComplication:
                return ["WatchComplication/TTWidget.swift"]
        }
    }
}
