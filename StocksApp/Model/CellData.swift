//
//  CellData.swift
//  StocksApp
//
//  Created by Нурбол Мухаметжан on 13.02.2024.
//

import Foundation
import UIKit

struct CellData{
    var logo: UIImage
    var ticker: String = ""
    var companyName: String = ""
    var price: String = ""
    var dayDelta: String = ""
    var isFavourite: Bool = false
}
