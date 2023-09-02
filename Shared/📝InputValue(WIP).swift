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
            if let ①st, let ②nd, let ③rd {
                if let ④th {
                    if let ⓥalue = Double("\(①st)\(②nd).\(③rd)\(④th)") {
                        ⓥalue
                    } else {
                        throw Self.ResultError.incorrect
                    }
                } else {
                    if let ⓥalue = Double("\(①st)\(②nd).\(③rd)") {
                        ⓥalue
                    } else {
                        throw Self.ResultError.incorrect
                    }
                }
            } else {
                throw Self.ResultError.lack
            }
        }
    }
    enum ResultError: Error {
        case lack, incorrect
    }
    var decimalSeparator: String {
        NumberFormatter().decimalSeparator
    }
    func description(_ ⓤnit: 📏DegreeUnit, _ ⓢecondDecimalPlace: Bool) -> String {
        var ⓥalue: String
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
    func satisfyAutoComplete() -> Bool {
        if self.satisfyResult() {
            self.④th != nil
        } else {
            false
        }
    }
    func preAutoComplete(_ ⓢecondDecimalPlace: Bool) -> Bool {
        if ⓢecondDecimalPlace {
            self.③rd != nil
            && self.④th == nil
        } else {
            self.②nd != nil
            && self.③rd == nil
        }
    }
    init(_ ⓤnit: 📏DegreeUnit) {
        switch ⓤnit {
            case .℃: self.①st = 3
            case .℉: self.①st = 9
        }
    }
}
