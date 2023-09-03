//
//  TabBarController.swift
//  SignInUpApp
//
//  Created by Andrei Isayenka on 31/08/2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}
