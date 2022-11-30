//
//  HistoricalRateTableDelegate.swift
//  Currency
//
//  Created by Dhanasekarapandian Srinivasan on 11/30/22.
//

import Foundation
import UIKit

class HistoricalRateTableDelegate : NSObject, UITableViewDelegate{
    
    var history: [RateHistory]
    init(history: [RateHistory]) {
        self.history = history
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return history.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

}

extension HistoricalRateTableDelegate : UITableViewDataSource {

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell : UITableViewCell
        if let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: "history") {
            cell = dequeuedCell
        } else {
            cell = .init(style: .subtitle, reuseIdentifier: "history")
        }
        let rateHistory = history[indexPath.section]
        cell.textLabel?.text = rateHistory.quotes.keys.first
        cell.detailTextLabel?.text = rateHistory.quotes.values.first?.description
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return history[section].date
    }
}
