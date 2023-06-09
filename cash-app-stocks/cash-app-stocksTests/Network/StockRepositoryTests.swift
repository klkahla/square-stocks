//
//  StockRepositoryTests.swift
//  cash-app-stocksTests
//
//  Created by Katy Kahla on 6/8/23.
//

import XCTest
@testable import cash_app_stocks

final class StockRepositoryTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStockRepository_WhenGivenSuccessfulResponse_ReturnsSuccess() async {
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        URLProtocol.registerClass(MockURLProtocol.self)
        let urlSession = URLSession(configuration: config)
        let jsonString = "{\"stocks\":[{\"ticker\":\"APPL\",\"name\":\"Apple\",\"currency\":\"USD\",\"current_price_cents\":318157,\"quantity\":5,\"current_price_timestamp\":1681845832}]}"
        MockURLProtocol.stubResponseData = jsonString.data(using: .utf8)
        
        let apiService = ApiService(urlSession: urlSession)
        let stockRepository = DefaultStockRepository(apiService: apiService)
        
        await stockRepository.loadStocks { result in
        
            switch result {
                case .success(let stocks):
                    let expectedStock = Stock(ticker: "APPL", name: "Apple", currency: "USD", currentPriceCents: 318157, quantity: 5, currentPriceTimestamp: 1681845832)
                    XCTAssertEqual(stocks?[0].ticker, expectedStock.ticker)
                    XCTAssertEqual(stocks?[0].name, expectedStock.name)
                    XCTAssertEqual(stocks?[0].currency, expectedStock.currency)
                    XCTAssertEqual(stocks?[0].currentPriceCents, expectedStock.currentPriceCents)
                    XCTAssertEqual(stocks?[0].quantity, expectedStock.quantity)
                    XCTAssertEqual(stocks?[0].currentPriceTimestamp, expectedStock.currentPriceTimestamp)
                default:
                    XCTFail("No stocks returned")
            }
        }
    }

}
