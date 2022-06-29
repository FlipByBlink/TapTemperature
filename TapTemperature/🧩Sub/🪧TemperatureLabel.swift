
import SwiftUI

struct 🪧TemperatureLabel: View {
    @EnvironmentObject var 📱: 📱AppModel
    
    var body: some View {
        HStack(alignment: .firstTextBaseline) {
            if 📱.🧩Temp.indices.contains(0) {
                Text("10").opacity(0)
                    .overlay(alignment: .trailing) {
                        Text(📱.🧩Temp[0].description)
                            .minimumScaleFactor(0.1)
                    }
                    .lineLimit(1)
            } else {
                Text("10").opacity(0)
                    .overlay(alignment: .trailing) {
                        Text("_")
                    }
                    .lineLimit(1)
            }
            
            
            if 📱.🧩Temp.indices.contains(1) {
                Text(📱.🧩Temp[1].description)
            } else {
                Text("0").opacity(0)
                    .overlay {
                        Text("_")
                            .opacity(📱.🧩Temp.count < 1 ? 0 : 1)
                    }
            }
            
            
            Text(".")
            
            
            if 📱.🧩Temp.indices.contains(2) {
                Text(📱.🧩Temp[2].description)
            } else {
                Text("0").opacity(0)
                    .overlay {
                        Text("_")
                            .opacity(📱.🧩Temp.count < 2 ? 0 : 1)
                    }
            }
            
            
            if 📱.🧩Temp.indices.contains(3) {
                Text(📱.🧩Temp[3].description)
            } else {
                if 📱.🚩2DecimalPlaceOption {
                    Text("0").opacity(0)
                        .overlay {
                            Text("_")
                                .opacity(📱.🧩Temp.count < 3 ? 0 : 1)
                        }
                } else {
                    EmptyView()
                }
            }
            
            
            Text(📱.📏UnitOption.rawValue)
                .font(.system(size: 36, weight: .medium))
                .minimumScaleFactor(0.1)
                .scaledToFit()
        }
        .font(.system(size: 64, weight: .bold))
        .monospacedDigit()
    }
}
