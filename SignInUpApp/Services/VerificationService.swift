//
//  File.swift
//  SignInUpApp
//
//  Created by Andrei Isayenka on 26/08/2023.
//

import Foundation

enum PasswordStrength: Int {
    case invalid = 0
    case weak    = 1
    case medium  = 2
    case strong  = 3
}

class VerificationService {

    static private let weakRegex   = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)[A-Za-z\\d]{8,}$"
    static private let mediumRegex = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*#?&])[A-Za-z\\d$@$!%*#?&]{8,}$"
    static private let strongRegex = "^(?=.*[a-z])(?=.*[A-Z].*[A-Z])(?=.*\\d)(?=.*[$@$!%*#?&].*[$@$!%*?&#])[A-Za-z\\d$@$!%*#?&]{8,}$"

    static func isValidPassword(pass: String) -> PasswordStrength {
        if NSPredicate(format: "SELF MATCHES %@", strongRegex).evaluate(with: pass) {
            return .strong
        } else if NSPredicate(format: "SELF MATCHES %@", mediumRegex).evaluate(with: pass) {
            return .medium
        } else if NSPredicate(format: "SELF MATCHES %@", weakRegex).evaluate(with: pass) {
            return .weak
        } else {
            return .invalid
        }
    }

    static func isValidEmail(email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailPred.evaluate(with: email)
    }

    static func isPasswordConfirmed(pass1: String, pass2: String) -> Bool {
        pass1 == pass2
    }
}
