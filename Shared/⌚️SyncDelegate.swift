import SwiftUI
import WatchConnectivity

class 🅂yncDelegate: NSObject, ObservableObject {
    @AppStorage(🔑BasalBodyTemperature) var 🚩bbtOption: Bool = false
    @AppStorage(🔑SecondDecimalPlace) var 🚩secondDecimalPlaceOption: Bool = false
    @AppStorage(🔑AutoComplete) var 🚩autoCompleteOption: Bool = false
}

extension 🅂yncDelegate: WCSessionDelegate {
    //MARK: Required(watchOS, iOS)
    func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        print(#function)
    }
}

extension 🅂yncDelegate {
    func sync() {
        do {
            try WCSession.default.updateApplicationContext([🔑BasalBodyTemperature: self.🚩bbtOption,
                                                              🔑SecondDecimalPlace: self.🚩secondDecimalPlaceOption,
                                                                    🔑AutoComplete: self.🚩autoCompleteOption])
        } catch {
            print("🚨", error.localizedDescription)
        }
    }
}

#if os(iOS)
extension 🅂yncDelegate: UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
        return true
    }
}

extension 🅂yncDelegate {
    //MARK: WCSessionDelegate/Required
    func sessionDidBecomeInactive(_ session: WCSession) {
        print("\(#function): activationState = \(session.activationState.rawValue)")
    }
    
    //MARK: WCSessionDelegate/Required
    func sessionDidDeactivate(_ session: WCSession) {
        session.activate()
    }
}

#elseif os(watchOS)
extension 🅂yncDelegate: WKApplicationDelegate {
    func applicationDidBecomeActive() {
        if WCSession.isSupported() {
            WCSession.default.delegate = self
            WCSession.default.activate()
        }
    }
}

extension 🅂yncDelegate {
    //MARK: WCSessionDelegate/Optional
    func session(_ session: WCSession, didReceiveApplicationContext applicationContext: [String : Any]) {
        print("🖨️", #function, applicationContext.description)
        Task { @MainActor in
            if let ⓥalue = applicationContext[🔑BasalBodyTemperature] as? Bool {
                self.🚩bbtOption = ⓥalue
            }
            if let ⓥalue = applicationContext[🔑SecondDecimalPlace] as? Bool {
                self.🚩secondDecimalPlaceOption = ⓥalue
            }
            if let ⓥalue = applicationContext[🔑AutoComplete] as? Bool {
                self.🚩autoCompleteOption = ⓥalue
            }
        }
    }
}
#endif
