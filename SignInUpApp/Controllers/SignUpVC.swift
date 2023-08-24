//
//  SignUpVC.swift
//  SignInUpApp
//
//  Created by Andrei Isayenka on 24/08/2023.
//

import UIKit

class SignUpVC: UIViewController {

    
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
        
    }

}
