//
//  DBModel.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 09/08/21.
//

import Foundation
import UIKit
import CoreData


class CategoryDBModel: NSManagedObject {
   @NSManaged var articeModel: [ArticleDBModel]
}


class ArticleDBModel: NSManagedObject {
    @NSManaged public var linkUrl: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var titleName: String?
    @NSManaged public var sourceName: String?
   // your all attributes
}

func saveUserData(_ articles: [News]) {
    let context = (UIApplication.shared.delegate as!
                    AppDelegate).persistentContainer.viewContext
    
    for article in articles {
        let newArticle = NSEntityDescription.insertNewObject(forEntityName: "News", into: context)
        newArticle.setValue(article.linkUrl, forKey: "linkUrl")
        newArticle.setValue(article.imageUrl, forKey: "imageUrl")
        newArticle.setValue(article.titleName, forKey: "titleName")
        newArticle.setValue(article.sourceName, forKey: "sourceName")
        
    }
    do {
        try context.save()
    } catch {
        print("Error saving: \(error.localizedDescription)")
    }
}
