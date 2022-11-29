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


class CurrencyAmountTextField: UITextField, TextFieldIdentifiable {
        
    private var fieldType: TextFieldType?
    
    private var currencyButton = UIButton.init(type: .custom)
    
    var textFieldType: TextFieldType {
        get {
            return fieldType!
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
        currencyButton.setTitle("__\u{25BE}", for: .normal)
        
        leftViewMode = .always
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        assert(fieldType != nil, "Field type is not set !!!")
    }
}
