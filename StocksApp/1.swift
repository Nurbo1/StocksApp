//
//  CellDataManager.swift
//  StocksApp
//
//  Created by Нурбол Мухаметжан on 29.01.2024.
//

import Foundation

struct CellDataManager{
    let baseURL = ""
    let apiKey = "cl6pt11r01qvncka4b80cl6pt11r01qvncka4b8g"
    var stockSymbols = [CellData.self]
}



//import Foundation
//protocol CoinManagerDelegate {
//    func didUpdateCurrency(coinModel:CoinModel)
//    func didFail(error:Error)
//}
//
//struct CoinManager{
//    
//    let baseURL = "https://finnhub.io/api/v1/quote"
//    let apiKey = "cl6pt11r01qvncka4b80cl6pt11r01qvncka4b8g"
//    let stockSymbols = ["AAPL", "MSFT", "AMZN", "GOOGL", "FB", "TSLA", "JNJ", "V", "PG", "JPM"]
//
//    var delegate: CoinManagerDelegate?
//}
//
//extension CoinManager{
//    func fetchData(symbol: String){
//        let urlString = "\(baseURL)?symbol=\(symbol)&token=\(apiKey)"
//        performRequest(with: urlString)
//    }
//    
//    func performRequest(with urlString: String){
//        if let url = URL(string: urlString){
//            let session = URLSession(configuration: .default)
//            let task = session.dataTask(with: url) { data, response, error in
//                if (error != nil) {
//                    print(error!)
//                }
//                
//                if let safeData = data{
//                    if let currency = parseJSON(currencyData: safeData){
//                        delegate?.didUpdateCurrency(coinModel: currency)
//                    }
//                }
//            }
//            task.resume()
//        }
//    }
//    
//    func parseJSON(currencyData: Data) -> CoinModel?{
//        let decoder = JSONDecoder()
//        do{
//            let decodedData = try decoder.decode(CoinData.self, from: currencyData)
//            let currencyModel = CoinModel(currency: decodedData.c)
//            return currencyModel
//        }catch{
//            delegate?.didFail(error: error)
//            return nil
//        }
//    }
//}
