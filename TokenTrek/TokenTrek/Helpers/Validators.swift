//
//  Validators.swift
//  TokenTrek
//
//  Created by Artyom Tabachenko on 31.05.2023.
//

import Foundation

class Validators {
    static func isFilled(email: String?, password: String?) -> Bool {
        guard !(email ?? "").isEmpty,
              !(password ?? "").isEmpty else {
            return false
        }
        return true
    }
    
    static func validateEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
