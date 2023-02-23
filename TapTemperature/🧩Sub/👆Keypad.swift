import SwiftUI

struct 👆Keypad: View {
    @EnvironmentObject var 📱: 📱AppModel
    var body: some View {
        let ꠲ = Array(repeating: GridItem(.flexible()), count: 3)
        LazyVGrid(columns: ꠲, spacing: 32) {
            ForEach(1 ..< 13) { 🔢 in
                let ⓓisable: Bool = {
                    if 📱.🧩components.count == 3 && (📱.🚩2DecimalPlaceOption == false) {
                        return true
                    }
                    if 📱.🧩components.count == 4 {
                        return true
                    }
                    switch 📱.📏unitOption {
                        case .℃:
                            if 📱.🧩components.isEmpty {
                                if 🔢 != 3 && 🔢 != 4 {
                                    return true
                                }
                            }
                            if 📱.🧩components.count == 1 {
                                if 📱.🧩components.first == 3 {
                                    if 🔢 < 4 || 🔢 == 11 {
                                        return true
                                    }
                                } else if 📱.🧩components.first == 4 {
                                    if 🔢 != 1 && 🔢 != 11 {
                                        return true
                                    }
                                }
                            }
                            return false
                        case .℉:
                            if 📱.🧩components.isEmpty {
                                if !(🔢 == 9 || 🔢 == 11) {
                                    return true
                                }
                            }
                            if 📱.🧩components.count == 1 {
                                if 📱.🧩components.first == 10 {
                                    if 5 < 🔢 && 🔢 < 10 {
                                        return true
                                    }
                                } else if 📱.🧩components.first == 9 {
                                    if 🔢 < 4 || 🔢 == 11 {
                                        return true
                                    }
                                }
                            }
                            return false
                    }
                }()
                switch 🔢 {
                    case 1 ..< 10:
                        Button {
                            📱.🧩appendComponent(🔢)
                        } label: {
                            Text(🔢.description)
                        }
                        .tint(.primary)
                        .disabled(ⓓisable)
                    case 10:
                        Button {
                            Task {
                                await 📱.👆register()
                            }
                        } label: {
                            let 🔘: String = {
                                if 📱.🚩autoCompleteOption == false {
                                    return "checkmark.circle"
                                }
                                if 📱.🚩2DecimalPlaceOption {
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
                            }()
                            Image(systemName: 🔘)
                                .symbolVariant(📱.🧩components.count > 2 ? .fill : .none)
                                .scaleEffect(📱.🧩components.count > 2 ? 1.15 : 1)
                                .font(.system(size: 48))
                        }
                        .tint(.pink)
                        .accessibilityLabel("DONE")
                        .disabled(📱.🧩components.count < 3)
                    case 11:
                        let ０or１０: Int = {
                            if 📱.📏unitOption == .℉ && 📱.🧩components.isEmpty {
                                return 10
                            } else {
                                return 0
                            }
                        }()
                        Button {
                            📱.🧩appendComponent(０or１０)
                        } label: {
                            Text(０or１０.description)
                        }
                        .tint(.primary)
                        .disabled(ⓓisable)
                    case 12:
                        Button {
                            📱.🧩components.removeLast()
                            UISelectionFeedbackGenerator().selectionChanged()
                        } label: {
                            Text("⌫")
                                .fontWeight(.regular)
                                .scaleEffect(0.8)
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
}
