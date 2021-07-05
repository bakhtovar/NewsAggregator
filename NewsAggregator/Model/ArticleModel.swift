//
//  ArticleModel.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 18/06/21.
//

import Foundation
import UIKit

struct Articles: Codable {
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String?
    let description: String?
    let url : String?
    let urlToImage: String?
    
}

struct Source: Codable {
    let id: String?
    let name: String?
}



