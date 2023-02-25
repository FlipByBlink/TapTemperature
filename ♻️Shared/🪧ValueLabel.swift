import SwiftUI

struct 🪧ValueLabel: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            if 📱.🧩components.indices.contains(0) {
                Text("10").opacity(0)
                    .overlay(alignment: .trailing) {
                        Text(📱.🧩components[0].description)
                    }
                    .lineLimit(1)
            } else {
                Text("10").opacity(0)
                    .overlay(alignment: .trailing) {
                        Text("_")
                    }
                    .lineLimit(1)
            }
            
            if 📱.🧩components.indices.contains(1) {
                Text(📱.🧩components[1].description)
            } else {
                Text("0").opacity(0)
                    .overlay {
                        Text("_")
                            .opacity(📱.🧩components.count < 1 ? 0 : 1)
                    }
            }
            
            Text(".")
            
            if 📱.🧩components.indices.contains(2) {
                Text(📱.🧩components[2].description)
            } else {
                Text("0").opacity(0)
                    .overlay {
                        Text("_")
                            .opacity(📱.🧩components.count < 2 ? 0 : 1)
                    }
            }
            
            if 📱.🧩components.indices.contains(3) {
                Text(📱.🧩components[3].description)
            } else {
                if 📱.🚩secondDecimalPlaceOption {
                    Text("0").opacity(0)
                        .overlay {
                            Text("_")
                                .opacity(📱.🧩components.count < 3 ? 0 : 1)
                        }
                }
            }
            
            Text(📱.📏unitOption.rawValue)
                .font(.system(size: self.ⓕontSize * 0.6, weight: .medium))
        }
        .font(.system(size: self.ⓕontSize, weight: .bold))
        .monospacedDigit()
    }
    private var ⓕontSize: CGFloat {
#if os(iOS)
        return 64
#endif
#if os(watchOS)
        return 22
#endif
    }
}
