//
//  ApiService.swift
//  cash-app-stocks
//
//  Created by Katy Kahla on 6/6/23.
//

import Foundation

enum NetworkError: Error {
    case badUrl
    case noData
    case decodingError
}

class ApiService {
    
    func getStocks(completion: @escaping(Result<[Stock]?, NetworkError>) -> Void) async {
        guard let url = URL(string: "https://storage.googleapis.com/cash-homework/cash-stocks-api/portfolio.json") else {
            return completion(.failure(.badUrl))
        }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            do {
                let decoded = try decoder.decode(StockResponse.self, from: data)
                return completion(.success(decoded.stocks))
            } catch {
                return completion(.failure(.decodingError))
            }
        } catch {
            return completion(.failure(.noData))
        }
    }
}
