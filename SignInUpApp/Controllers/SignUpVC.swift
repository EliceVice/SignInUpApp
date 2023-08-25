//
//  SignUpVC.swift
//  SignInUpApp
//
//  Created by Andrei Isayenka on 24/08/2023.
//

import UIKit

class SignUpVC: BaseViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var confirmTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    
    @IBOutlet var passIndicatorViews: [UIView]!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passIndicatorViews.forEach { $0.alpha = 0.3 }
        errorLabel.alpha = 0
        
        startKeyboardObserver()
        hideKeyboardWhenTappedAround()
    }
    
    private func startKeyboardObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
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
