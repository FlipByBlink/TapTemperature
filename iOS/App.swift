import SwiftUI

@main
struct iOSApp: App {
    @UIApplicationDelegateAdaptor private var ⓓelegate: 🅂yncDelegate
    @StateObject private var appModel = 📱AppModel()
    @StateObject private var iapModel = 🛒StoreModel(id: "TapTemperature.adfree")
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.appModel)
                .environmentObject(self.iapModel)
        }
    }
}
