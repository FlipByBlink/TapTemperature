import SwiftUI

struct 👆Keypad: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        LazyVGrid(columns: Array(repeating: GridItem(.flexible()), count: 3),
                  spacing: 32) {
            ForEach(1 ..< 13) { ⓘndex in
                switch ⓘndex {
                    case 1 ..< 10:
                        Button {
                            📱.🧩appendComponent(ⓘndex)
                        } label: {
                            Text(ⓘndex.description)
                        }
                        .tint(.primary)
                        .disabled(self.ⓓisable(ⓘndex))
                    case 10:
                        Button {
                            Task { await 📱.👆register() }
                        } label: {
                            Image(systemName: self.ⓡegisterButtonImage)
                                .symbolVariant(📱.🧩components.count > 2 ? .fill : .none)
                                .scaleEffect(📱.🧩components.count > 2 ? 1.15 : 1)
                                .font(.system(size: 48))
                        }
                        .tint(.pink)
                        .accessibilityLabel("DONE")
                        .disabled(📱.🧩components.count < 3)
                    case 11:
                        Button {
                            📱.🧩appendComponent(self.ⓩeroOrTen)
                        } label: {
                            Text(self.ⓩeroOrTen.description)
                        }
                        .tint(.primary)
                        .disabled(self.ⓓisable(ⓘndex))
                    case 12:
                        Button {
                            📱.🧩components.removeLast()
                            UISelectionFeedbackGenerator().selectionChanged()
                        } label: {
                            Image(systemName: "delete.left")
                                .scaleEffect(0.7)
                        }
                        .tint(.primary)
                        .accessibilityLabel("Delete")
                        .disabled(📱.🧩components.isEmpty)
                    default:
                        Text("🐛")
                }
            }
            .font(.system(size: 48, weight: .medium, design: .rounded))
        }
        .padding()
        .padding(.vertical)
    }
    private func ⓓisable(_ ⓘndex: Int) -> Bool {
        if 📱.🧩components.count == 3 && (📱.🚩secondDecimalPlaceOption == false) {
            return true
        }
        if 📱.🧩components.count == 4 {
            return true
        }
        switch 📱.📏unitOption {
            case .℃:
                if 📱.🧩components.isEmpty {
                    if ⓘndex != 3 && ⓘndex != 4 {
                        return true
                    }
                }
                if 📱.🧩components.count == 1 {
                    if 📱.🧩components.first == 3 {
                        if ⓘndex < 4 || ⓘndex == 11 {
                            return true
                        }
                    } else if 📱.🧩components.first == 4 {
                        if ⓘndex != 1 && ⓘndex != 11 {
                            return true
                        }
                    }
                }
                return false
            case .℉:
                if 📱.🧩components.isEmpty {
                    if !(ⓘndex == 9 || ⓘndex == 11) {
                        return true
                    }
                }
                if 📱.🧩components.count == 1 {
                    if 📱.🧩components.first == 10 {
                        if 5 < ⓘndex && ⓘndex < 10 {
                            return true
                        }
                    } else if 📱.🧩components.first == 9 {
                        if ⓘndex < 4 || ⓘndex == 11 {
                            return true
                        }
                    }
                }
                return false
        }
    }
    private var ⓡegisterButtonImage: String {
        if 📱.🚩autoCompleteOption == false {
            return "checkmark.circle"
        }
        if 📱.🚩secondDecimalPlaceOption {
            switch 📱.🧩components.count {
                case 0: return "4.circle"
                case 1: return "3.circle"
                case 2: return "2.circle"
                case 3: return "1.circle"
                default: return "checkmark.circle"
            }
        } else {
            switch 📱.🧩components.count {
                case 0: return "3.circle"
                case 1: return "2.circle"
                case 2: return "1.circle"
                default: return "checkmark.circle"
            }
        }
    }
    private var ⓩeroOrTen: Int {
        if 📱.📏unitOption == .℉ && 📱.🧩components.isEmpty {
            return 10
        } else {
            return 0
        }
    }
}
