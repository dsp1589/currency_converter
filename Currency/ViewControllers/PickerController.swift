//
//  PickerController.swift
//  Currency
//
//  Created by Dhanasekarapandian Srinivasan on 11/29/22.
//

import Foundation
import UIKit

protocol CurrencyPickedHandler: AnyObject {
    func currencyPicked(picked: [String: String])
}

class PickerController : UITableViewController {
    
    let cellIdentifier = "CurrencyListItem"
    weak var currencyPickedHandler: CurrencyPickedHandler?
    var data: [String: String]?
    private var currencyCodes: [String] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pick a Currency"
        guard data != nil, !(data?.keys.isEmpty ?? true) else {
            dismiss(animated: true)
            return
        }
        if let keys = data?.keys {
            currencyCodes.append(contentsOf: keys)
        }
        currencyCodes.sort()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data?.keys.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier)
        if let cell = cell {
            cell.textLabel?.text = currencyCodes[indexPath.row]
            return cell
        } else {
            let cell = UITableViewCell.init(style: .default, reuseIdentifier: cellIdentifier)
            cell.textLabel?.text = currencyCodes[indexPath.row]
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        var result: Dictionary<String, String> = [:]
        result[currencyCodes[indexPath.row]] = data?[currencyCodes[indexPath.row]] ?? ""
        currencyPickedHandler?.currencyPicked(picked: result)
    }
}
