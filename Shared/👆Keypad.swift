import SwiftUI

struct 👆Keypad: View {
    @EnvironmentObject var model: 📱AppModel
    var body: some View {
        VStack(spacing: 0) {
            ForEach(0 ..< 4) { ⓡow in
                HStack(spacing: 0) {
                    ForEach(0 ..< 3) { ⓒolumn in
                        let ⓘndex: Int = ⓡow * 3 + ⓒolumn + 1
                        switch ⓘndex {
                            case 1 ..< 10:
                                Button {
                                    self.model.🧩appendComponent(ⓘndex)
                                } label: {
                                    ZStack {
                                        Color.clear
                                        Text(ⓘndex.description)
                                    }
                                }
                                .tint(.primary)
                                .disabled(self.ⓓisable(ⓘndex))
                            case 10:
                                Button {
                                    Task { await self.model.👆register() }
                                } label: {
                                    ZStack {
                                        Color.clear
                                        Image(systemName: self.ⓡegisterButtonImage)
                                            .symbolVariant(self.model.🧩components.count > 2 ? .fill : .none)
                                            .scaleEffect(self.model.🧩components.count > 2 ? 1.15 : 1)
                                            .font(.system(size: self.ⓕontSize))
                                    }
                                }
                                .tint(.pink)
                                .accessibilityLabel("DONE")
                                .disabled(self.model.🧩components.count < 3)
                            case 11:
                                Button {
                                    self.model.🧩appendComponent(self.ⓩeroOrTen)
                                } label: {
                                    ZStack {
                                        Color.clear
                                        Text(self.ⓩeroOrTen.description)
                                    }
                                }
                                .tint(.primary)
                                .disabled(self.ⓓisable(ⓘndex))
                            case 12:
                                Button {
                                    self.model.🧩components.removeLast()
                                    💥Feedback.light()
                                } label: {
                                    ZStack {
                                        Color.clear
                                        Image(systemName: "delete.left")
                                            .scaleEffect(0.7)
                                    }
                                }
                                .tint(.primary)
                                .accessibilityLabel("Delete")
                                .disabled(self.model.🧩components.isEmpty)
                            default:
                                Text(verbatim: "🐛")
                        }
                    }
                }
            }
        }
        .font(.system(size: self.ⓕontSize, weight: .medium, design: .rounded))
        .minimumScaleFactor(0.66)
    }
}

private extension 👆Keypad {
    private func ⓓisable(_ ⓘndex: Int) -> Bool {
        if self.model.🧩components.count == 3 && (self.model.🚩secondDecimalPlaceOption == false) {
            return true
        }
        if self.model.🧩components.count == 4 {
            return true
        }
        switch self.model.📏unitOption {
            case .℃:
                if self.model.🧩components.isEmpty {
                    if ⓘndex != 3 && ⓘndex != 4 {
                        return true
                    }
                }
                if self.model.🧩components.count == 1 {
                    if self.model.🧩components.first == 3 {
                        if ⓘndex < 4 || ⓘndex == 11 {
                            return true
                        }
                    } else if self.model.🧩components.first == 4 {
                        if ⓘndex != 1 && ⓘndex != 11 {
                            return true
                        }
                    }
                }
                return false
            case .℉:
                if self.model.🧩components.isEmpty {
                    if !(ⓘndex == 9 || ⓘndex == 11) {
                        return true
                    }
                }
                if self.model.🧩components.count == 1 {
                    if self.model.🧩components.first == 10 {
                        if 5 < ⓘndex && ⓘndex < 10 {
                            return true
                        }
                    } else if self.model.🧩components.first == 9 {
                        if ⓘndex < 4 || ⓘndex == 11 {
                            return true
                        }
                    }
                }
                return false
        }
    }
    private var ⓡegisterButtonImage: String {
        if self.model.🚩autoCompleteOption == false {
            "checkmark.circle"
        } else {
            if self.model.🚩secondDecimalPlaceOption {
                switch self.model.🧩components.count {
                    case 0: "4.circle"
                    case 1: "3.circle"
                    case 2: "2.circle"
                    case 3: "1.circle"
                    default: "checkmark.circle"
                }
            } else {
                switch self.model.🧩components.count {
                    case 0: "3.circle"
                    case 1: "2.circle"
                    case 2: "1.circle"
                    default: "checkmark.circle"
                }
            }
        }
    }
    private var ⓩeroOrTen: Int {
        if self.model.📏unitOption == .℉, self.model.🧩components.isEmpty {
            10
        } else {
            0
        }
    }
    private var ⓕontSize: CGFloat {
#if os(iOS)
        48
#elseif os(watchOS)
        30
#endif
    }
}
