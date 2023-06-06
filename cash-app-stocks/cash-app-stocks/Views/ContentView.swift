//
//  ContentView.swift
//  cash-app-stocks
//
//  Created by Katy Kahla on 6/5/23.
//

import SwiftUI

struct StockList: View {
    var stocks: [Stock] = []
    var body: some View {
        // TODO:
        // 1. Stock list
        // 2. Network call
        // 3. Error states
        // 4. Format currency cents to dollars.cents with currency symbol
        
        // NOTES:
        // 1. For Stock, is this a model for the api call or a view model?
        
        Text("Stocks")
            .font(.title)
        List(stocks) { stock in
            StockRow(stock: stock)
        }
    }
}

struct StockList_Previews: PreviewProvider {
    static var previews: some View {
        StockList()
    }
}
