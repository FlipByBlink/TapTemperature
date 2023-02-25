import SwiftUI

struct 💥Feedback {
#if os(iOS)
    static func light() {
        UISelectionFeedbackGenerator().selectionChanged()
    }
    static func success() {
        UINotificationFeedbackGenerator().notificationOccurred(.success)
    }
    static func error() {
        UINotificationFeedbackGenerator().notificationOccurred(.error)
    }
#endif
#if os(watchOS)
    static func light() {
        
    }
    static func success() {
        
    }
    static func error() {
        
    }
#endif
}
