import SwiftUI

@main
struct iOSApp: App {
    @UIApplicationDelegateAdaptor private var appModel: 📱AppModel
    @StateObject private var iapModel = 🛒StoreModel(id: "TapTemperature.adfree")
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(self.iapModel)
        }
    }
}
