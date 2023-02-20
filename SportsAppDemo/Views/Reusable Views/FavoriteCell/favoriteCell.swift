//
//  favoriteCell.swift
//  SportsAppDemo
//
//  Created by Bassant on 17/02/2023.
//

import UIKit

class favoriteCell: UITableViewCell {

    @IBOutlet weak var favLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
