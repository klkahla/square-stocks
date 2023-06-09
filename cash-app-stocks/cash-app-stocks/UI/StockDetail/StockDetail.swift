//
//  StockDetail.swift
//  cash-app-stocks
//
//  Created by Katy Kahla on 6/9/23.
//

import SwiftUI

struct StockDetail: View {
    var stock: Stock
    
//    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        let stockDetailViewModel = StockDetailViewModel(stock: stock)

        VStack (spacing: 16) {
            StockRow(stock: stock)
            
            if stock.quantity != nil {
                PortfolioDetails(quantity: stockDetailViewModel.quantity, currentValue: stockDetailViewModel.currentValue)
            }
            
            Spacer()
            
            // TODO:
            // Buy button
            // Sell button (if quantity available)
            
            Text("Last updated: \(stockDetailViewModel.lastUpdated)")
                .font(.caption)
            
        }
        .padding()
    }
}

struct ButtonView: View {
    var body: some View {
        Button(action: {
            // TODO: Handle buy button action
        }) {
            Text("Buy")
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
        }
        
//        if stock.quantity != nil {
//            Button(action: {
//                // TODO: Handle sell button action
//            }) {
//                Text("Sell")
//                    .frame(maxWidth: .infinity)
//                    .padding()
//                    .background(Color.red)
//                    .foregroundColor(.white)
//                    .cornerRadius(8)
//            }
//        }
    }
}

struct PortfolioDetails: View {
    var quantity: String
    var currentValue: String
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Current Value")
                .font(.headline)
            Text(currentValue)
            
            Text("Quantity")
                .font(.headline)
            Text(quantity)
            
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        
    }
}

struct StockDetail_Previews: PreviewProvider {
    static var previews: some View {
        StockDetail(stock: Stock(ticker: "APPL", name: "Apple", currency: "USD", currentPriceCents: 318157, quantity: 5, currentPriceTimestamp: 1681845832))
    }
}
