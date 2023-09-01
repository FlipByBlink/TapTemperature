import SwiftUI

@main
struct iOSApp: App {
    @UIApplicationDelegateAdaptor private var appModel: 📱AppModel
    @StateObject private var iapModel = 🛒InAppPurchaseModel(id: "TapTemperature.adfree")
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.iapModel)
        }
    }
}
