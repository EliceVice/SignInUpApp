//
//  WelcomeVC.swift
//  SignInUpApp
//
//  Created by Andrei Isayenka on 28/08/2023.
//

import UIKit

class WelcomeVC: BaseViewController {

    @IBOutlet weak var welcomeLabel: UILabel!
    @IBOutlet weak var signInButton: UIButton!
    
    var userModel: UserModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.setNavigationBarHidden(true, animated: false)

        addGradientToBackground(colors: [.systemBlue.withAlphaComponent(0.4),
                                         .systemCyan.withAlphaComponent(0.5)])
        setupUI()
    }
    
    @IBAction func signInButtonTapped() {
        
        guard let userModel else { return }

        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(userModel) {
            UserDefaults.standard.set(encoded, forKey: "user-model-key")
        }
        
        navigationController?.popToRootViewController(animated: true)
    }
    
    private func setupUI() {
        welcomeLabel.text = "Hello \(userModel?.name ?? "")!"
        signInButton.layer.cornerRadius = signInButton.frame.height / 5
    }
    
}
