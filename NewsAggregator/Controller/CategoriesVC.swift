//
//  ViewController.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 17/06/21.
//

import UIKit

class CategoriesVC: UIViewController {
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var myCollectionView: UICollectionView!
    
    var category = CategoriesBrain()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureCollectionView()
        configureNavbarAndSearchbar()
    }
}

extension CategoriesVC: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func configureNavbarAndSearchbar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "News by Category"
        self.navigationController!.tabBarItem.title = "Categories"
        searchBar.delegate = self
        searchBar.placeholder = "Search for news"
       //hideKeyboard()
    }
    
    func configureCollectionView(){
        self.myCollectionView.dataSource = self
        self.myCollectionView.delegate = self
        self.myCollectionView.collectionViewLayout = UICollectionViewFlowLayout()
        // register is nedeed for cell (item)
        self.myCollectionView.register(UINib(nibName: "CategoryCell", bundle: nil), forCellWithReuseIdentifier: "CategoryCell")
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return category.cat.count
    }
    //draw ans assign properties
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CategoryCell", for: indexPath) as! CategoryCell
        
        let categoryName = category.cat[indexPath.row]
        cell.backgroundColor = categoryName.background
        cell.categoryLabel.text = categoryName.nameLabel
        cell.layer.cornerRadius = 10
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
    //navigation on tapping
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let tappedCategory = category.cat[indexPath.row]
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "CategoryVC") as! CategoryVC
        
        vc.titleName = tappedCategory.nameLabel
        vc.urlString = tappedCategory.url
        vc.labelText = searchBar.text
       
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension CategoriesVC: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        let searchText = searchBar.text!
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "CategoryVC") as! CategoryVC
       
        vc.labelText = searchText
        self.navigationController?.pushViewController(vc, animated: true)


//        if vc.articles == nil  {
//            vc.labelText = "No Results for \(searchText)"
//            self.navigationController?.pushViewController(vc, animated: true)
//
//        } else {
//            vc.labelText = "Results for \(searchText)"
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
        
    }
    
    func searchBarShouldEndEditing(_ searchBar: UISearchBar) -> Bool {
        if searchBar.text != "" {
            return true
        } else {
            searchBar.placeholder = "Enter a search phrase"
            return false
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print("\(searchText) search")
    }
    

}

    
