//
//  CategoryVc.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 18/06/21.
//

import Foundation
import UIKit
import SkeletonView
import Kingfisher


class CategoryVC: UIViewController  {
    
    var articles: Articles?
    var titleName: String?
    var urlString: String?
    var sourceId : String?
    var labelText: String?
 
   
    @IBOutlet weak var myTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        
        myTableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "articleCell")
        
        title = titleName
        
        print("\(labelText) this is text")
        
        
        
        myTableView.isSkeletonable = true
        myTableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .emerald), animation: nil, transition: .crossDissolve(0.25))
        myTableView.startSkeletonAnimation()
 
        myTableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .emerald), animation: nil, transition: .crossDissolve(0.25))
        
        
        let catPass = PassUrl(categoryName: titleName ?? "", id: sourceId, searchText: labelText)
      
    
    //MARK: - dkldkldkldflkfdkldfklfdkldfkl
        APICall.shared.fetchData(category: catPass) { (response) in
                DispatchQueue.main.async {
                self.articles = response
                self.myTableView.reloadData()
                self.myTableView.stopSkeletonAnimation()
                self.myTableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                }
        }
    }
}

extension CategoryVC: UITableViewDelegate, SkeletonTableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.articles.count ?? 10
        
    }

    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles?.articles.count ?? 10
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "articleCell" 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "articleCell", for: indexPath) as! ArticleCell
        
        if let article = articles?.articles[indexPath.row] {
            cell.titleLabel.text = article.title
            cell.urlLabel.text = article.source.name
            cell.imageIcon.kf.indicatorType = .activity
            if let image = URL(string: article.urlToImage ?? "") {
                cell.imageIcon.kf.setImage(with: image, placeholder: nil)
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "WebviewVC") as! WebviewVC
        vc.url = articles?.articles[indexPath.row].url
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}






