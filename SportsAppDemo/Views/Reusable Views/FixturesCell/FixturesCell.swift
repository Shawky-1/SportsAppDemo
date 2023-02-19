//
//  FixturesCell.swift
//  SportsAppDemo
//
//  Created by Ahmed Shawky on 19/02/2023.
//

import UIKit
import Kingfisher

class FixturesCell: UICollectionViewCell {

    @IBOutlet weak var HomeImgView: UIImageView!
    @IBOutlet weak var awayImgView: UIImageView!
    @IBOutlet weak var HomeLbl: UILabel!
    @IBOutlet weak var awayLbl: UILabel!
    @IBOutlet weak var timeLbl: UILabel!
    @IBOutlet weak var StadiumLbl: UILabel!
    
    @IBOutlet weak var VsLbl: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.layer.cornerRadius = 30
        // Initialization code
    }
    
    func configureCell(match: matchs){
        let processor = DownsamplingImageProcessor(size: HomeImgView.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        
        HomeImgView.kf.indicatorType = .activity
        awayImgView.kf.indicatorType = .activity
        
        
        HomeImgView.kf.setImage(
            with: URL(string: match.home_team_logo!),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
        awayImgView.kf.setImage(
            with: URL(string: match.away_team_logo!),
            options: [
                .processor(processor),
                .scaleFactor(UIScreen.main.scale),
                .transition(.fade(1)),
                .cacheOriginalImage
            ])
        
        HomeLbl.text = match.event_home_team
        awayLbl.text = match.event_away_team
        timeLbl.text = match.event_time
        StadiumLbl.text = match.event_date
        
        
        //        HomeImgView.image?.kf.setImage(with: match.home_team_logo, placeholder:UIImage(named: "1"))
        
    }

}
