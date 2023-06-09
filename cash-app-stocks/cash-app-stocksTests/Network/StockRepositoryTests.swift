//
//  StockRepositoryTests.swift
//  cash-app-stocksTests
//
//  Created by Katy Kahla on 6/8/23.
//

import XCTest
@testable import cash_app_stocks

final class StockRepositoryTests: XCTestCase {
    
    var urlSession: URLSession!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockURLProtocol.self]
        URLProtocol.registerClass(MockURLProtocol.self)
        urlSession = URLSession(configuration: config)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testStockRepository_WhenGivenSuccessfulResponse_ReturnsSuccess() async {
        let jsonString = "{\"stocks\":[{\"ticker\":\"APPL\",\"name\":\"Apple\",\"currency\":\"USD\",\"current_price_cents\":318157,\"quantity\":5,\"current_price_timestamp\":1681845832}]}"
        let data = jsonString.data(using: .utf8)
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else {
                XCTFail("Unable to get url")
                throw NetworkError.badUrl
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }
        
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

    func testStockRepository_WhenGivenSuccessfulResponse_ReturnsSuccess_EmptyResponse() async {
        let jsonString = "{\"stocks\":[]}"
        let data = jsonString.data(using: .utf8)
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else {
                XCTFail("Unable to get url")
                throw NetworkError.badUrl
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }

        let apiService = ApiService(urlSession: urlSession)
        let stockRepository = DefaultStockRepository(apiService: apiService)

        await stockRepository.loadStocks { result in

            switch result {
                case .success(let stocks):

                XCTAssertEqual(stocks?.count, 0)
                default:
                    XCTFail("Empty body stock response not received")
            }
        }
    }

    func testStockRepository_ReturnsNetworkError_ImproperlyFormattedData() async {
        let data = Data()
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else {
                XCTFail("Unable to get url")
                throw NetworkError.badUrl
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }

        let apiService = ApiService(urlSession: urlSession)
        let stockRepository = DefaultStockRepository(apiService: apiService)

        await stockRepository.loadStocks { result in
            switch result {
                case .failure(let error):
                    XCTAssertEqual(error, NetworkError.decodingError, "Decoding error was expected")
                default:
                    XCTFail("No stocks returned")
            }
        }
    }
    
    func testStockRepository_ReturnsNetworkError_MalformedData() async {
        let jsonString = "{\"stocks\":[{\"ticker\":\"APPL\",\"name\":\"Apple\",\"currency\":\"USD\",\"current_price_cents\":318157,\"quantity\":5,\"current_price_timestamp\":1681845832}]}malformedmalformed"
        let data = jsonString.data(using: .utf8)
        
        MockURLProtocol.requestHandler = { request in
            guard let url = request.url else {
                XCTFail("Unable to get url")
                throw NetworkError.badUrl
            }
            
            let response = HTTPURLResponse(url: url, statusCode: 200, httpVersion: nil, headerFields: nil)!
            return (response, data)
        }

        let apiService = ApiService(urlSession: urlSession)
        let stockRepository = DefaultStockRepository(apiService: apiService)

        await stockRepository.loadStocks { result in
            switch result {
                case .failure(let error):
                    XCTAssertEqual(error, NetworkError.decodingError, "Decoding error was expected")
                default:
                    XCTFail("No stocks returned")
            }
        }
    }    
}
