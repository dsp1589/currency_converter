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
    var currencies = try! JSONDecoder().decode(SupportedCurrencies.self, from: inputCurrencies.data(using: .utf8)!)
    var currencyCode: [String] {
        get {
            return currencies.currencies.map { (key: String, value: String) in
                key
            }
        }
    }
    let fromCurrency = ["AED": "United Arab Emirates Dirham"]
    let toCurrency = ["AUD": "Australian Dollar"]
    var currencyRates = try! JSONDecoder().decode(ExchangeRate.self, from: rates.data(using: .utf8)!)
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        print("Setup")
        model.fromCurrency = fromCurrency
        model.toCurrency = toCurrency
        model.currencyRate = currencyRates.quotes
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        print("tear down")
    }

    func testCurrencySwap() throws {
        model.swapCurrencies()
        XCTAssert(model.fromCurrency?.keys.first == toCurrency.keys.first, "Swap currency failed")
        XCTAssert(model.toCurrency?.keys.first == fromCurrency.keys.first, "Swap currency failed")
        model.swapCurrencies()
    }
    
    func testForwardCalculation() {
        model.fromTextFieldAmount = "1.0"
        XCTAssert(model.toTextFieldAmountDisplayable == "0.404924", "To field calculation failed when from edited")
        model.fromTextFieldAmount = "1.345"
        XCTAssert(model.toTextFieldAmountDisplayable == "0.54462278", "To field calculation failed when from edited with three dec places")
        model.fromTextFieldAmount = "1.1.1"
        XCTAssert(model.toTextFieldAmountDisplayable == "", "To field calculation failed for invalid number with multiple decimal points")
    }
    
    func testSwappedCalculation() throws {
        model.swapCurrencies()
        model.fromTextFieldAmount = "1.0"
        XCTAssert(model.toTextFieldAmountDisplayable == "2.469599233436398", "Reverse calculation, from field editing not producting right To field")
        model.fromTextFieldAmount = "1.678"
        XCTAssert(model.toTextFieldAmountDisplayable == "4.143987513706276", "Reverse calculation, from field editing not producting right To field")
        model.fromTextFieldAmount = "1.6.78"
        XCTAssert(model.toTextFieldAmountDisplayable == "", "Reverse calculation, from field editing not producting right To field")
        model.swapCurrencies()
    }
    
    func testForwardCalculationToFieldEditing() {
        model.toTextFieldAmount = "1.0"
        XCTAssert(model.fromTextFieldAmountDisplayable == "2.469599233436398", "FROM field calculation failed when TO edited")
        model.toTextFieldAmount = "1.345"
        XCTAssert(model.fromTextFieldAmountDisplayable == "3.3216109689719553", "FROM field calculation failed when TO edited with three dec places")
        model.toTextFieldAmount = "1.1.1"
        XCTAssert(model.fromTextFieldAmountDisplayable == "", "FROM field calculation failed for invalid number with multiple decimal points")
    }
    
    func testSwappedCalculationToFieldEditing() {
        model.swapCurrencies()
        model.toTextFieldAmount = "1.0"
        XCTAssert(model.fromTextFieldAmountDisplayable == "0.404924", "Reverse calculation, TO field editing not producting right FROM field")
        model.toTextFieldAmount = "1.678"
        XCTAssert(model.fromTextFieldAmountDisplayable == "0.679462472", "Reverse calculation, TO field editing not producting right FROM field")
        model.toTextFieldAmount = "1.6.78"
        XCTAssert(model.fromTextFieldAmountDisplayable == "", "Reverse calculation, TO field editing not producting right FROM field")
        model.swapCurrencies()
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
