import Foundation

struct CellModel: Decodable {
    let logo: String
    let ticker: String
    let name: String
    var isFavourite: Bool?
}

extension CellModel {
    
    func fetchData(){
        
    }

    func performRequest(with urlString: String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url){ data, error,response in
                if error != nil {
                    print(error!)
                }
                
                if let safeData = data{
                    if let cellModel = parseJson(data: safeData){
                        
                    }
                }
                
            }
        }
    }
    
    func parseJson( data: Data) -> CellModel? {
        let decoder = JSONDecoder()
        do{
            let decodedData = try decoder.decode(CellData.self, from: data)
            let cellModel = try CellModel(from: decodedData as! Decoder)
            return cellModel
        }catch{
            return nil
        }
    }
    
    static func readJSONFile() -> [String: CellModel]? {
        let tickerList: [String] = ["AAPL", "FB", "AMZN", "TSLA", "V", "MA", "NFLX", "DIS", "EA", "WAT", "NVDA", "MSFT" ]
        guard let url = Bundle.main.url(forResource: "stockProfiles", withExtension: "json") else {
            print("File not found.")
            return nil
        }
        
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            let cellModels = try decoder.decode([CellModel].self, from: data)
            
            var dictionary = [String: CellModel]()
            
            for ticker in tickerList{
                for cellModel in cellModels{
                    if( ticker == cellModel.ticker){
                        dictionary[ticker] = cellModel
                    }
                }
            }
            return dictionary
        } catch {
            print("Failed to load data from JSON. Error: \(error)")
            return nil
        }
    }
    
}
