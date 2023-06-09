//
//  MockUrlProtocol.swift
//  cash-app-stocksTests
//
//  Created by Katy Kahla on 6/8/23.
//

import Foundation

class MockURLProtocol: URLProtocol {
    
    static var requestHandler: ((URLRequest) throws -> (HTTPURLResponse, Data?))?
    static var mockResponse: (Data?, URLResponse?, Error?)?
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        guard let handler = MockURLProtocol.requestHandler else {
            fatalError("Handler is unavailable.")
        }

        do {
            // 2. Call handler with received request and capture the tuple of response and data.
            let (response, data) = try handler(request)
            
            if let (data, response, error) = MockURLProtocol.mockResponse {
                // Provide the mock response
                if let httpResponse = response as? HTTPURLResponse {
                    self.client?.urlProtocol(self, didReceive: httpResponse, cacheStoragePolicy: .notAllowed)
                }
                if let responseData = data {
                    self.client?.urlProtocol(self, didLoad: responseData)
                }
                if let error = error {
                    self.client?.urlProtocol(self, didFailWithError: error)
                }
            }

            // 3. Send received response to the client.
            client?.urlProtocol(self, didReceive: response, cacheStoragePolicy: .notAllowed)

            if let data = data {
              // 4. Send received data to the client.
              client?.urlProtocol(self, didLoad: data)
            }

            // 5. Notify request has been finished.
            client?.urlProtocolDidFinishLoading(self)
        } catch {
            // 6. Notify received error.
            client?.urlProtocol(self, didFailWithError: error)
        }
    }
    
    override func stopLoading() {
        
    }
}
