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
    let saveContent: () = (UIApplication.shared.delegate as!
                            AppDelegate).saveContext()
    override func viewDidLoad() {
        
        fetchData()
        
        super.viewDidLoad()
        webView.navigationDelegate = self
        webView.uiDelegate = self
       
        
  
        navigationController?.navigationBar.prefersLargeTitles = false
        
        view.addSubview(webView)
        
        activityIndicator.color = .red
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.isHidden = true
        
        view.addSubview(activityIndicator)
        
        guard let request = URL(string: url ?? "text") else {
            return
        }
        
        webView.load(URLRequest(url: request))
        
    }
    func fetchData() {
        
        let fetchRequest: NSFetchRequest<Bookmarks> = Bookmarks.fetchRequest()
        
        if (fetchRequest.predicate == NSPredicate(format: "titleName == %@", titleName ?? "" )) {
            bookmarkButton.image = UIImage(systemName: "bookmark.fill")
        }
        do {
            let bookmarks = try context.fetch(fetchRequest)
            self.bookmarks = bookmarks
            
        } catch {}
    }
    
    
    @IBAction func buttonClicked(_ sender: UIBarButtonItem) {
        let fetchRequest: NSFetchRequest<Bookmarks> = Bookmarks.fetchRequest()
        let bookmark = Bookmarks(context: context)
     
        if bookmarkButton.image == UIImage(systemName: "bookmark")  {
            bookmarkButton.image = UIImage(systemName: "bookmark.fill")
            bookmark.urlToImage = urlImage
            bookmark.source = sourceName
            bookmark.titleName = titleName
            bookmark.urlLink = url
            print(url)
            print("ffff")
            bookmarks.append(bookmark)
    
        } else {
            bookmarkButton.image = UIImage(systemName: "bookmark")
          
            if fetchRequest.predicate == NSPredicate.init(format: "titleName == %@", titleName!){
                print(bookmark)
                do {
                    let objects = try context.fetch(fetchRequest)
                    for object in objects {
                        context.delete(object)
                    }
                    try context.save()
                } catch _ {
                    // error handling
                }
                
            }
           
        }
        
        do {
            try context.save()
        } catch {

        }
//        print(fetchRequest.predicate == NSPredicate(format: "titleName == %@", titleName!))
//
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
