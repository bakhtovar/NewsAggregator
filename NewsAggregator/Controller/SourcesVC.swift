//
//  SourcesVC.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 17/06/21.
//

import Foundation
import UIKit
import SkeletonView

class SourcesVC: UIViewController {
    
    @IBOutlet weak var sourcesSearch: UISearchBar!
    @IBOutlet weak var sourcesCollectionView: UICollectionView!
    
    var category = CategoriesBrain()
    
    var sources: Sources?
    
    var filteredData: Sources?
    var sourceName : String?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavbarAndSearchBar()
        configureCollectionView()
    
        APICall.shared.getSources { (response) in
            DispatchQueue.main.async {
                self.sources = response
                self.filteredData = response
                self.sourcesCollectionView.reloadData()
            }
        }
        
    }
    
    func configureCollectionView() {
        self.sourcesCollectionView.dataSource = self
        self.sourcesCollectionView.delegate = self
        self.sourcesCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        self.sourcesCollectionView.register(UINib(nibName: "SourcesCell", bundle: nil), forCellWithReuseIdentifier: "SourcesCell")
    }
    
    func configureNavbarAndSearchBar () {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "News by Sources"
        self.navigationController!.tabBarItem.title = "Sources"
        sourcesSearch.delegate = self
        sourcesSearch.placeholder = "Find sources"
    }
}

extension SourcesVC :
    UICollectionViewDataSource,
    UICollectionViewDelegate,
    UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sources?.sources.count ?? 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SourcesCell", for: indexPath) as! SourcesCell
        let vc = sources?.sources[indexPath.row]
        cell.sourceTitleLabel.text = vc?.name
        cell.categoryTittleLabel.text = vc?.category?.capitalized
        
        switch cell.categoryTittleLabel.text?.lowercased() {
        case "general":
            cell.rombCell.backgroundColor = #colorLiteral(red: 0, green: 0.6384097938, blue: 0.5209903847, alpha: 1)
        case "business":
            cell.rombCell.backgroundColor = #colorLiteral(red: 0.7960784314, green: 0.8862745098, blue: 0.6901960784, alpha: 1)
        case "science":
            cell.rombCell.backgroundColor = #colorLiteral(red: 1, green: 0.6392156863, blue: 0.3019607843, alpha: 1)
        case "technology":
            cell.rombCell.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.4588235294, blue: 0.4588235294, alpha: 1)
        case "health":
            cell.rombCell.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.4588235294, blue: 0.4588235294, alpha: 1)
        case "entertainment":
            cell.rombCell.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.4588235294, blue: 0.4588235294, alpha: 1)
        case "sports":
            cell.rombCell.backgroundColor = #colorLiteral(red: 0.4980392157, green: 0.4705882353, blue: 0.8235294118, alpha: 1)
        default:
            cell.rombCell.backgroundColor = .lightGray
            
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding:CGFloat = 20
        let space: CGFloat = 10
        let itemWidth = (collectionView.bounds.width) - (padding * 2) - space
        let getWidth = itemWidth/2
        
        return CGSize(width: getWidth, height: getWidth)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tappedCategory = sources?.sources[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(identifier: "CategoryVC") as! CategoryVC
        vc.titleName = tappedCategory?.name
        vc.sourceId = tappedCategory?.id
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SourcesVC: UISearchBarDelegate {
    
    
    
}
