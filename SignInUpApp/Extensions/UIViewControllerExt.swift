//
//  UIViewControllerExt.swift
//  SignInUpApp
//
//  Created by Andrei Isayenka on 26/08/2023.
//

import UIKit

//extension UIViewController {
//    func hideKeyboardWhenTappedAround() {
//        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        tap.cancelsTouchesInView = false
//        view.addGestureRecognizer(tap)
//    }
//
//    @objc private func dismissKeyboard() {
//        view.endEditing(true)
//    }
//}

class BaseViewController: UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    func addGradientToBackground(colors: [CGColor]) {
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = view.frame
        gradientLayer.colors = colors
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}

