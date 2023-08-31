import SwiftUI

@main
struct watchOSApp: App {
    @WKApplicationDelegateAdaptor private var ⓓelegate: 🅂yncDelegate
    @StateObject private var model = 📱AppModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.model)
        }
    }
}
