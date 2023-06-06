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

        init {
            // TODO: Move to dependency injection container
            let stockRepository = DefaultStockRepository()
            Task {
                do {
                    self.stocks = try await stockRepository.loadStocks()
                } catch {
                    print(error)
                }
            }
        }
        
    }
}
