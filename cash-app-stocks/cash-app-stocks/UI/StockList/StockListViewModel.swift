//
//  StockListViewModel.swift
//  cash-app-stocks
//
//  Created by Katy Kahla on 6/6/23.
//

import Foundation

enum StockListUIState {
    case success(stocks: [StockViewModel])
    case error(Error)
    case loading
    case noData
}

extension StockList {
    @MainActor class ViewModel: ObservableObject {
        @Published private(set) var stockListUIState: StockListUIState = .loading
        
        init() {
            reloadStocks()
        }
        
        func reloadStocks() {
            // TODO: Move to dependency injection container
            let stockRepository = DefaultStockRepository(apiService: ApiService())
            Task.detached { // Task was blocking main thread -> https://stackoverflow.com/questions/71837201/task-blocks-main-thread-when-calling-async-function-inside
                await stockRepository.loadStocks() { result in
                    switch result {
                    case .success(let stocks):
                        if let stocks = stocks {
                            if stocks.isEmpty {
                                DispatchQueue.main.async {
                                    self.stockListUIState = .noData
                                }
                            } else {
                                DispatchQueue.main.async {
                                    self.stockListUIState = .success(stocks: stocks.map(StockViewModel.init))
                                }
                            }
                        }
                    case .failure(let error):
                        print(error.localizedDescription)
                        switch error {
                        default:
                            DispatchQueue.main.async {
                                self.stockListUIState = .error(error)
                            }
                        }
                    }
                }
            }
        }
    }
}

struct StockViewModel {
    let stock: Stock
    
    var symbol: String {
        return self.stock.ticker.uppercased()
    }
    
    var description: String {
        return self.stock.name
    }
    
    var tradingPrice: String {
        // TODO: Country code symbol
        
        // trading price is currency + currentPriceCents converted to dollar cents formatting
        let currentPriceDollars = Double(stock.currentPriceCents) / 100
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        let currentPriceDollarAndDecimalFormat = numberFormatter.string(from: NSNumber(value: currentPriceDollars))
        return "\(currentPriceDollarAndDecimalFormat ?? "")"
    }
}
