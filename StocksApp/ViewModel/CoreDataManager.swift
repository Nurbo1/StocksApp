//
//  CoreDataManager.swift
//  StocksApp
//
//  Created by Нурбол Мухаметжан on 17.05.2024.
//

import Foundation
import CoreData
import UIKit

class CoreDataManager{
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func fetchStockFromCoreData(with symbol: String) -> TestEntity? {
        let fetchRequest: NSFetchRequest<TestEntity> = TestEntity.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "ticker == %@", symbol)
        
        do {
            let stocks = try context.fetch(fetchRequest)
            return stocks.first
        } catch {
            print("Error fetching stock from Core Data: \(error)")
            return nil
        }
    }
    
    func saveStockToCoreData(with cellData: [String: CellData]) {
        guard !cellData.isEmpty else {
            print("No data to save")
            return
        }
        
        for (ticker, cellDataItem) in cellData {
            if fetchStockFromCoreData(with: ticker) != nil {
                updateStockInCoreData(with: ticker, cellDataItem: cellDataItem)
            } else {
                let stockMO = TestEntity(context: self.context)
                stockMO.ticker = ticker
                stockMO.companyName = cellDataItem.companyName
                if let imageData = cellDataItem.logo.jpegData(compressionQuality: 1.0) {
                    stockMO.logo = imageData
                }
                stockMO.isFavourite = cellDataItem.isFavourite
            }
        }
        do {
            try self.context.save()
            print("Saved successfully")
        } catch {
            print("Error saving the data to Core Data: \(error)")
        }
        
    }
    
    func updateStockInCoreData(with ticker: String, cellDataItem: CellData) {
        guard let stockMO = fetchStockFromCoreData(with: ticker) else {
            print("Stock with ticker \(ticker) not found in Core Data.")
            return
        }
        
        stockMO.companyName = cellDataItem.companyName
        if let imageData = cellDataItem.logo.jpegData(compressionQuality: 1.0) {
            stockMO.logo = imageData
        }
        stockMO.isFavourite = cellDataItem.isFavourite
        
        do {
            // Save the changes to Core Data
            try self.context.save()
            print("Stock with ticker \(ticker) updated successfully.")
        } catch {
            print("Error updating stock with ticker \(ticker): \(error)")
        }
    }
    
    func deleteStockFromCoreData(with ticker: String) {
        guard let stockMO = fetchStockFromCoreData(with: ticker) else {
            print("Stock with ticker \(ticker) not found in Core Data.")
            return
        }
        
        // Delete the fetched entity from the context
        context.delete(stockMO)
        
        do {
            // Save the context to persist the deletion
            try self.context.save()
            print("Stock with ticker \(ticker) deleted successfully.")
        } catch {
            print("Error deleting stock with ticker \(ticker): \(error)")
        }
    }
    
    func cleanCoreData() {
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "TestEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(deleteRequest)
            try context.save()
            print("Core Data cleaned successfully.")
        } catch {
            print("Error cleaning Core Data: \(error)")
        }
    }
}
