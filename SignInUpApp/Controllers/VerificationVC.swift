//
//  VerificationVC.swift
//  SignInUpApp
//
//  Created by Andrei Isayenka on 28/08/2023.
//

import UIKit

class VerificationVC: BaseViewController {

    @IBOutlet weak var verifyCodeLabel: UILabel!
    @IBOutlet weak var verifyCodeTF: UITextField!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var verifyButton: UIButton!
    
    @IBOutlet weak var centerYConstraint: NSLayoutConstraint!
    private var randomCode = Int.random(in: 100000...999999)
    private var sleepTime = 3
    var userModel: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
        addGradientToBackground(colors: [.systemBlue.withAlphaComponent(0.4),
                                         .systemCyan.withAlphaComponent(0.5)])
        startKeyboardObserver()
        hideKeyboardWhenTappedAround()
    }
    
    @IBAction func verifyCodeTFDidEnd(_ sender: UITextField) {
        if let code = sender.text, code == randomCode.description {
            errorLabel.isHidden = true
        } else {
            errorLabel.isHidden = false
        }
        
        if let text = sender.text, text.isEmpty { errorLabel.isHidden = true }
        
    }
    
    @IBAction func verifyButtonTapped(_ sender: UIButton) {
        if let code = verifyCodeTF.text,
           code == randomCode.description
        {
            performSegue(withIdentifier: "goToWelcomeScreen", sender: nil)
        } else {
            
            // MARK: Additional functionality: if email code is incorrect, delay for 'sleepTime' seconds
            
//            errorLabel.isHidden = false
//            sender.isUserInteractionEnabled = false
//            errorLabel.text = "Incorrect code. Please wait for \(sleepTime) seconds."
//
//            let dispatchAfter = DispatchTimeInterval.seconds(sleepTime)
//            let deadline = DispatchTime.now() + dispatchAfter
//            DispatchQueue.main.asyncAfter(deadline: deadline) {
//                sender.isUserInteractionEnabled = true
//                self.errorLabel.isHidden = true
//                self.sleepTime *= 2
//            }
        }
    }
    
    private func setupUI() {
        verifyCodeTF.backgroundColor = .clear
        verifyCodeLabel.text = "We've send verification code (\(randomCode)) on your email \(userModel?.email ?? "")"
        verifyCodeLabel.textColor = .systemGray
        verifyButton.layer.cornerRadius = verifyButton.frame.height / 5
        errorLabel.isHidden = true
        verifyCodeTF.clearButtonMode = .whileEditing
    }
    
}


// MARK: - Navigation

extension VerificationVC {
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let welcomeVC = segue.destination as? WelcomeVC {
            welcomeVC.userModel = userModel
        }
    }
}


// MARK: - Keyboard observer

extension VerificationVC {
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc private func keyboardWillShow(notification: Notification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        guard centerYConstraint.constant == 60 else { return }
        centerYConstraint.constant -= keyboardSize.height / 3
    }
    
    @objc private func keyboardWillHide(notification: Notification) {
        centerYConstraint.constant = 60
        verifyCodeTFDidEnd(verifyCodeTF)
    }
}

