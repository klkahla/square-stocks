//
//  StockListTests.swift
//  cash-app-stocksTests
//
//  Created by Katy Kahla on 6/8/23.
//

import XCTest
@testable import cash_app_stocks

final class StockListViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStockViewModelProperties() {
        // Arrange
        let stock = Stock(ticker: "AAPL", name: "Apple Inc.", currency: "USD", currentPriceCents: 9999, currentPriceTimestamp: 12390812)
        let stockViewModel = StockViewModel(stock: stock)
        
        // Act
        let symbol = stockViewModel.symbol
        let description = stockViewModel.description
        let tradingPrice = stockViewModel.tradingPrice
        
        // Assert
        XCTAssertEqual(symbol, "AAPL")
        XCTAssertEqual(description, "Apple Inc.")
        XCTAssertEqual(tradingPrice, "99.99") // Assuming 9999 cents = $99.99
    }

}
