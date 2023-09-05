//
//  HomeVC.swift
//  SignInUpApp
//
//  Created by Andrei Isayenka on 02/09/2023.
//

import UIKit

class HomeVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        addGradientToBackground(colors: [.systemIndigo.withAlphaComponent(0.4),
                                         .systemBlue.withAlphaComponent(0.4)])
    }

}

