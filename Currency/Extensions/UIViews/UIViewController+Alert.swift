//
//  UIViewController+Alert.swift
//  Currency
//
//  Created by Dhanasekarapandian Srinivasan on 11/30/22.
//

import Foundation
import UIKit


extension UIViewController {
    func showErrorMessage(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "Ok", style: .destructive)
        alert.addAction(actionOk)
        present(alert, animated: true)
    }
}
