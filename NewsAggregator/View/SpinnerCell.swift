//
//  SpinnerCell.swift
//  NewsAggregator
//
//  Created by Bakhtovar Umarov on 06/07/21.
//

import UIKit

class SpinnerCell: UITableViewCell {

    @IBOutlet weak var spinner: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
