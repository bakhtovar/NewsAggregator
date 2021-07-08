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
    var pageNumber: Int = 1
    var sourceName: String?
    
    
    var catPass: PassUrl!
    
    var spinner = UIActivityIndicatorView()
    
    // var current = 1
    var total = 4
    
    
    
    @IBOutlet weak var myTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        myTableView.delegate = self
        myTableView.dataSource = self
        
        
        myTableView.register(UINib(nibName: "ArticleCell", bundle: nil), forCellReuseIdentifier: "articleCell")
        myTableView.register(UINib(nibName: "SpinnerCell", bundle: nil), forCellReuseIdentifier: "SpinnerCell")
        if titleName != nil {
            self.title = titleName
        } else {
            self.title = sourceName
        }
        
        
        myTableView.isSkeletonable = true
        myTableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .emerald), animation: nil, transition: .crossDissolve(0.25))
        myTableView.startSkeletonAnimation()
        
        myTableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .emerald), animation: nil, transition: .crossDissolve(0.25))
        
        
        catPass = PassUrl(categoryName: titleName ?? "", id: sourceId, searchText: labelText, pageInt: pageNumber)
        
        
        //MARK: - dkldkldkldflkfdkldfklfdkldfkl
        APICall.shared.fetchData(category: catPass) { (response) in
            DispatchQueue.main.async {
                self.articles = response
                self.myTableView.reloadData()
                self.myTableView.stopSkeletonAnimation()
                self.myTableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                if self.labelText != "" && self.sourceName == nil && self.titleName == nil {
                    if self.articles?.articles.count == 0 {
                        self.title = "No results for \(self.labelText ?? "")"
                    } else if self.articles?.articles.count != 0  {
                        self.title = "Results for \(self.labelText ?? "")"
                    }
                }
                // let lastItem = (self.articles?.articles.count ?? 2) - 1
                //print("\(lastItem) = last")
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
       
        if  pageNumber < total && indexPath.row + 1 == (articles?.articles.count ?? 2) && articles?.articles.count ?? 2 >= 19 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SpinnerCell", for: indexPath) as! SpinnerCell
            return cell
        } else {
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
        
    }
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastItem = (articles?.articles.count ?? 2)
        print(pageNumber)
        
        if  pageNumber < total && indexPath.row + 1 == lastItem && articles?.articles.count ?? 2 >= 19 {
            
            pageNumber += 1
            
            catPass = PassUrl(categoryName: titleName ?? "", id: sourceId, searchText: labelText, pageInt: pageNumber)

            APICall.shared.fetchData(category: catPass) { (response) in
                DispatchQueue.main.async {
                    self.articles?.articles.append(contentsOf: response.self.articles)
                    self.myTableView.reloadData()
                }
            }
        }
      
        // print(pageNumber)
    }
    //
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //
    //        let lastItem = (articles?.articles.count ?? 2) - 1
    //
    //        if lastItem == indexPath.row {
    //
    //            if pageNumber < 100 {
    //                pageNumber += 1
    //
    //                DispatchQueue.main.asyncAfter(deadline: .now() + 10) {
    //                    self.catPass = PassUrl(categoryName: self.titleName ?? "", id: self.sourceId, searchText: self.labelText, pageInt: self.pageNumber)
    //
    //                    APICall.shared.fetchData(category: self.catPass) { (response) in
    //                    DispatchQueue.main.async {
    //                        self.articles = response
    //                        self.myTableView.reloadData()
    //                    }
    //                }
    //
    //                }
    //
    //            }
    //        }
    //    }
    
    
//            func scrollViewDidScroll(_ scrollView: UIScrollView) {
//                let position = scrollView.contentOffset.y
//                if position > (myTableView.contentSize.height - 100 - scrollView.frame.size.height) {
//                           // print(lastItem)
//                    if pageNumber < total   {
//                    pageNumber += 1
//                    catPass = PassUrl(categoryName: titleName ?? "", id: sourceId, searchText: labelText, pageInt: pageNumber)
//
//                    APICall.shared.fetchData(category: catPass) { (response) in
//                        DispatchQueue.main.async {
//                            self.articles?.articles.append(contentsOf: response.self.articles)
//                            self.myTableView.reloadData()
//                        }
//                    }
//                          }
//
//                }
//
//            }
//
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





