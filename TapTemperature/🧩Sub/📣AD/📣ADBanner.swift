
import SwiftUI

struct 📣ADBanner: View {
    @EnvironmentObject var 🛒: 🛒StoreModel
    
    @State private var 🚩ShowBanner = false
    
    @AppStorage("🄻aunchCount") var 🄻aunchCount: Int = 0
    
    let 🅃iming: Int = 2 //4
    
    var body: some View {
        Group {
            if 🛒.🚩Purchased {
                Spacer()
            } else {
                if 🚩ShowBanner {
                    📣ADView()
                        .padding(.horizontal)
                        .background {
                            RoundedRectangle(cornerRadius: 16, style: .continuous)
                                .foregroundStyle(.background)
                                .shadow(radius: 3)
                        }
                        .padding()
                        .frame(minWidth: 300)
                        .environment(\.colorScheme, .light)
                } else {
                    Spacer()
                }
            }
        }
        .onAppear {
            🄻aunchCount += 1
            
            if 🄻aunchCount % 🅃iming == 0 {
                🚩ShowBanner = true
            }
        }
    }
}
