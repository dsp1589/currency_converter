//
//  ConverterViewController.swift
//  Currency
//
//  Created by Dhanasekarapandian Srinivasan on 11/29/22.
//

import Foundation
import UIKit

class ConverterViewController: UIViewController {
    
    var currencyConnverterViewModel : CurrencyConversionViewModel?
    let fromCurrencyTextField = CurrencyAmountTextField.init()
    let toCurrencyTextField = CurrencyAmountTextField.init()
    let swapButton = UIButton(type: .custom)
    
    override func loadView() {
        super.loadView()
        currencyConnverterViewModel = CurrencyConversionViewModel(subscriber: self)
        view = UIView()
        view.backgroundColor = .white
        
        fromCurrencyTextField.textFieldType = .from
        fromCurrencyTextField.delegate = self
        toCurrencyTextField.textFieldType = .to
        toCurrencyTextField.delegate = self
        swapButton.setImage(.init(named: "swap"), for: .normal)
        swapButton.frame = .init(origin: .zero, size: .init(width: 32, height: 32))
        
        swapButton.translatesAutoresizingMaskIntoConstraints = false
        fromCurrencyTextField.translatesAutoresizingMaskIntoConstraints = false
        toCurrencyTextField.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(swapButton)
        view.addSubview(fromCurrencyTextField)
        view.addSubview(toCurrencyTextField)
        view.addConstraints([swapButton.centerXAnchor.constraint(equalTo: view.centerXAnchor), swapButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).with(0.3)])
        view.addConstraints([fromCurrencyTextField.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 8), fromCurrencyTextField.trailingAnchor.constraint(equalTo: swapButton.leadingAnchor, constant: -20), fromCurrencyTextField.centerYAnchor.constraint(equalTo: swapButton.centerYAnchor), toCurrencyTextField.leadingAnchor.constraint(equalTo: swapButton.trailingAnchor, constant: 20), toCurrencyTextField.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -8), toCurrencyTextField.centerYAnchor.constraint(equalTo: swapButton.centerYAnchor)])
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Converter"
    }
}


extension ConverterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currencyAmountTextField = textField as? CurrencyAmountTextField else {
            return true
        }
        let fieldText = textField.text ?? ""
        let resultantText = fieldText + string
        guard let amountValue = Double(resultantText) else {
            return false
        }
        switch currencyAmountTextField.textFieldType {
            case .from:
                currencyConnverterViewModel?.fromAmount = amountValue
                break
            case .to:
                currencyConnverterViewModel?.toAmount = amountValue
                break
        }
        return true
    }
}


extension ConverterViewController : CurrencyConversionViewModelEventable {
    func dataFetchStarted() {
        fromCurrencyTextField.isEnabled = false
        toCurrencyTextField.isEnabled = false
        swapButton.isEnabled = false
    }
    
    func dateFetchCompleted() {
        fromCurrencyTextField.isEnabled = true
        toCurrencyTextField.isEnabled = true
        swapButton.isEnabled = true
    }
    
    func updateDisplayedData() {
        guard let model = currencyConnverterViewModel else {
            return
        }
        (fromCurrencyTextField.leftView as? UIButton)?.setTitle(model.fromCurrency?.keys.first ?? "__", for: .normal)
        (toCurrencyTextField.leftView as? UIButton)?.setTitle(model.toCurrency?.keys.first ??  "__", for: .normal)
        fromCurrencyTextField.text = model.fromAmountToBeDisplayed
        toCurrencyTextField.text = model.toAmountToBeDisplayed
    }
}
