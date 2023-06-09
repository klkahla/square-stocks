//
//  StockApp.swift
//  cash-app-stocks
//
//  Created by Katy Kahla on 6/9/23.
//

import SwiftUI

struct StockApp: View {
    var body: some View {
        NavigationView {
            StockList()
            .navigationTitle("Stocks")
            .navigationBarTitleDisplayMode(.inline)
        }
        
    }
}

struct StockApp_Previews: PreviewProvider {
    static var previews: some View {
        StockApp()
    }
}
