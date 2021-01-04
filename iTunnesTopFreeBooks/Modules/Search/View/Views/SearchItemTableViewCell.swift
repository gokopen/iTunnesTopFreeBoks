//
//  SearchItemTableViewCell.swift
//  iTunnesTopFreeBooks
//
//  Created by Gokhan Alp on 5.01.2021.
//

import UIKit

class SearchItemTableViewCell: UITableViewCell {

    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellImageView: UIImageView!
    @IBOutlet weak var cellAuthorLabel: UILabel!
    @IBOutlet weak var cellDateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
}
