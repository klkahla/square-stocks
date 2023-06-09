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
    let stock: Stock

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


