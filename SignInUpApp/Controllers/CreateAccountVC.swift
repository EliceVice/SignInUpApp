//
//  SignUpVC.swift
//  SignInUpApp
//
//  Created by Andrei Isayenka on 24/08/2023.
//

import UIKit

class CreateAccountVC: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var contentView: UIView!
    
    @IBOutlet weak var emailTF: UITextField!
    @IBOutlet weak var passwordTF: UITextField!
    @IBOutlet weak var confirmPasswordTF: UITextField!
    @IBOutlet weak var nameTF: UITextField!
    
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet var passIndicatorViews: [UIView]!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    @IBOutlet weak var errorConfirmLabel: UILabel!
    
    private var isEmailValid         = false { didSet { updateNextButtonState() } }
    private var isConfirmationValid  = false { didSet { updateNextButtonState() } }
    private var passwordStrength     = PasswordStrength.invalid { didSet { updateNextButtonState() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        addGradientToBackground(colors: [.systemBlue.withAlphaComponent(0.4),
                                         .systemCyan.withAlphaComponent(0.5)])
        startKeyboardObserver()
        hideKeyboardWhenTappedAround()
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @IBAction func nextButtonTapped(_ sender: UIButton) {
        if let email = emailTF.text, let password = passwordTF.text {
            performSegue(withIdentifier: "goToWelcomeVC", sender: UserModel(email: email, password: password, name: nameTF.text))
        }
    }
    
    @IBAction func emailTFChanged(_ sender: UITextField) {
        if let email = sender.text, VerificationService.isValidEmail(email: email) {
            isEmailValid = true
        } else {
            isEmailValid = false
        }
        
        errorEmailLabel.isHidden = isEmailValid

        if let email = sender.text, email.isEmpty { errorEmailLabel.isHidden = true }
        
//        print(isEmailValid)
    }

    @IBAction func passwordTFChanged(_ sender: UITextField) {
        if let password = sender.text {
            passwordStrength = VerificationService.isValidPassword(pass: password)
        } else {
            passwordStrength = .invalid
        }
        errorPasswordLabel.isHidden = passwordStrength != .invalid
        setupIndicatorViewsByStrength()
        
        if let password = sender.text, password.isEmpty {
            errorPasswordLabel.isHidden = true
            isConfirmationValid = false
        }
        
        if let confirmPassword = confirmPasswordTF.text, !confirmPassword.isEmpty { confirmPasswordTF.text = "" }
        
//        print(passwordStrength, isConfirmationValid)
    }

    @IBAction func confirmPasswordTFChanged(_ sender: UITextField) {
        if let password = passwordTF.text, password.isEmpty { sender.text = ""; return }
        
        if let password = passwordTF.text, let confirmPassword = sender.text, !password.isEmpty, !confirmPassword.isEmpty {
            isConfirmationValid = VerificationService.isPasswordConfirmed(pass1: password, pass2: confirmPassword)
        } else {
            isConfirmationValid = false
        }
        errorConfirmLabel.isHidden = isConfirmationValid
        
        if let passConf = sender.text, passConf.isEmpty { errorConfirmLabel.isHidden = true }

//        print(isConfirmationValid)
    }
    
    private func updateNextButtonState() {
        if isEmailValid && isConfirmationValid && passwordStrength != .invalid {
            UIView.animate(withDuration: 0.3) {
                self.nextButton.alpha = 1
                self.nextButton.tintColor = self.nextButton.tintColor.withAlphaComponent(1)
                self.nextButton.isEnabled = true
            }
        } else {
            UIView.animate(withDuration: 0.3) {
                self.nextButton.alpha = 0.6
                self.nextButton.tintColor = self.nextButton.tintColor.withAlphaComponent(0.6)
            }
            self.nextButton.isEnabled = false
        }
    }

    private func setupIndicatorViewsByStrength() {
        passIndicatorViews.enumerated().forEach { index, view in
            UIView.animate(withDuration: 0.2) {
                view.alpha = self.passwordStrength.rawValue - 1 >= index ? 1 : 0.3
            }
        }
    }
    
    private func setupUI() {
        passIndicatorViews.forEach { $0.alpha = 0.3 }
        contentView.backgroundColor = UIColor.clear
        descriptionLabel.textColor = UIColor.systemGray

        nextButton.isEnabled = false
        nextButton.alpha = 0.6
        nextButton.tintColor = nextButton.tintColor.withAlphaComponent(0.6)
        nextButton.layer.cornerRadius = nextButton.frame.height / 5
        nextButton.backgroundColor = .systemBlue

        errorEmailLabel.isHidden = true
        errorConfirmLabel.isHidden = true
        errorPasswordLabel.isHidden = true

        emailTF.backgroundColor = UIColor.clear
        passwordTF.backgroundColor = UIColor.clear
        confirmPasswordTF.backgroundColor = UIColor.clear
        nameTF.backgroundColor = UIColor.clear

        emailTF.clearButtonMode = .whileEditing
        passwordTF.clearButtonMode = .whileEditing
        confirmPasswordTF.clearButtonMode = .whileEditing
        nameTF.clearButtonMode = .whileEditing
        
        passwordTF.isSecureTextEntry = true
        confirmPasswordTF.isSecureTextEntry = true
//        passwordTextField.textContentType = .oneTimeCode
//        confirmTextField.textContentType = .oneTimeCode
        passwordTF.textContentType = .newPassword
        confirmPasswordTF.textContentType = .newPassword
    }
   
}


// MARK: - Navigation

extension CreateAccountVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let verificationVC = segue.destination as? VerificationVC, let user = sender as? UserModel {
            verificationVC.userModel = user
        }
    }
}


// MARK: - Keyboard observer

extension CreateAccountVC {
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc private func keyboardWillHide() {
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
    }
}

