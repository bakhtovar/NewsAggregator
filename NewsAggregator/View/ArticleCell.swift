//
//  ArticleCell.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 18/06/21.
//

import UIKit

class ArticleCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var urlLabel: UILabel!
    @IBOutlet weak var imageIcon: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        

    }
    
}
