//
//  StockRow.swift
//  cash-app-stocks
//
//  Created by Katy Kahla on 6/6/23.
//

import SwiftUI

struct StockRow: View {
    var stockViewModel: StockViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(stockViewModel.symbol)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                Text(stockViewModel.description)
                    .font(.body)
            }
            Spacer()
            VStack {
                Text(stockViewModel.tradingPrice)
                    .font(.body)
            }
        }
    }
}

struct StockRow_Previews: PreviewProvider {
    static var previews: some View {
        StockRow(stockViewModel: StockViewModel(stock: Stock(ticker: "^GSPC", name: "S&P 500", currency: "USD", currentPriceCents: 318000, quantity: 5, currentPriceTimestamp: 1681845832)))
    }
}
