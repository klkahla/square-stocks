//
//  WebRepository.swift
//  cash-app-stocks
//
//  Created by Katy Kahla on 6/6/23.
//

import Foundation
import Combine

protocol StockRepository {
    func loadStocks(completion: @escaping(Result<[Stock]?, NetworkError>) -> Void) async
}

class DefaultStockRepository: StockRepository {
    let apiService: ApiService
    
    init(apiService: ApiService) {
        self.apiService = apiService
    }
    
    func loadStocks(completion: @escaping(Result<[Stock]?, NetworkError>) -> Void) async {
        return await apiService.getStocks(completion: completion)
    }
}
