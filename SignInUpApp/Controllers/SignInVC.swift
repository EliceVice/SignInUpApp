//
//  SignInVC.swift
//  SignInUpApp
//
//  Created by Andrei Isayenka on 23/08/2023.
//

import UIKit

class SignInVC: UIViewController {
    
    @IBOutlet weak var doorImageView: UIImageView!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signInButton: UIButton!
    @IBOutlet weak var signUpButton: UIButton!
    
    @IBOutlet weak var errorEmailLabel: UILabel!
    @IBOutlet weak var errorPasswordLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        signInButton.isEnabled = false
        errorEmailLabel.isHidden = true
        errorPasswordLabel.isHidden = true
    }
    

}
