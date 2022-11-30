//
//  UITextField+CustomInit.swift
//  Currency
//
//  Created by Dhanasekarapandian Srinivasan on 11/29/22.
//

import Foundation
import UIKit

enum TextFieldType {
    case from
    case to
}

protocol TextFieldIdentifiable {
    var textFieldType: TextFieldType { get set }
}

protocol CurrencyPickable: AnyObject {
    func pickCurrency(for type: TextFieldType)
}

class CurrencyAmountTextField: UITextField, TextFieldIdentifiable {
    
    weak var pickerActionHanlder: CurrencyPickable?
        
    private var fieldType: TextFieldType = .from
    
    private var currencyButton = UIButton.init(type: .custom)
    
    var textFieldType: TextFieldType {
        get {
            return fieldType
        }
        set {
            fieldType = newValue
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        customInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        customInit()
    }
    
    private func customInit() {
        borderStyle = .roundedRect
        textAlignment = .center
        keyboardType = .decimalPad
        leftView = currencyButton
        currencyButton.backgroundColor = .gray
        currencyButton.setTitle("_\u{25BE}", for: .normal)
        currencyButton.titleLabel?.adjustsFontSizeToFitWidth = true
        currencyButton.addTarget(self, action: #selector(pickCurrency), for: .touchUpInside)
        leftViewMode = .always
    }
    
    @objc func pickCurrency() {
        if let _ = pickerActionHanlder {
            pickerActionHanlder?.pickCurrency(for: fieldType)
        }
    }
}
