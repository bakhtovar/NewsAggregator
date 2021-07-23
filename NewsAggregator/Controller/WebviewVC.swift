//
//  WebviewVC.swift
//  NewsAggregator

//  Created by Bakhtovar Umarov on 25/06/21.
//

import UIKit
import WebKit
import CoreData

class WebviewVC: UIViewController, WKNavigationDelegate, WKUIDelegate {
    
    var articles: Articles?
    var url: String? = nil
    var titleName: String? = nil
    var sourceName : String? = nil
    var urlImage : String? = nil
    var activityIndicator = UIActivityIndicatorView()
    @IBOutlet weak var webView: WKWebView!
    @IBOutlet weak var bookmarkButton: UIBarButtonItem!
    
    var bookmarks = [Bookmarks]()
    
    let context = (UIApplication.shared.delegate as!
                    AppDelegate).persistentContainer.viewContext
    
    let saveContent = (UIApplication.shared.delegate as!
                AppDelegate).saveContext()
    override func viewDidLoad() {
    
        
        super.viewDidLoad()
        print(NSSearchPathForDirectoriesInDomains(.applicationSupportDirectory, .userDomainMask, true).last! as String)
        print("- - - - - - - - - - - ")
        webView.navigationDelegate = self
        webView.uiDelegate = self

        navigationController?.navigationBar.prefersLargeTitles = false

        view.addSubview(webView)
        
      //  let image = UIImage(named: "bookmark") as UIImage?
       //bookmarkButton.setBackgroundImage(image, for: .normal, barMetrics: .default)
        
        activityIndicator.color = .red
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        
        view.addSubview(activityIndicator)
 
        guard let request = URL(string: url ?? "https://www.google.com") else {
            return
        }
    
        webView.load(URLRequest(url: request))
    
        
//        var allData = [NSObject]()
//
//        let fetchRequest: NSFetchRequest<Bookmarks> = Bookmarks.fetchRequest()
//     //   let fetchRequest = NSFetchRequest<Bookmarks>(entityName: "Bookmarks")
//       // let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users");
//        do {
//            let bookmarks = try PersistenceService.persistentContainer.viewContext.fetch(fetchRequest)
//            allData = bookmarks as [NSManagedObject]
//            self.bookmarks = bookmarks
//        } catch {}
//
//
//        print(bookmarks)
    }
    
    @IBAction func buttonClicked(_ sender: UIBarButtonItem) {
        
        let bookmark = Bookmarks(context: context)
        bookmarkButton.setBackgroundImage(UIImage(named: "avatar"), for: .normal, barMetrics: .default)
        bookmark.urlToImage = urlImage
        bookmark.source = sourceName
        bookmark.titleName = titleName
        bookmark.urlLink = url
        bookmarks.append(bookmark)
      
        do {
            try context.save()
        } catch {
            
        }
        
        
        //PersistenceService.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        
    }
    
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        webView.frame = view.bounds
    }

    func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            activityIndicator.isHidden = false
            activityIndicator.startAnimating()
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            activityIndicator.stopAnimating()
            activityIndicator.isHidden = true
        }
    
    
}
