//
//  UserDefaultsService.swift
//  SignInUpApp
//
//  Created by Andrei Isayenka on 31/08/2023.
//

import Foundation

class UserDefaultsService {
    
    static func saveUser(userModel: UserModel) {
        UserDefaults.standard.set(userModel.email, forKey: UserDefaults.UserKeys.email.rawValue)
        UserDefaults.standard.set(userModel.password, forKey: UserDefaults.UserKeys.password.rawValue)
        UserDefaults.standard.set(userModel.name, forKey: UserDefaults.UserKeys.name.rawValue)
    }
    
    static func getUser() -> UserModel? {
        guard let email = UserDefaults.standard.string(forKey: UserDefaults.UserKeys.email.rawValue),
              let password = UserDefaults.standard.string(forKey: UserDefaults.UserKeys.password.rawValue)
        else { return nil }
        
        let name = UserDefaults.standard.string(forKey: UserDefaults.UserKeys.name.rawValue)

        return UserModel(email: email, password: password, name: name)
    }
    
    static func updateUserName(name: String) {
        UserDefaults.standard.set(name, forKey: UserDefaults.UserKeys.name.rawValue)
    }
    
    static func updateUserEmail(email: String) {
        UserDefaults.standard.set(email, forKey: UserDefaults.UserKeys.email.rawValue)
    }
    
    static func updateUserPassword(password: String) {
        UserDefaults.standard.set(password, forKey: UserDefaults.UserKeys.password.rawValue)
    }

    static func deleteUser() {
        UserDefaults.standard.resetUserData()
    }
    
    
    static func setLoggedInStatus(status: Bool) {
        UserDefaults.standard.set(status, forKey: UserDefaults.UserKeys.isLoggedIn.rawValue)
    }
    
    static func getLoggedInStatus() -> Bool {
        UserDefaults.standard.bool(forKey: UserDefaults.UserKeys.isLoggedIn.rawValue)
    }
}
