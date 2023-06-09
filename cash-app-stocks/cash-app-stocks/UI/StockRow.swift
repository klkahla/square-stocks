//
//  StockRow.swift
//  cash-app-stocks
//
//  Created by Katy Kahla on 6/6/23.
//

import SwiftUI

struct StockRow: View {
    var symbol: String
    var description: String
    var tradingPrice: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(symbol)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(EdgeInsets(top: 0, leading: 0, bottom: 5, trailing: 0))
                Text(description)
                    .font(.body)
            }
            Spacer()
            VStack {
                Text(tradingPrice)
                    .font(.body)
            }
        }
    }
}

struct StockRow_Previews: PreviewProvider {
    static var previews: some View {
        StockRow(symbol: "NASDAQ", description: "Lorem ipsum", tradingPrice: "$12,523.49")
    }
}
