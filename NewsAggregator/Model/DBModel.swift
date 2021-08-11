// DBModel.swift
// NewsAggregator
//
// Created by Bakhtovar Umarov on 09/08/21.
//
import Foundation
import UIKit
import CoreData
class CategoryDBModel: NSManagedObject {
  @NSManaged var articeModel: [ArticleDBModel]
    var news = [News]()
    
  func saveUserData(_ title:String, urls:String, imageURL:String, source:String) {
    let context = (UIApplication.shared.delegate as!
            AppDelegate).persistentContainer.viewContext
      let newArticle = NSEntityDescription.insertNewObject(forEntityName: "News", into: context)
      newArticle.setValue(urls, forKey: "linkUrl")
      newArticle.setValue(imageURL, forKey: "imageUrl")
      newArticle.setValue(title, forKey: "titleName")
      newArticle.setValue(source, forKey: "sourceName")
    do {
      try context.save()
      print("Success")
    } catch {
      print("Error saving: \(error)")
    }
  }
//
//    func fetchData() {
//    let context = (UIApplication.shared.delegate as!
//            AppDelegate).persistentContainer.viewContext
//      let fetchRequest: NSFetchRequest<News> = News.fetchRequest()
//      do {
//        let news = try context.fetch(fetchRequest)
//        self.news = news
//       // print(self.news)
//
//      } catch {}
//    }
    
 
    
}
class ArticleDBModel: NSManagedObject {
  @NSManaged public var linkUrl: String?
  @NSManaged public var imageUrl: String?
  @NSManaged public var titleName: String?
  @NSManaged public var sourceName: String?
}
