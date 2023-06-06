//
//  StockRow.swift
//  cash-app-stocks
//
//  Created by Katy Kahla on 6/6/23.
//

import SwiftUI

struct StockRow: View {
    var stock: Stock
    
    var body: some View {
        HStack {
            VStack {
                // TODO: Make it pretty
                Text(stock.ticker)
                Text(stock.name)
            }
            Text(stock.currency)
        }
    }
}

struct StockRow_Previews: PreviewProvider {
    static var previews: some View {
        StockRow(stock: Stock(ticker: "^GSPC", name: "S&P 500", currency: "USD", currentPriceCents: 318000, quantity: 5, currentPriceTimestamp: 1681845832))
    }
}
