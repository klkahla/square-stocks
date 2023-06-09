//
//  StockRowViewModel.swift
//  cash-app-stocks
//
//  Created by Katy Kahla on 6/9/23.
//

import Foundation

struct StockRowViewModel {    
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
