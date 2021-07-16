//
//  BookmarkVC.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 15/07/21.
//

import UIKit
import CoreData

class BookmarkVC: UIViewController {

    var titleName: String?
    var urlString: String?
    var sourceId : String?
    var labelText: String?
    var sourceName: String?
    var bookmarks = [Bookmarks]()
    
    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bookmarks"
        table.delegate = self
        table.dataSource = self
        
        table.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "articleCell")
    
        print(bookmarks)
       
    }
    

    
    // MARK: - Navigation

    func fetchData() {
        var allData = [NSObject]()
        
        let fetchRequest: NSFetchRequest<Bookmarks> = Bookmarks.fetchRequest()
     //   let fetchRequest = NSFetchRequest<Bookmarks>(entityName: "Bookmarks")
       // let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Users");
        do {
            let bookmarks = try PersistenceService.persistentContainer.viewContext.fetch(fetchRequest)
            allData = bookmarks as [NSManagedObject]
            self.bookmarks = bookmarks
            table.reloadData()
        } catch {}
    }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
          fetchData()
        }
}


extension BookmarkVC: UITableViewDelegate, UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return bookmarks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        
        let article = bookmarks[indexPath.row]
        if article.urlToImage == nil {
            cell.imageIcon.isHidden = true
            cell.imageWidth.constant = 0
        }
        
        cell.titleLabel.text = article.tittleName
        cell.urlLabel.text = article.source
        cell.imageIcon.kf.indicatorType = .activity
        
        if let image = URL(string: article.urlToImage ?? "") {
            cell.imageIcon.kf.setImage(with: image, placeholder: nil)
        }
      
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "WebviewVC") as! WebviewVC
        vc.url = bookmarks[indexPath.row].urlLink
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}


