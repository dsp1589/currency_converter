//
//  UITextField+CustomInit.swift
//  Currency
//
//  Created by Dhanasekarapandian Srinivasan on 11/29/22.
//

import Foundation
import UIKit

enum TextFieldType {
    case From
    case To
}

protocol TextFieldIdentifiable {
    var textFieldType: TextFieldType { get set }
}


class CurrencyAmountTextField: UITextField, TextFieldIdentifiable {
    
    weak var model: CurrencyConversionViewModel?
    
    private var fieldType: TextFieldType = .From
    
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
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        guard let _ = model else {
            debugPrint("Model set up failed. forgot to set up model")
            return
        }
    }
}
