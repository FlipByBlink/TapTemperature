import SwiftUI

@main
struct watchOSApp: App {
    @WKApplicationDelegateAdaptor private var model: 📱AppModel
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
