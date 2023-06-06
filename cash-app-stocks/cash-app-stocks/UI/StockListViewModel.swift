//
//  StockListViewModel.swift
//  cash-app-stocks
//
//  Created by Katy Kahla on 6/6/23.
//

import Foundation

extension StockList {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var stocks: [Stock] = []

        init() {
            reloadStocks()
        }
        
        func reloadStocks() {
            // TODO: Move to dependency injection container
            let stockRepository = DefaultStockRepository(apiService: ApiService())
            Task {
                await stockRepository.loadStocks() { result in
                    switch result {
                    case .success(let stocks):
                        if let stock = stocks {
                            // TODO: This is where I should massage my data for proper UI formatting
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }
    
    struct StockViewModel {
        
    }
}
