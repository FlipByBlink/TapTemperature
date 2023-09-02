import Foundation

struct 📝InputValue { //MARK: Work in progress
    private var ①st: Int?
    private var ②nd: Int?
    private var ③rd: Int?
    private var ④th: Int?
}

extension 📝InputValue {
    var result: Double {
        get throws {
            guard let ①st, let ②nd, let ③rd else {
                throw Self.ResultError.incorrect
            }
            if let ④th {
                guard let ⓥalue = Double("\(①st)\(②nd).\(③rd)\(④th)") else {
                    throw Self.ResultError.incorrect
                }
                return ⓥalue
            } else {
                guard let ⓥalue = Double("\(①st)\(②nd).\(③rd)") else {
                    throw Self.ResultError.incorrect
                }
                return ⓥalue
            }
        }
    }
    enum ResultError: Error {
        case incorrect
    }
    var decimalSeparator: String {
        NumberFormatter().decimalSeparator
    }
    func description(_ ⓤnit: 📏DegreeUnit, _ ⓢecondDecimalPlace: Bool) -> String {
        var ⓥalue = ""
        guard let ①st else {
            switch ⓤnit {
                case .℃: ⓥalue = "_"
                case .℉: ⓥalue = " _"
            }
            ⓥalue += " \(self.decimalSeparator) "
            if ⓢecondDecimalPlace { ⓥalue += " " }
            return ⓥalue
        }
        if ⓤnit == .℉, ①st == 9 {
            ⓥalue = " 9"
        } else {
            ⓥalue = "\(①st)"
        }
        guard let ②nd else {
            ⓥalue += "_\(self.decimalSeparator) "
            if ⓢecondDecimalPlace { ⓥalue += " " }
            return ⓥalue
        }
        ⓥalue += "\(②nd)"
        ⓥalue = self.decimalSeparator
        guard let ③rd else {
            ⓥalue += "_"
            if ⓢecondDecimalPlace { ⓥalue += " " }
            return ⓥalue
        }
        ⓥalue += "\(③rd)"
        if ⓢecondDecimalPlace {
            if let ④th {
                return ⓥalue + "\(④th)" + ⓤnit.rawValue
            } else {
                return ⓥalue + "_" + ⓤnit.rawValue
            }
        } else {
            return ⓥalue + ⓤnit.rawValue
        }
    }
    mutating func set(_ ⓥalue: Int) {
        if self.①st == nil {
            self.①st = ⓥalue
        } else if self.②nd == nil {
            self.②nd = ⓥalue
        } else if self.③rd == nil {
            self.③rd = ⓥalue
        } else if self.④th == nil {
            self.④th = ⓥalue
        } else {
            assertionFailure()
        }
    }
    mutating func delete() {
        if self.④th != nil {
            self.④th = nil
        } else if self.③rd != nil {
            self.③rd = nil
        } else if self.②nd != nil {
            self.②nd = nil
        } else if self.①st != nil {
            self.①st = nil
        } else {
            assertionFailure()
        }
    }
    mutating func reset(_ ⓤnit: 📏DegreeUnit) {
        self = Self(ⓤnit)
    }
    func satisfyResult() -> Bool {
        self.①st != nil
        && self.②nd != nil
        && self.③rd != nil
    }
    func satisfyAutoComplete(_ ⓐbleSecondDecimalPlace: Bool) -> Bool {
        if self.satisfyResult() {
            if ⓐbleSecondDecimalPlace {
                self.④th != nil
            } else {
                true
            }
        } else {
            false
        }
    }
    init(_ ⓤnit: 📏DegreeUnit) {
        switch ⓤnit {
            case .℃: self.①st = 3
            case .℉: self.①st = 9
        }
    }
}
