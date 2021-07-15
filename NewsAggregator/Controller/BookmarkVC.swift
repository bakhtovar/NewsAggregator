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
    var articles: [NSManagedObject] = []

    @IBOutlet weak var table: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        table.delegate = self
        table.dataSource = self
        
        table.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "articleCell")
        table.register(UINib(nibName: "SpinnerCell", bundle: nil), forCellReuseIdentifier: "SpinnerCell")
    }
    

    
    // MARK: - Navigation

    

    
}

extension BookmarkVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
      
        return cell
    }
    
    
}
