//
//  HistoricalRateAndPopularCurrencyController.swift
//  Currency
//
//  Created by Dhanasekarapandian Srinivasan on 11/30/22.
//

import Foundation
import UIKit


class HistoricalRateAndPopularCurrencyController: UIViewController, HistoricalRateTopCurrencyEventable {
    func dataFetchStarted() {
        
    }
    
    func dateFetchCompleted() {
        
    }
    
    func dataFetchError(msg: String?) {
        
    }
    
    func historicalDataChanged() {
        historyDelegate.history.removeAll()
        historyDelegate.history.append(contentsOf: historyModel.historicalRate)
        historyList.reloadData()
    }
    
    let model: CurrencyConversionViewModel
    let historyModel: HistoricalRateTopCurrencyViewModel
    let popularCurrencies: [String]
    var historyList: UITableView!
    var topCurrencyList: UITableView!
    var historyDelegate: HistoricalRateTableDelegate
    let topCurrencyDelegate: TopCurrencyTableDelegate
    init(model: CurrencyConversionViewModel, popularCurrencies: [String]) {
        self.model = model
        self.historyModel = HistoricalRateTopCurrencyViewModel(currencyRate: model.currencyRate!, from: model.fromCurrency?.keys.first ?? "", to: model.toCurrency?.keys.first ?? "")
        self.popularCurrencies = popularCurrencies
        self.historyDelegate = HistoricalRateTableDelegate(history: self.historyModel.historicalRate)
        self.topCurrencyDelegate  = TopCurrencyTableDelegate(currenciesRate: model.currencyRate)
        super.init(nibName: nil, bundle: nil)
        self.historyModel.subscriber = self
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("Cannot instantiate this view controller. please use init:model:popularCurrencies")
    }
    
    override func loadView() {
        super.loadView()
        view = UIView()
        view.backgroundColor = .white
        historyList = UITableView(frame: .zero, style: .insetGrouped)
        topCurrencyList = UITableView(frame: .zero, style: .insetGrouped)
        
        view.addSubview(historyList)
        view.addSubview(topCurrencyList)
        
        historyList.translatesAutoresizingMaskIntoConstraints = false
        historyList.delegate = historyDelegate
        historyList.dataSource = historyDelegate
        
        topCurrencyList.translatesAutoresizingMaskIntoConstraints = false
        topCurrencyList.delegate = topCurrencyDelegate
        topCurrencyList.dataSource = topCurrencyDelegate
        setupConstraints()
    }
    
    private func setupConstraints() {
        view.addConstraints([historyList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
                             historyList.trailingAnchor.constraint(equalTo: view.centerXAnchor), historyList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), historyList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])
        view.addConstraints([topCurrencyList.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                             topCurrencyList.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor), topCurrencyList.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor), topCurrencyList.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)])

    }

}



