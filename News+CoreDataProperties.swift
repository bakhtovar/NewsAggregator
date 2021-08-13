//
//  News+CoreDataProperties.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 12/08/21.
//
//

import Foundation
import CoreData


extension News {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<News> {
        return NSFetchRequest<News>(entityName: "News")
    }

    @NSManaged public var idButton: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var linkUrl: String?
    @NSManaged public var sourceName: String?
    @NSManaged public var titleName: String?

}

extension News : Identifiable {

}
