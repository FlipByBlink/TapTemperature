
import SwiftUI

@main
struct TapTemperatureApp: App {
    
    let 📱 = 📱AppModel()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(📱)
        }
    }
}
