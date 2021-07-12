//
//  SourceModel.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 28/06/21.
//

import Foundation

struct Sources: Codable {
    var sources: [SourceModel] 
}

struct SourceModel: Codable {
    let id: String?
    let name: String?
    let category: String?
}

