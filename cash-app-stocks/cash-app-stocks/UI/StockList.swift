//
//  ContentView.swift
//  cash-app-stocks
//
//  Created by Katy Kahla on 6/5/23.
//

import SwiftUI

struct StockList: View {
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        // TODO:
        // a. Dependency injection container
        // 1. Loading & error (with retry button) states
        // 1a. Empty state
        // 2. Tests
        // 3. Format currency cents to dollars.cents with currency symbol
        
        
        Text("Stocks")
            .font(.title)
        switch viewModel.stockListUIState {
            case .success(let stockViewModels) :
                List(stockViewModels, id:\.symbol) { stockViewModel in
                    StockRow(stockViewModel: stockViewModel)
                }
            case .error(let error):
                ErrorView(error: error, retryAction: viewModel.reloadStocks)
            case .loading:
                // TODO: Should I show a spinner?
                EmptyState()
            case .noData:
                // TODO: Empty state
                EmptyState()
        }
    }
}

struct StockList_Previews: PreviewProvider {
    static var previews: some View {
        StockList()
    }
}
