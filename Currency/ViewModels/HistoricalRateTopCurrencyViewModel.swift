//
//  HistoricalRateTopCurrencyViewModel.swift
//  Currency
//
//  Created by Dhanasekarapandian Srinivasan on 11/30/22.
//

import Foundation

protocol HistoricalRateTopCurrencyEventable: AnyObject, DataFetching {
    func historicalDataChanged()
    
}

class HistoricalRateTopCurrencyViewModel {
    var historicalRate : Array<RateHistory> = [] {
        didSet {
            DispatchQueue.main.async { [weak self] in
                self?.subscriber?.historicalDataChanged()
            }
            
        }
    }
    var currencyRate: [String:Double] = [:]
    weak var subscriber: HistoricalRateTopCurrencyEventable?
    init(currencyRate: [String : Double], from: String, to: String) {
        self.currencyRate = currencyRate
        Task {
            await fetchHistoricalData(from: from, to: to, numberOfDaysHistory: 3)
        }
    }
    
    func fetchHistoricalData(from: String, to: String, numberOfDaysHistory: Int) async {
        DispatchQueue.main.async { [weak self] in
            self?.subscriber?.dataFetchStarted()
        }
        
        for i in  0...numberOfDaysHistory - 1 {
            let date = Date()
            let modifiedDate = Calendar.current.date(byAdding: .day, value: -1 * i, to: date) ?? Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let convertedDate = dateFormatter.string(from: modifiedDate)
            let service = ApiService(service: FixerIOService.init(type: .historical(date_YYYY_MM_DD: convertedDate, source: from, currencies: [to])))
            let result: Result<RateHistory?, APIError>? = try? await service?.getData()
            guard let _ = result else {
                DispatchQueue.main.async { [weak self] in
                    self?.subscriber?.dateFetchCompleted()
                }
                return
            }
            switch result {
            case .success(let rate):
                guard let rateAtDate = rate else { return }
                historicalRate.append(rateAtDate)
                break
            case .failure(let err):
                handleError(err: err)
                break
            case .none:
                handleError(err: .unknowError(msg: "No response returned from API host"))
            }
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
}
