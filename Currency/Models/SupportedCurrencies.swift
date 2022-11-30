//
//  SupportedCurrencies.swift
//  Currency
//
//  Created by Dhanasekarapandian Srinivasan on 11/29/22.
//

import Foundation


struct SupportedCurrencies : Codable {
    let currencies: [String: String]
    let success: Bool
}
