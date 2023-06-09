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
        let stockRowViewModel = StockRowViewModel(stock: stock)
        HStack {
            VStack(alignment: .leading) {
                Text(stockRowViewModel.symbol)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                Text(stockRowViewModel.description)
                    .font(.body)
            }
            Spacer()
            VStack {
                Text(stockRowViewModel.tradingPrice)
                    .font(.body)
            }
        }
    }
}

struct StockRow_Previews: PreviewProvider {
    static var previews: some View {
        StockRow(stock: Stock(ticker: "APPL", name: "Apple", currency: "USD", currentPriceCents: 318157, quantity: 5, currentPriceTimestamp: 1681845832))
    }
}
