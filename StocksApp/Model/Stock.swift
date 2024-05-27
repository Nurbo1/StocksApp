import Foundation

struct Stock: Decodable {
    let logo: String
    let ticker: String
    let name: String
    
    static func readStockFile() -> [Stock]? {
        let tickerList: [String] = ["AAPL", "FCX", "AMZN", "TSLA", "V", "MA", "NFLX", "DIS", "EA", "NVDA", "MSFT" ]
        guard let url = Bundle.main.url(forResource: "stockProfiles", withExtension: "json") else {
            print("File not found.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let cellModels = try decoder.decode([Stock].self, from: data)
            
            var array = [Stock]()
            for ticker in tickerList{
                for i in cellModels{
                    if ticker == i.ticker{
                        array.append(i)
                    }
                }
            }
//            for i in 15..<30{
//                array.append(cellModels[i])
//            }
            
            print("Data from file was loaded succesfully")
            
            return array
            
        } catch {
            print("Failed to load data from JSON. Error: \(error)")
            return nil
        }
    }
}
