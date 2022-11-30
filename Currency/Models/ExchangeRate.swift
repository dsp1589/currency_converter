//
//  ExchangeRate.swift
//  Currency
//
//  Created by Dhanasekarapandian Srinivasan on 11/29/22.
//

import Foundation

struct ExchangeRate : Codable {
    let quotes: [String:Double]
    let source: String
    let success: Bool
    let timestamp: Int64
}
