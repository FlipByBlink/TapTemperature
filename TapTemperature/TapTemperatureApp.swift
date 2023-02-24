import SwiftUI

@main
struct TapTemperatureApp: App {
    @StateObject private var 📱 = 📱AppModel()
    @StateObject private var 🛒 = 🛒StoreModel(id: "TapTemperature.adfree")
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .task {
                    await 📱.🏥setUp(.bodyTemperature)
                    📱.🏥observePreferredUnits()
                }
                .modifier(📣ADSheet())
                .environmentObject(📱)
                .environmentObject(🛒)
        }
    }
}
