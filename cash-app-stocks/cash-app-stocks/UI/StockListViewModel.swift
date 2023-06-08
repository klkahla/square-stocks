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
                        DispatchQueue.main.async {
                            self.stockListUIState = .success(stocks: stocks.map(StockViewModel.init))
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
                    switch error {
                    case .noData:
                        DispatchQueue.main.async {
                            self.stockListUIState = .noData
                        }
                    case .badUrl:
                        DispatchQueue.main.async {
                            self.stockListUIState = .error(error)
                        }
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

struct StockViewModel {
    let stock: Stock
    
    var symbol: String {
        return self.stock.ticker.uppercased()
    }
    
    var description: String {
        return self.stock.name
    }
    
    var tradingPrice: String {
        // trading price is currency + currentPriceCents converted to dollar cents formatting
        let currentPriceDollars = Double(stock.currentPriceCents) / 100
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.groupingSeparator = ","
        let formattedNumber = numberFormatter.string(from: NSNumber(value: currentPriceDollars))
        return "\(formattedNumber ?? "")"
    }
}

