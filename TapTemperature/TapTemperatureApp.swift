
import SwiftUI

@main
struct TapTemperatureApp: App {
    
    let 📱 = 📱AppModel()
    
    let 🛒 = 🛒StoreModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(📱)
                .environmentObject(🛒)
        }
    }
}
