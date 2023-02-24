import SwiftUI

@main
struct TapTemperatureApp: App {
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
