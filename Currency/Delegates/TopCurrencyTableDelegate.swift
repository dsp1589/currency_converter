//
//  TopCurrencyTableDelegate.swift
//  Currency
//
//  Created by Dhanasekarapandian Srinivasan on 11/30/22.
//

import Foundation
import UIKit


class TopCurrencyTableDelegate : NSObject, UITableViewDelegate {
    
    let currenciesRate: [String: Double]?
    let topCurrencies: [String]?
    init(currenciesRate: [String : Double]?) {
        self.currenciesRate = currenciesRate
        self.topCurrencies = self.currenciesRate?.map({ item in
            return item.key
        })
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topCurrencies != nil ? (topCurrencies?.count ?? 0) >= 10 ? 10 : (topCurrencies?.count ?? 0) : 0
    }
}

extension TopCurrencyTableDelegate : UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        let currency = topCurrencies?[indexPath.row] ?? ""
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "topCurrecny") {
            cell = dequeuedCell
        } else {
            cell = UITableViewCell(style: .value1, reuseIdentifier: "topCurrecny")
        }
        cell.textLabel?.text = currency
        cell.detailTextLabel?.text = currenciesRate?[currency]?.description
        cell.detailTextLabel?.adjustsFontSizeToFitWidth = true
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Top Currencies"
    }
}
