// DBModel.swift
// NewsAggregator
// Created by Bakhtovar Umarov on 09/08/21.

import Foundation
import UIKit
import CoreData

class CategoryDBModel: NSManagedObject {
    @NSManaged var articeModel: [ArticleDBModel]
    
    //    func saveUserData(_ articles: [News]) {
    //        let context = (UIApplication.shared.delegate as!
    //                AppDelegate).persistentContainer.viewContext
    //        for article in articles {
    //                let newArticle = NSEntityDescription.insertNewObject(forEntityName: "News", into: context)
    //            newArticle.setValue(article.idButton, forKey: "idButton")
    //            newArticle.setValue(article.imageUrl, forKey: "imageUrl")
    //            newArticle.setValue(article.linkUrl, forKey: "linkUrl")
    //            newArticle.setValue(article.sourceName, forKey: "sourceName")
    //            newArticle.setValue(article.titleName, forKey: "titleName")
    //            }
    //            do {
    //                try context.save()
    //                print("Success")
    //            } catch {
    //                print("Error saving: \(error)")
    //            }
    //}
    
    func saveUserData(art: ArticleDBModel ) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let newArticle = NSEntityDescription.insertNewObject(forEntityName: "News", into: context) as NSManagedObject
       
//        newArticle.setValue(urls, forKey: "linkUrl")
//        newArticle.setValue(imageURL, forKey: "imageUrl")
//        newArticle.setValue(title, forKey: "titleName")
//        newArticle.setValue(source, forKey: "sourceName")
//        newArticle.setValue(id, forKey: "idButton")
        
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving: \(error)")
        }
        
    }

}

class ArticleDBModel: NSManagedObject {
    @NSManaged public var linkUrl: String?
    @NSManaged public var imageUrl: String?
    @NSManaged public var titleName: String?
    @NSManaged public var sourceName: String?
    @NSManaged public var idButton: String?
}
