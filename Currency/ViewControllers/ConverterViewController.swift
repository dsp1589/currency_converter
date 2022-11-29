//
//  ConverterViewController.swift
//  Currency
//
//  Created by Dhanasekarapandian Srinivasan on 11/29/22.
//

import Foundation
import UIKit

class ConverterViewController: UIViewController {
    
    let currencyConnverterViewModel = CurrencyConversionViewModel()
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .white
        
        let button = UIButton(type: .custom)
        button.setImage(.init(named: "swap"), for: .normal)
        button.frame = .init(origin: .zero, size: .init(width: 32, height: 32))
        button.translatesAutoresizingMaskIntoConstraints = false
        let fromCurrencyTextField = CurrencyAmountTextField.init()
        let toCurrencyTextField = CurrencyAmountTextField.init()
        fromCurrencyTextField.translatesAutoresizingMaskIntoConstraints = false
        toCurrencyTextField.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        view.addSubview(fromCurrencyTextField)
        view.addSubview(toCurrencyTextField)
        view.addConstraints([button.centerXAnchor.constraint(equalTo: view.centerXAnchor), button.centerYAnchor.constraint(equalTo: view.centerYAnchor).with(0.3)])
        view.addConstraints([fromCurrencyTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8), fromCurrencyTextField.trailingAnchor.constraint(equalTo: button.leadingAnchor, constant: -20), fromCurrencyTextField.centerYAnchor.constraint(equalTo: button.centerYAnchor), toCurrencyTextField.leadingAnchor.constraint(equalTo: button.trailingAnchor, constant: 20), toCurrencyTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8), toCurrencyTextField.centerYAnchor.constraint(equalTo: button.centerYAnchor)])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Converter"
    }
}


extension ConverterViewController: UITextFieldDelegate {
    
}
