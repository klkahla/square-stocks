//
//  StockDetailViewModel.swift
//  cash-app-stocks
//
//  Created by Katy Kahla on 6/9/23.
//

import Foundation

extension StockDetail {
//    var stockDetailViewModel: StockDetailViewModel
//    @MainActor class ViewModel: ObservableObject {
//
//    }
}


struct StockDetailViewModel {
    // NOTE: Don't like copy paste of code here. Maybe because I'm using the row element in both it needs it's own view model now
    // Then it gets the stock and does this work centralizing in one place
    
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
    
    var quantity: String {
        
        return "\( self.stock.quantity?.description ?? "")"
    }
    
    var currentValue: String {
        if let quanity = self.stock.quantity {
            let currentValue = Double(quanity * self.stock.currentPriceCents) / 100
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.groupingSeparator = ","
            let currentValueDollarAndDecimalFormat = numberFormatter.string(from: NSNumber(value: currentValue))
            return "\(currentValueDollarAndDecimalFormat ?? "")"
        }
        return ""
    }
    
    var lastUpdated: String {
        let epochTime = TimeInterval(1681845832)
        let date = Date(timeIntervalSince1970: epochTime)
        print("Converted Time \(date)")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM d, yyyy @ h:mm a"
        
        // Date - Time (i.e. May 14th, 2023 @ 3:40pm)
        return dateFormatter.string(from: date)
    }
}


