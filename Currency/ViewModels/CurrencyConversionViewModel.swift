//
//  CurrencyConversionViewModel.swift
//  Currency
//
//  Created by Dhanasekarapandian Srinivasan on 11/29/22.
//

import Foundation


protocol DataFetching {
     func dataFetchStarted()
     func dateFetchCompleted()
     func dataFetchError(msg: String?)
}

protocol DataRefreshable {
    func updateDisplayedData()
    func updateToField()
    func updateFromfield()
}

protocol CurrencyConversionViewModelEventable: AnyObject, DataFetching, DataRefreshable {}

class CurrencyConversionViewModel {
    init(subscriber: CurrencyConversionViewModelEventable) {
        self.subscriber = subscriber
        Task {
            await fetchCurrencies()
        }
    }
    var reverseCalculation = false
    var historicalRate : [RateHistory] = []
    private weak var subscriber: CurrencyConversionViewModelEventable?
    
    var currencies: [String: String]? {
        didSet {
            displayableDataUpdated()
        }
    }
    var currencyRate: [String:Double]?
    
    var fromCurrency: [String: String]? {
        didSet {
            displayableDataUpdated()
            fromToCurrencyChanged()
        }
    }
    var toCurrency: [String: String]? {
        didSet {
            displayableDataUpdated()
            fromToCurrencyChanged()
        }
    }
    let defaultAmount: Double = 1
    
    var fromAmount: String? 
    var toAmount: String?
    
    
    var fromTextFieldAmountDisplayable : String?
    var toTextFieldAmountDisplayable : String?
    
    var fromTextFieldAmount: String? {
        didSet {
            fromAmount = fromTextFieldAmount
            calculateToAmount()
        }
    }
    
    var toTextFieldAmount: String? {
        didSet {
            toAmount = toTextFieldAmount
            calculateFromAmount()
        }
    }
    
    private func calculateFromAmount() {
        if let amount = toAmount,
           let doubleAmount = Double(amount),
            let toCurrency = toCurrency,
            let fromCurrency = fromCurrency,
            let fromCurrencyCode = fromCurrency.keys.first,
            let toCurrencyCode = toCurrency.keys.first {
            if !reverseCalculation {
                let key = "\(fromCurrencyCode)\(toCurrencyCode)"
                let rate = currencyRate?[key]
                fromAmount = (doubleAmount / (rate ?? 1)).description

            } else {
                let key = "\(toCurrencyCode)\(fromCurrencyCode)"
                let rate = currencyRate?[key]
                fromAmount = ((rate ?? 0) * doubleAmount).description
            }
            fromTextFieldAmountDisplayable = fromAmount
        } else {
            fromAmount = ""
            fromTextFieldAmountDisplayable = fromAmount
        }
        DispatchQueue.main.async {
            self.subscriber?.updateFromfield()
        }
    }
    
    private func calculateToAmount() {
        if let amount = fromAmount,
           let doubleAmount = Double(amount),
            let toCurrency = toCurrency,
            let fromCurrency = fromCurrency,
            let fromCurrencyCode = fromCurrency.keys.first,
            let toCurrencyCode = toCurrency.keys.first {
            if !reverseCalculation {
                let key = "\(fromCurrencyCode)\(toCurrencyCode)"
                let rate = currencyRate?[key]
                toAmount = ((rate ?? 0) * doubleAmount).description
            } else {
                let key = "\(toCurrencyCode)\(fromCurrencyCode)"
                let rate = currencyRate?[key]
                toAmount = (doubleAmount / (rate ?? 1)).description
            }
            toTextFieldAmountDisplayable = toAmount
        } else {
            toAmount = ""
            toTextFieldAmountDisplayable = toAmount
        }
        DispatchQueue.main.async {
            self.subscriber?.updateToField()
        }
    }
    
    func swapCurrencies() {
        let fromCurrencyTempHolder = fromCurrency
        fromCurrency = toCurrency
        toCurrency = fromCurrencyTempHolder
        reverseCalculation = !reverseCalculation
        doCalculation()
    }
    
    private func fetchCurrencies() async {
        DispatchQueue.main.async { [weak self] in
            self?.subscriber?.dataFetchStarted()
        }
        let service = ApiService(service: FixerIOService.init(type: .currencyList))
        let result: Result<SupportedCurrencies?, APIError>? = try? await service?.getData()
        guard let _ = result else {
            DispatchQueue.main.async { [weak self] in
                self?.subscriber?.dateFetchCompleted()
            }
            return
        }
        switch result {
        case .success(let currenciesAvailable):
            currencies = currenciesAvailable?.currencies
            break
        case .failure(let err):
            handleError(err: err)
            break
        case .none:
            handleError(err: .unknowError(msg: "No response returned from API host"))
        }
        
        DispatchQueue.main.async { [weak self] in
            self?.subscriber?.dateFetchCompleted()
        }
    }
    
    private func handleError(err: APIError) {
        switch err {
        case .unauthAccess:
            self.subscriber?.dataFetchError(msg: "Please verify access token passed in headers for authorization!!!")
            break
        case .unknowError(let message),
                .rateLimitExceeded(let message):
            self.subscriber?.dataFetchError(msg: message)
            break
        case .requestFailed:
            self.subscriber?.dataFetchError(msg: "Bad request, server not able to process client request !!!")
            break
        }
    }
    
    private func fromToCurrencyChanged() {
        guard let toCurrencyCode = toCurrency?.keys.first,
            let fromCurrencyCode = fromCurrency?.keys.first else { return }
        let rateKey = "\(fromCurrencyCode)\(toCurrencyCode)"
        if currencyRate?[rateKey] != nil || currencyRate?["\(toCurrencyCode)\(fromCurrencyCode)"] != nil ||
        fromCurrencyCode == toCurrencyCode {
            return
        }
        guard let _ = currencyRate?[rateKey] else {
            Task {
               await fetchRates()
            }
            return
        }
    }
    
    private func fetchRates() async {
        DispatchQueue.main.async { [weak self] in
            self?.subscriber?.dataFetchStarted()
        }
        guard let source = fromCurrency?.keys.first,
              let _ = toCurrency?.keys.first else {
            return
        }
        
        let service = ApiService(service: FixerIOService.init(type: .currencyRate(source: source)))
        let result: Result<ExchangeRate?, APIError>? = try? await service?.getData()
        guard let _ = result else {
            DispatchQueue.main.async { [weak self] in
                self?.subscriber?.dateFetchCompleted()
            }
            return
        }
        currencyRate?.removeAll()
        switch result {
        case .success(let rates):
            currencyRate = rates?.quotes
            break
        case .failure(let err):
            handleError(err: err)
            break
        case .none:
            handleError(err: .unknowError(msg: "No response returned from API host"))
        }
        DispatchQueue.main.async { [weak self] in
            self?.subscriber?.dateFetchCompleted()
            self?.doCalculation()
            self?.displayableDataUpdated()
        }
    }
    
    private func doCalculation() {
        let amountFrom = Double(fromAmount ?? "0") ?? defaultAmount
        fromAmount = amountFrom.description
        
    }
    
    private func displayableDataUpdated() {
        DispatchQueue.main.async { [weak self] in
            self?.subscriber?.updateDisplayedData()
        }
    }
}
