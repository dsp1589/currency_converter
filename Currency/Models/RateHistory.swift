//
//  RateHistory.swift
//  Currency
//
//  Created by Dhanasekarapandian Srinivasan on 11/30/22.
//

import Foundation

struct RateHistory: Codable {
    let date: String
    let historical: Bool
    let quotes: [String: Double]
    let source: String
    let success: Bool
    let timestamp: Int64
}
