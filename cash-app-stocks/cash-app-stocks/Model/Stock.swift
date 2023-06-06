//
//  Stock.swift
//  cash-app-stocks
//
//  Created by Katy Kahla on 6/6/23.
//

import Foundation

struct StockResponse: Decodable {
    let stocks: [Stock]
}

struct Stock: Decodable, Identifiable {
    let id = UUID()
    var ticker: String
    var name: String
    var currency: String
    var currentPriceCents: Int 
    var quantity: Int?
    var currentPriceTimestamp: Int
}


class Api: ObservableObject {
    @Published var stocks = [Stock]()
    
    func fetchStocksFromAPI() async throws -> [Stock] {
        let url = URL(string: "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio.json")!
        
        let (data, _) = try await URLSession.shared.data(from: url)
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let decoded = try decoder.decode(StockResponse.self, from: data)
        
        return decoded.stocks
    }
}


