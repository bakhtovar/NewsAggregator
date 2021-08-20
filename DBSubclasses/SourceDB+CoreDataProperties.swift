//
//  SourceDB+CoreDataProperties.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 18/08/21.
//
//

import Foundation
import CoreData


extension SourceDB {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<SourceDB> {
        return NSFetchRequest<SourceDB>(entityName: "SourceDB")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var category: String?

}

extension SourceDB : Identifiable {

}
