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
    var currentPickingField: TextFieldType?
    
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
        swapButton.addTarget(self, action: #selector(swapCurrency), for: .touchUpInside)
        swapButton.translatesAutoresizingMaskIntoConstraints = false
        fromCurrencyTextField.translatesAutoresizingMaskIntoConstraints = false
        fromCurrencyTextField.pickerActionHanlder = self
        toCurrencyTextField.pickerActionHanlder = self
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
    
    @objc func swapCurrency() {
        currencyConnverterViewModel?.swapCurrencies()
        if let fromAmount = fromCurrencyTextField.text {
            currencyConnverterViewModel?.fromTextFieldAmount = fromAmount
        } else if let toAmount = toCurrencyTextField.text {
            currencyConnverterViewModel?.toTextFieldAmount = toAmount
        }
    }
}


extension ConverterViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let currencyAmountTextField = textField as? CurrencyAmountTextField else {
            return true
        }
        let fieldText = textField.text ?? ""
        let resultantText = string == "" ? String(fieldText.dropLast(1)) : fieldText + string
       
        switch currencyAmountTextField.textFieldType {
            case .from:
                currencyConnverterViewModel?.fromTextFieldAmount = resultantText
                break
            case .to:
                currencyConnverterViewModel?.toTextFieldAmount = resultantText
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
        (fromCurrencyTextField.leftView as? UIButton)?.setTitle(model.fromCurrency?.keys.first ?? "_\u{25BE}", for: .normal)
        (toCurrencyTextField.leftView as? UIButton)?.setTitle(model.toCurrency?.keys.first ??  "_\u{25BE}", for: .normal)
    }
    
    func updateFromfield() {
        guard let model = currencyConnverterViewModel else {
            return
        }
        fromCurrencyTextField.text = model.fromTextFieldAmountDisplayable
    }
    func updateToField() {
        guard let model = currencyConnverterViewModel else {
            return
        }
        toCurrencyTextField.text = model.toTextFieldAmountDisplayable
    }
}

extension ConverterViewController : CurrencyPickable, CurrencyPickedHandler {
    func pickCurrency(for type: TextFieldType) {
        currentPickingField = type
        let picker = PickerController(style: .insetGrouped)
        picker.data = currencyConnverterViewModel?.currencies
        picker.currencyPickedHandler = self
        present(picker, animated: true)
    }
    
    func currencyPicked(picked: [String : String]) {
        switch currentPickingField {
        case .to:
            currencyConnverterViewModel?.toCurrency = picked
            break
        case .from:
            currencyConnverterViewModel?.fromCurrency = picked
            break
        default:
            //No cases - impossible
            break
        }
        dismiss(animated: true)
    }
}
