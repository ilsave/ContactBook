//
//  RecentTableViewCell.swift
//  ContactBookFinal
//
//  Created by Gushchin Ilya on 04.04.2021.
//

import UIKit

class RecentTableViewCell: UITableViewCell {

    @IBOutlet var nameTitle: UILabel!
    @IBOutlet var timeTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
