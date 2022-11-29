//
//  CurrencyConversionViewModel.swift
//  Currency
//
//  Created by Dhanasekarapandian Srinivasan on 11/29/22.
//

import Foundation


class CurrencyConversionViewModel {
    
    var currencies: [String: String]?
    var currencyRate: [String:Double]?
    
    var fromCurrency: [String: String]? {
        didSet {
            let fromCurrencyCode = fromCurrency?.keys.first
            if let oldValue = oldValue, oldValue.keys.first != fromCurrencyCode {
                //Trigger on change
                if fromCurrencyCode == toCurrency?.keys.first {
                    toCurrency = nil
                }
            }
        }
    }
    var toCurrency: [String: String]? {
        didSet {
            let toCurrencyCode = toCurrency?.keys.first
            if let oldValue = oldValue, oldValue.keys.first != toCurrencyCode {
                //Trigger on change
                if toCurrencyCode == fromCurrency?.keys.first {
                    fromCurrency = nil
                }
            }
        }
    }
    let defaultAmount = 1
    var fromAmount: Double? {
        didSet {
            if let amount = fromAmount,
                let toCurrency = toCurrency,
                let fromCurrency = fromCurrency,
                let fromCurrencyCode = fromCurrency.keys.first,
                let toCurrencyCode = toCurrency.keys.first {
                let key = "\(fromCurrencyCode)\(toCurrencyCode)"
                let rate = currencyRate?[key]
                toAmount = (rate ?? 0) * amount
            }
        }
    }
    var toAmount: Double? {
        didSet {
            if let amount = toAmount,
                let toCurrency = toCurrency,
                let fromCurrency = fromCurrency,
                let fromCurrencyCode = fromCurrency.keys.first,
                let toCurrencyCode = toCurrency.keys.first {
                let key = "\(fromCurrencyCode)\(toCurrencyCode)"
                let rate = currencyRate?[key]
                fromAmount = (rate ?? 0) / amount
            }
        }
    }
    
    var fromAmountToBeDisplayed: String {
        get {
            return fromAmount?.description ?? defaultAmount.description
        }
    }
    
    var toAmountToBeDisplayed: String {
        get {
            return toAmount?.description ?? ""
        }
    }
}
