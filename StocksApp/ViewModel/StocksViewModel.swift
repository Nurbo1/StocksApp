//
//  StocksViewModel.swift
//  StocksApp
//
//  Created by Нурбол Мухаметжан on 29.04.2024.
//

import Foundation
import UIKit
import CoreData

struct WebCellData{
    var price: String = ""
    var dayDelta: String = ""
    var image: UIImage = UIImage()
}

class StocksViewModel{
    
    let service  = StockService()
    
    var dict: [String:WebCellData] = [:]
    
    let coreData = CoreDataManager()
    
    let group = DispatchGroup()
    
    func getStockData(stockArray: [Stock], completion: @escaping ([String: CellData])->Void){
        var celldata = [String: CellData]()
        
        for stock in stockArray {
            dict[stock.ticker] = WebCellData()
            group.enter()
            if let stockMO = coreData.fetchStockFromCoreData(with: stock.ticker) {
                print("Fetching from CoreData")
                let logoImage = UIImage(data: stockMO.logo ?? Data())
                celldata[stock.ticker] = CellData(logo: logoImage ?? UIImage(),
                                                  ticker: stockMO.ticker ?? "",
                                                  companyName: stockMO.companyName ?? "",
                                                  price: "0.00",
                                                  dayDelta: "0.00",
                                                  isFavourite: stockMO.isFavourite)
                group.leave()
            } else {
                print("Fetching from the web")
                //                dict[stock.ticker] = WebCellData()
                group.enter()
                fetchImages(with: stock.logo, ticker: stock.ticker){
                    self.group.leave()
                }
            }
            group.enter()
            fetchPriceFromApi(with: stock.ticker){
                self.group.leave()
            }
        }
        
        group.notify(queue: .main) {
            for stock in stockArray {
                celldata[stock.ticker] = CellData(
                    logo: celldata[stock.ticker]?.logo ?? self.dict[stock.ticker]?.image ?? UIImage(),
                    ticker: stock.ticker,
                    companyName: stock.name,
                    price: self.dict[stock.ticker]?.price ?? "",
                    dayDelta: self.dict[stock.ticker]?.dayDelta ?? "",
                    isFavourite: celldata[stock.ticker]?.isFavourite ?? false)
            }
            completion(celldata)
        }
    }
    
    
    func fetchPriceFromApi(with symbol: String, completion: @escaping () -> Void) {
        DispatchQueue.global().async {
            self.service.fetchStockPrice(with: symbol) { price, daydelta in
                if var data = self.dict[symbol] {
                    data.price = price
                    data.dayDelta = daydelta
                    self.dict[symbol] = data
                }
                completion()
            }
        }
    }
    
    func fetchImages(with url: String,ticker:String, completion: @escaping () -> Void){
        DispatchQueue.global().async {
            self.service.fetchImages(with: url) { image in
                self.dict[ticker]?.image = image
                completion()
            }
        }
    }
}
