//
//  WebRepository.swift
//  cash-app-stocks
//
//  Created by Katy Kahla on 6/6/23.
//

import Foundation
import Combine

protocol StockRepository {
    func loadStocks() async throws -> [Stock]
}

class DefaultStockRepository: StockRepository {
    func loadStocks() async throws -> [Stock] {
        let url = URL(string: "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio.json")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decoded = try decoder.decode(StockResponse.self, from: data)
        
        return decoded.stocks
    }
}
