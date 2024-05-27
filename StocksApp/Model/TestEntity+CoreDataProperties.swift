//
//  TestEntity+CoreDataProperties.swift
//  StocksApp
//
//  Created by Нурбол Мухаметжан on 16.05.2024.
//
//

import Foundation
import CoreData


extension TestEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<TestEntity> {
        return NSFetchRequest<TestEntity>(entityName: "TestEntity")
    }

    @NSManaged public var companyName: String?
    @NSManaged public var isFavourite: Bool
    @NSManaged public var logo: Data?
    @NSManaged public var ticker: String?

}

extension TestEntity : Identifiable {

}
