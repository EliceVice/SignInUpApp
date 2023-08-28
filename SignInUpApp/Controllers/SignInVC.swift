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
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        UserDefaults.standard.removeObject(forKey: "user-model-key")
        
        setupUI()
        
        addGradientToBackground(colors: [.systemBlue.withAlphaComponent(0.4),
                                         .systemCyan.withAlphaComponent(0.5)])
        hideKeyboardWhenTappedAround()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let savedUserModel = UserDefaults.standard.object(forKey: "user-model-key") as? Data {
            let decoder = JSONDecoder()
            if let loadedPerson = try? decoder.decode(UserModel.self, from: savedUserModel) {
                emailTextField.text = loadedPerson.email
                passwordTextField.text = loadedPerson.password
            }
        }
    }
    
    private func setupUI() {
        // Create a new gradient layer
        
        signInButton.isEnabled = false
        errorEmailLabel.isHidden = true
        errorPasswordLabel.isHidden = true
        
        descriptionLabel.textColor = UIColor.systemGray
        
        emailTextField.backgroundColor = UIColor.clear
        emailTextField.layer.borderWidth = 0.3
        emailTextField.layer.borderColor = UIColor.systemGray.cgColor
        emailTextField.layer.cornerRadius = 10
        
        passwordTextField.backgroundColor = UIColor.clear
        passwordTextField.layer.borderWidth = 0.3
        passwordTextField.layer.borderColor = UIColor.systemGray.cgColor
        passwordTextField.layer.cornerRadius = 10
    }
    
}
