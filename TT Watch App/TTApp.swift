import SwiftUI

@main
struct TT_Watch_App: App {
    @StateObject private var 📱 = 📱AppModel()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(📱)
        }
    }
}
