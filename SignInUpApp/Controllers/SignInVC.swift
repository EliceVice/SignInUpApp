//
//  SignInVC.swift
//  SignInUpApp
//
//  Created by Andrei Isayenka on 23/08/2023.
//

import UIKit

class SignInVC: BaseViewController {
    
    @IBOutlet weak var doorImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()        
        addGradientToBackground(colors: [.systemBlue.withAlphaComponent(0.4),
                                         .systemCyan.withAlphaComponent(0.5)])
        hideKeyboardWhenTappedAround()
        
        if UserDefaultsService.getLoggedInStatus() {
            goToTabBarController()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        emailTextField.text = ""
        passwordTextField.text = ""
        errorLabel.isHidden = true
    }
    
    
    @IBAction func signInButtonTapped(_ sender: UIButton) {
        
        if let email = emailTextField.text, let password = passwordTextField.text,
           email.isEmpty, password.isEmpty
        {
            errorLabel.isHidden = true
            return
        }
        
        guard let email = emailTextField.text,
           let password = passwordTextField.text,
           let userModel = UserDefaultsService.getUser(),
           email == userModel.email,
           password == userModel.password
        else {
            errorLabel.isHidden = false
            return
        }
        errorLabel.isHidden = true
        
        UserDefaultsService.setLoggedInStatus(status: true)
        goToTabBarController()
    }
    
    @IBAction func emailTFEditingChanged(_ sender: UITextField) {
        if let email = sender.text, let password = passwordTextField.text,
           email.isEmpty, password.isEmpty { errorLabel.isHidden = true }
    }
    
    @IBAction func passwordTFEditingChanged(_ sender: UITextField) {
        if let email = emailTextField.text, let password = sender.text,
           email.isEmpty, password.isEmpty { errorLabel.isHidden = true }
    }
    
    private func goToTabBarController() {
        let mainStoryboard = UIStoryboard(name: "MainStoryboard", bundle: nil)
        if let tabBarController = mainStoryboard.instantiateViewController(withIdentifier: "TabBarController") as? TabBarController {
            navigationController?.pushViewController(tabBarController, animated: true)
        }
    }
    
    private func setupUI() {
        descriptionLabel.textColor = UIColor.systemGray
        
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.layer.borderWidth = 0.3
        emailTextField.layer.borderColor = UIColor.systemGray.cgColor
        emailTextField.layer.cornerRadius = 10
        emailTextField.autocorrectionType = .no
        
        passwordTextField.backgroundColor = UIColor.clear
        passwordTextField.layer.borderWidth = 0.3
        passwordTextField.layer.borderColor = UIColor.systemGray.cgColor
        passwordTextField.layer.cornerRadius = 10
        passwordTextField.autocorrectionType = .no
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .emailAddress
        emailTextField.textContentType = .oneTimeCode
    }
    
}
