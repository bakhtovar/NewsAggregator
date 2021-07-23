//
//  Bookmarks+CoreDataProperties.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 22/07/21.
//
//

import Foundation
import CoreData


extension Bookmarks {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Bookmarks> {
        return NSFetchRequest<Bookmarks>(entityName: "Bookmarks")
    }

    @NSManaged public var source: String?
    @NSManaged public var titleName: String?
    @NSManaged public var urlLink: String?
    @NSManaged public var urlToImage: String?

}

extension Bookmarks : Identifiable {

}
