import SwiftUI

@main
struct TT_Watch_App: App {
    @WKApplicationDelegateAdaptor private var ⓓelegate: 🅂yncDelegate
    @StateObject private var 📱 = 📱AppModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(📱)
        }
    }
}
