//
//  CategoryItem.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 17/06/21.
//

import Foundation
import UIKit

let cons = K()

struct Categories {
    let nameLabel: String
    let background: UIColor
    let url: String
   
}

struct CategoriesBrain {
    var cat = [Categories(nameLabel: "General", background: #colorLiteral(red: 0, green: 0.6384097938, blue: 0.5209903847, alpha: 1), url: cons.generalURL),
               Categories(nameLabel: "Business", background: #colorLiteral(red: 0.7960784314, green: 0.8862745098, blue: 0.6901960784, alpha: 1),url: cons.businessURL),
               Categories(nameLabel: "Science", background: #colorLiteral(red: 1, green: 0.6392156863, blue: 0.3019607843, alpha: 1), url: cons.scienceURL),
               Categories(nameLabel: "Technology", background: #colorLiteral(red: 0.9647058824, green: 0.4588235294, blue: 0.4588235294, alpha: 1), url: cons.techURL),
               Categories(nameLabel: "Health", background: #colorLiteral(red: 1, green: 0.9215686275, blue: 0.6, alpha: 1), url: cons.healthURL),
               Categories(nameLabel: "Entertainment", background: #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1), url: cons.entertainmentURL),
               Categories(nameLabel: "Sports", background: #colorLiteral(red: 0.4980392157, green: 0.4705882353, blue: 0.8235294118, alpha: 1), url: cons.sportsURL)]
}



