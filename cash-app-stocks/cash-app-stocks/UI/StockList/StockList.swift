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
        // 3. Format currency cents to dollars.cents with currency symbol

        switch viewModel.stockListUIState {
            case .success(let stockViewModels) :
            List(stockViewModels, id:\.stock.id) { stockViewModel in
                    NavigationLink {
                        StockDetail(stock: stockViewModel.stock)
                    } label: {
                        StockRow(stock: stockViewModel.stock)
                    }
                }
            case .error(let error):
                ErrorView(error: error, retryAction: viewModel.reloadStocks)
            case .loading:
                ActivityIndicator()
                .frame(width: 200, height: 200)
            case .noData:
            EmptyState(retryAction: viewModel.reloadStocks)
        }
    }
}

struct StockList_Previews: PreviewProvider {
    static var previews: some View {
        StockList()
    }
}
