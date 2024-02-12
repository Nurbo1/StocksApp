//
//  Model.swift

//  StocksApp
//
//  Created by Нурбол Мухаметжан on 25.01.2024.
//

import Foundation

struct CellData:Codable{
    let logo: String
    let ticker: String
    let companyName: String
    let price: String
    let dayDelta: String
    var isFavourite: Bool
}


