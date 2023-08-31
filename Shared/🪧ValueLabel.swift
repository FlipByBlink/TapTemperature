import SwiftUI

struct 🪧ValueLabel: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 3) {
            Text(self.🎰first + self.🎰second)
                .font(.system(size: self.ⓕontSize, weight: .bold, design: .monospaced))
                .kerning(3)
            Text(".")
                .font(.system(size: self.ⓕontSize, weight: .bold))
            Text(self.🎰third + self.🎰fourth)
                .font(.system(size: self.ⓕontSize, weight: .bold, design: .monospaced))
                .kerning(3)
            Text(self.model.📏unitOption.rawValue)
                .font(.system(size: self.ⓕontSize * 0.6, weight: .bold))
        }
    }
    private var 🎰first: String {
        switch self.model.📏unitOption {
            case .℃:
                switch self.model.🧩components.count {
                    case 0: "_"
                    case 1, 2, 3, 4: self.model.🧩components[0].description
                    default: "🐛"
                }
            case .℉:
                switch self.model.🧩components.count {
                    case 0: " _"
                    case 1, 2, 3, 4:
                        switch self.model.🧩components.first {
                            case 9: " 9"
                            case 10: "10"
                            default: "🐛"
                        }
                    default: "🐛"
                }
        }
    }
    private var 🎰second: String {
        switch self.model.🧩components.count {
            case 0: " "
            case 1: "_"
            case 2, 3, 4: self.model.🧩components[1].description
            default: "🐛"
        }
    }
    private var 🎰third: String {
        switch self.model.🧩components.count {
            case 0, 1: " "
            case 2: "_"
            case 3, 4: self.model.🧩components[2].description
            default: "🐛"
        }
    }
    private var 🎰fourth: String {
        if self.model.🚩secondDecimalPlaceOption {
            switch self.model.🧩components.count {
                case 0, 1, 2: " "
                case 3: "_"
                case 4: self.model.🧩components[3].description
                default: "🐛"
            }
        } else {
            ""
        }
    }
    private var ⓕontSize: CGFloat {
#if os(iOS)
        64
#elseif os(watchOS)
        22
#endif
    }
}
