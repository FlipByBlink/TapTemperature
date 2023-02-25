import SwiftUI

struct 🪧ValueLabel: View {
    @EnvironmentObject var 📱: 📱AppModel
    private var ⓕirst: String {
        switch 📱.📏unitOption {
            case .℃:
                switch 📱.🧩components.count {
                    case 0: return "_"
                    case 1, 2, 3, 4: return 📱.🧩components[0].description
                    default: return "🐛"
                }
            case .℉:
                switch 📱.🧩components.count {
                    case 0: return " _"
                    case 1, 2, 3, 4:
                        switch 📱.🧩components.first {
                            case 9: return " 9"
                            case 10: return "10"
                            default: return "🐛"
                        }
                    default: return "🐛"
                }
        }
    }
    private var ⓢecond: String {
        switch 📱.🧩components.count {
            case 0: return " "
            case 1: return "_"
            case 2, 3, 4: return 📱.🧩components[1].description
            default: return "🐛"
        }
    }
    private var ⓣhird: String {
        switch 📱.🧩components.count {
            case 0, 1: return " "
            case 2: return "_"
            case 3, 4: return 📱.🧩components[2].description
            default: return "🐛"
        }
    }
    private var ⓕourth: String {
        if 📱.🚩secondDecimalPlaceOption {
            switch 📱.🧩components.count {
                case 0, 1, 2: return " "
                case 3: return "_"
                case 4: return 📱.🧩components[3].description
                default: return "🐛"
            }
        } else {
            return ""
        }
    }
    var body: some View {
        HStack(alignment: .firstTextBaseline, spacing: 3) {
            Text(self.ⓕirst + self.ⓢecond)
                .font(.system(size: self.ⓕontSize, weight: .bold, design: .monospaced))
                .kerning(3)
            Text(".")
            Text(self.ⓣhird + self.ⓕourth)
                .font(.system(size: self.ⓕontSize, weight: .bold, design: .monospaced))
                .kerning(3)
            Text(📱.📏unitOption.rawValue)
                .font(.system(size: self.ⓕontSize * 0.6, weight: .bold))
        }
        .font(.system(size: self.ⓕontSize, weight: .bold))
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
