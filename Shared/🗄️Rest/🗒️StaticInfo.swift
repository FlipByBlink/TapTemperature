import SwiftUI

enum 🗒️StaticInfo {
    static let appName: LocalizedStringKey = "TapTemperature"
    static let appSubTitle: LocalizedStringKey = "App for iPhone / iPad / Apple Watch"
    
    static let appStoreProductURL = URL(string: "https://apps.apple.com/app/id1626760566")!
    static var appStoreUserReviewURL: URL { URL(string: "\(Self.appStoreProductURL)?action=write-review")! }
    
    static var contactAddress: String { "sear_pandora_0x@icloud.com" }
    
    static let privacyPolicyDescription = """
        2022-05-31
                            
        ### Japanese
        このアプリ自身において、ユーザーの情報を一切収集しません。
        
        ### English
        This application don't collect user infomation.
        """
    
    static let webRepositoryURL = URL(string: "https://github.com/FlipByBlink/TapTemperature")!
    static let webMirrorRepositoryURL = URL(string: "https://gitlab.com/FlipByBlink/TapTemperature_Mirror")!
}

#if os(iOS)
extension 🗒️StaticInfo {
    static let versionInfos: [(version: String, date: String)] = [
        ("1.3", "2026-03-13"),
        ("1.2", "2023-09-13"),
        ("1.1", "2023-02-26"),
        ("1.0.3", "2022-12-09"),
        ("1.0.2", "2022-09-20"),
        ("1.0.1", "2022-06-30"),
        ("1.0", "2022-06-01")
    ] //降順。先頭の方が新しい
    
    enum SourceCodeCategory: String, CaseIterable, Identifiable {
        case main, Rest, Widget
        var id: Self { self }
        var fileNames: [String] {
            switch self {
                case .main: ["App.swift",
                             "📱AppModel.swift",
                             "ContentView.swift"]
                case .Rest: ["🏳️Mode.swift",
                             "📏DegreeUnit.swift",
                             "📏LoadPrefferedUnit.swift",
                             "🪧ValueLabel.swift",
                             "👆Keypad.swift",
                             "🗯ResultScreen.swift",
                             "🛠Menu.swift",
                             "🛏BBTSwitchButton.swift",
                             "💥Feedback.swift",
                             "🔑Key.swift",
                             "🗑️ResetOnBackground.swift",
                             "💟OpenHealthAppButton.swift",
                             "🟥AutoCompleteHintView.swift",
                             "🚏NavigationTitle.swift",
                             "🚨UnsupportAlert.swift",
                             "🗒️StaticInfo.swift",
                             "ℹ️AboutApp.swift",
                             "📣ADModel.swift",
                             "📣ADSheet.swift",
                             "📣ADComponents.swift",
                             "🛒InAppPurchaseModel.swift",
                             "🛒InAppPurchaseView.swift"]
                case .Widget: ["Widget.swift"]
            }
        }
    }
}

#elseif os(watchOS)
extension 🗒️StaticInfo {
    enum SourceCodeCategory: String, CaseIterable, Identifiable {
        case main, Rest, Widget
        var id: Self { self }
        var fileNames: [String] {
            switch self {
                case .main: ["App.swift",
                             "📱AppModel.swift",
                             "ContentView.swift"]
                case .Rest: ["🏳️Mode.swift",
                             "📏DegreeUnit.swift",
                             "📏LoadPrefferedUnit.swift",
                             "🪧ValueLabel.swift",
                             "👆Keypad.swift",
                             "🗯ResultScreen.swift",
                             "🛠Menu.swift",
                             "💥Feedback.swift",
                             "🔑Key.swift",
                             "🗑️ResetOnBackground.swift",
                             "🗒️StaticInfo.swift",
                             "ℹ️AboutApp.swift"]
                case .Widget: ["Widget.swift"]
            }
        }
    }
}
#endif
