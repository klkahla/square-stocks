//
//  Stock.swift
//  cash-app-stocks
//
//  Created by Katy Kahla on 6/6/23.
//

import Foundation

struct StockResponse: Decodable {
    let stocks: [Stock]
}

struct Stock: Decodable, Identifiable {
    let id = UUID()
    var ticker: String
    var name: String
    var currency: String
    var currentPriceCents: Int 
    var quantity: Int?
    var currentPriceTimestamp: Int
}


