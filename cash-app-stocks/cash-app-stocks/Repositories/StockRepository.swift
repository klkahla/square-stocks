//
//  WebRepository.swift
//  cash-app-stocks
//
//  Created by Katy Kahla on 6/6/23.
//

import Foundation
import Combine

protocol StockRepository {
    func loadStocks() -> AnyPublisher<[Stock], Error>
}
