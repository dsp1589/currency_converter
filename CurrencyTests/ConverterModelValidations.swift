//
//  ConverterModelValidations.swift
//  CurrencyTests
//
//  Created by Dhanasekarapandian Srinivasan on 11/30/22.
//

import Foundation

import XCTest
@testable import Currency

final class ConverterModelValidations : XCTestCase {
    
    var model = CurrencyConversionViewModel(subscriber: MockCurrencyConversionViewModelEventable())
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        print("Setup")
        model.fromCurrency = ["ABC":"ABC Country"]
        model.toCurrency = ["DEF":"DEF Country"]
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        print("tear down")
    }

    func testCurrencySwap() throws {
        model.swapCurrencies()
        XCTAssert(model.fromCurrency?.keys.first == "DEF", "Swap currency failed")
        XCTAssert(model.toCurrency?.keys.first == "ABC", "Swap currency failed")
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
}

class MockCurrencyConversionViewModelEventable: CurrencyConversionViewModelEventable {
    func dataFetchStarted() {
        
    }
    
    func dateFetchCompleted() {
        
    }
    
    func dataFetchError(msg: String?) {
        
    }
    
    func updateDisplayedData() {
        
    }
    
    func updateToField() {
        
    }
    
    func updateFromfield() {
    
    }
    
    
}
