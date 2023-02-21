//
//  TeamsCollectionViewCell.swift
//  SportsAppDemo
//
//  Created by Abdelrahman on 17/02/2023.
//

import UIKit
import Kingfisher

class TeamsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamImageV: UIImageView!
    @IBOutlet weak var teamView: UIView!
    @IBOutlet weak var teamName: UILabel!
    
    
    func configureCell(img:String, teamName:String){
        let processor = DownsamplingImageProcessor(size: teamImageV.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        
        teamImageV.kf.indicatorType = .activity
        
        
        teamImageV.kf.setImage(
            with: URL(string: img), placeholder: UIImage(named: "6"),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
        self.teamName.text = teamName
        teamView.layer.cornerRadius = teamView.bounds.width/2
    }
}
