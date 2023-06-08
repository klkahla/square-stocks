//
//  StockListViewModel.swift
//  cash-app-stocks
//
//  Created by Katy Kahla on 6/6/23.
//

import Foundation


@MainActor class ViewModel: ObservableObject {
    @Published private(set) var stocks: [StockViewModel] = [StockViewModel]()

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
                    if let stocks = stocks {
                        DispatchQueue.main.async {
                            self.stocks = stocks.map(StockViewModel.init)
                        }
                    }
                case .failure(let error):
                    print(error.localizedDescription)
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

