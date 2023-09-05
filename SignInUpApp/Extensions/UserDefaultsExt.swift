//
//  UserDefaultsExt.swift
//  SignInUpApp
//
//  Created by Andrei Isayenka on 31/08/2023.
//

import Foundation

extension UserDefaults {
    
    enum UserKeys: String, CaseIterable {
        case email
        case password
        case name
        case isLoggedIn
    }
    
    func resetUserData() {
        UserKeys.allCases.forEach { removeObject(forKey: $0.rawValue) }
    }
}

