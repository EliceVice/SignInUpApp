//
//  UserModel.swift
//  SignInUpApp
//
//  Created by Andrei Isayenka on 28/08/2023.
//

import Foundation

struct UserModel: Codable {
    let email: String
    let password: String
    let name: String?
}
