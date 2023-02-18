//
//  SportsTypes.swift
//  SportsAppDemo
//
//  Created by Abdelrahman on 16/02/2023.
//

import UIKit

class SportsTypes: UICollectionViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(SportType: SportType){
        label.text = SportType.sportName
        imageView.image = UIImage(named: SportType.sportImage)
        self.layer.shadowOpacity = 0.5
        self.layer.shadowRadius = 5
        self.layer.shadowOffset = CGSize(width: 3, height: 4)
        
    }
}
