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
                                    self.model.append(ⓘndex)
                                } label: {
                                    ZStack {
                                        Color.clear
                                        Text(ⓘndex.description)
                                    }
                                }
                                .tint(.primary)
                                .disabled(self.disable(ⓘndex))
                            case 10:
                                Button {
                                    Task { await self.model.register() }
                                } label: {
                                    ZStack {
                                        Color.clear
                                        Image(systemName: self.registerButtonImage)
                                            .symbolVariant(self.model.components.count > 2 ? .fill : .none)
                                            .scaleEffect(self.model.components.count > 2 ? 1.15 : 1)
                                            .font(.system(size: self.fontSize))
                                    }
                                }
                                .tint(.pink)
                                .accessibilityLabel("DONE")
                                .disabled(self.model.components.count < 3)
                            case 11:
                                Button {
                                    self.model.append(self.zeroOrTen)
                                } label: {
                                    ZStack {
                                        Color.clear
                                        Text(self.zeroOrTen.description)
                                    }
                                }
                                .tint(.primary)
                                .disabled(self.disable(ⓘndex))
                            case 12:
                                Button {
                                    self.model.components.removeLast()
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
                                .disabled(self.model.components.isEmpty)
                            default:
                                Text(verbatim: "🐛")
                        }
                    }
                }
            }
        }
        .font(.system(size: self.fontSize, weight: .medium, design: .rounded))
        .minimumScaleFactor(0.66)
    }
}

private extension 👆Keypad {
    private func disable(_ ⓘndex: Int) -> Bool { //TODO: リファクタリング
        if self.model.components.count == 3, !self.model.ableSecondDecimalPlace {
            true
        } else if self.model.components.count == 4 {
            true
        } else {
            switch self.model.degreeUnit {
                case .℃:
                    if self.model.components.isEmpty {
                        ⓘndex != 3 && ⓘndex != 4
                    } else {
                        if self.model.components.count == 1 {
                            if self.model.components.first == 3 {
                                ⓘndex < 4 || ⓘndex == 11
                            } else if self.model.components.first == 4 {
                                ⓘndex != 1 && ⓘndex != 11
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    }
                case .℉:
                    if self.model.components.isEmpty {
                        !(ⓘndex == 9 || ⓘndex == 11)
                    } else {
                        if self.model.components.count == 1 {
                            if self.model.components.first == 10 {
                                5 < ⓘndex && ⓘndex < 10
                            } else if self.model.components.first == 9 {
                                ⓘndex < 4 || ⓘndex == 11
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    }
            }
        }
    }
    private var registerButtonImage: String {
        if self.model.ableAutoComplete == false {
            "checkmark.circle"
        } else {
            if self.model.ableSecondDecimalPlace {
                switch self.model.components.count {
                    case 0: "4.circle"
                    case 1: "3.circle"
                    case 2: "2.circle"
                    case 3: "1.circle"
                    default: "checkmark.circle"
                }
            } else {
                switch self.model.components.count {
                    case 0: "3.circle"
                    case 1: "2.circle"
                    case 2: "1.circle"
                    default: "checkmark.circle"
                }
            }
        }
    }
    private var zeroOrTen: Int {
        if self.model.degreeUnit == .℉, self.model.components.isEmpty {
            10
        } else {
            0
        }
    }
    private var fontSize: CGFloat {
#if os(iOS)
        48
#elseif os(watchOS)
        30
#endif
    }
}
