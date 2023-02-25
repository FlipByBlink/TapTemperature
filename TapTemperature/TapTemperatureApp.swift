import SwiftUI

@main
struct TapTemperatureApp: App {
    @UIApplicationDelegateAdaptor private var ⓓelegate: 🅂yncDelegate
    @StateObject private var 📱 = 📱AppModel()
    @StateObject private var 🛒 = 🛒StoreModel(id: "TapTemperature.adfree")
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modifier(📣ADSheet())
                .environmentObject(📱)
                .environmentObject(🛒)
        }
    }
}
