//
//  ProfileVC.swift
//  SignInUpApp
//
//  Created by Andrei Isayenka on 31/08/2023.
//

import UIKit

class ProfileVC: BaseViewController {

    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    
    private let userModel = UserDefaultsService.getUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addGradientToBackground(colors: [.systemIndigo.withAlphaComponent(0.4),
                                         .systemBlue.withAlphaComponent(0.4)])
    }
    
    @IBAction func logoutButtonTapped() {
        navigationController?.popToRootViewController(animated: true)
        UserDefaultsService.setLoggedInStatus(status: false)
    }
    
    @IBAction func deleteUserButtonTapped() {
        UserDefaultsService.deleteUser()
        navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func nameTFEditingChanged(_ sender: UITextField) {
        guard let name = sender.text, !name.isEmpty else { return }
        UserDefaultsService.updateUserName(name: name)
    }
    
    @IBAction func emailTFEditingChanged(_ sender: UITextField) {
        guard let email = sender.text, !email.isEmpty,
              VerificationService.isValidEmail(email: email)
        else { return }
        
        UserDefaultsService.updateUserEmail(email: email)
    }
    
    @IBAction func passwordTFEditingChanged(_ sender: UITextField) {
        guard let password = sender.text, !password.isEmpty,
              VerificationService.isValidPassword(pass: password) != .invalid
        else { return }
        
        UserDefaultsService.updateUserPassword(password: password)
    }
    
    private func setupUI() {
        nameTF.borderStyle = .none
        emailTF.borderStyle = .none
        passwordTF.borderStyle = .none
        
        nameTF.text = userModel?.name
        emailTF.text = userModel?.email
        passwordTF.text = userModel?.password
    }
    
}

