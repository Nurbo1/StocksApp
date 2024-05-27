//
//  StockService.swift
//  StocksApp
//
//  Created by Нурбол Мухаметжан on 29.04.2024.
//

import Foundation
import UIKit

struct forJson:Decodable{
    let c:Float?
    let dp:Float?
}

class StockService{
    let baseURL = "https://finnhub.io/api/v1/quote"
    let apiKey = "cl6pt11r01qvncka4b80cl6pt11r01qvncka4b8g"
    
    var price: String = ""
    var daydelta: String = ""
    
    func fetchStockPrice(with symbol: String, completion: @escaping(String, String) -> Void){
        let urlString = "\(baseURL)?symbol=\(symbol)&token=\(apiKey)"
        guard let url = URL(string: urlString) else{
            print("DEBUG: Error in urlString ")
            return
        }
        
        URLSession.shared.dataTask(with: url, completionHandler: { data, response, error in
            
            if let error = error{
                print("DEBUG: Error in: \(error)")
                return
            }
            
            guard let data = data else{
                print("DEBUG: Error in data retrieval")
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(forJson.self, from: data)
                self.price =   String(format: "%.2f", decodedData.c ?? 0) // "\(decodedData.c ?? 0)"
                self.daydelta =  String(format: "%.2f", decodedData.dp ?? 0) //"\(decodedData.dp ?? 0)"
                completion("\(self.price)", "\(self.daydelta)")
            }catch{
                print("Failed to load data from JSON API. Error: \(error)")
            }
            
        }).resume()
    }
    
    func fetchImages(with urlString: String, completion: @escaping(UIImage) -> Void){
        
        guard let url = URL(string: urlString) else{
            print("DEBUG: Error in urlString ")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in

            if let error = error{
                print("DEBUG: Error in: \(error)")
                return
            }
            
            guard let data = data else{
                print("DEBUG: Error in data retrieval")
                return
            }
            
            if let image = UIImage(data: data){
                completion(image)
            }else{
                completion(UIImage())
            }
            
        }.resume()
    }
    
}
