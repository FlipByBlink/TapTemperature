
import SwiftUI
import StoreKit

struct 📣ADMenu: View {
    @EnvironmentObject var 🛒: 🛒StoreModel
    
    var body: some View {
        Section {
            if 🛒.🚩Purchased == false {
                📣ADView()
            }
            
            NavigationLink {
                List {
                    Section {
                        Text("This App shows banner advertisement about applications on AppStore. These are Apps by TapTemperature developer. AD banner is presented on result screen. It is activated after you launch this app 5 times.")
                            .padding()
                    } header: {
                        Text("About")
                    }
                    
                    
                    🛒PurchaseSection()
                    
                    
                    Section {
                        ForEach(📣AppName.allCases) { 🏷 in
                            📣ADView(🏷)
                        }
                    }
                }
                .navigationTitle("About AD")
            } label: {
                Label("About AD", systemImage: "megaphone")
            }
        }
    }
}
