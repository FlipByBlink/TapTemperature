
import SwiftUI

@main
struct TapTemperatureApp: App {
    
    @StateObject var 📱 = 📱AppModel()
    
    @StateObject var 🛒 = 🛒StoreModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(📱)
                .environmentObject(🛒)
        }
    }
}
