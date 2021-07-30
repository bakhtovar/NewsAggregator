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
    var messageLabel: UILabel?
    
    
    @IBOutlet weak var table: UITableView!
    
    let context = (UIApplication.shared.delegate as!
                    AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Bookmarks"
        table.delegate = self
        table.dataSource = self
        table.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "articleCell")
        
    }
    
    // MARK: - NAVIGATION
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<Bookmarks> = Bookmarks.fetchRequest()
        do {
            let bookmarks = try context.fetch(fetchRequest)
            self.bookmarks = bookmarks
            table.reloadData()
        } catch {}
    }

    override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            fetchData()
        }
}


extension BookmarkVC: UITableViewDelegate,  UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if self.bookmarks.count > 0 {
            table.backgroundView = nil
            return self.bookmarks.count
           } else {
            print(bookmarks.count)
            print("fff")
            let emptyLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.view.bounds.size.width, height: self.view.bounds.size.height))
            emptyLabel.text = "There is no bookmark added."
            emptyLabel.textAlignment = NSTextAlignment.center
            self.table.backgroundView = emptyLabel
            self.table.separatorStyle = UITableViewCell.SeparatorStyle.none
            return 0
           }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
       
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        
        let article = bookmarks[indexPath.row]
        if article.urlToImage == nil {
            cell.imageIcon.isHidden = true
            cell.imageWidth.constant = 0
        }
        
        cell.titleLabel.text = article.titleName
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
        vc.titleName = bookmarks[indexPath.row].titleName
        vc.urlImage = bookmarks[indexPath.row].urlToImage
        vc.sourceName = bookmarks[indexPath.row].source
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath){
        if(editingStyle == UITableViewCell.EditingStyle.delete){
            let personToRemove = self.bookmarks[indexPath.row]
            self.context.delete(personToRemove)
            
            do {
                try self.context.save()
            } catch {

            }
            self.fetchData()
            
        }
    }
}


