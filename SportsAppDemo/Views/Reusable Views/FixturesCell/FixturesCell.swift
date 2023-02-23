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
    
    func configureCell(match: matchs,sport:String){
        let processor = DownsamplingImageProcessor(size: HomeImgView.bounds.size)
                     |> RoundCornerImageProcessor(cornerRadius: 20)
        
        HomeImgView.kf.indicatorType = .activity
        awayImgView.kf.indicatorType = .activity
        
        if sport == "basketball" || sport == "cricket"{
            HomeImgView.kf.setImage(
                with: URL(string: match.event_home_team_logo ?? ""), placeholder: UIImage(named: "6"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            
            awayImgView.kf.setImage(
                with: URL(string: match.event_away_team_logo ?? ""),placeholder: UIImage(named: "6"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
        }else if sport == "football"{
            HomeImgView.kf.setImage(
                with: URL(string: match.home_team_logo ?? ""), placeholder: UIImage(named: "6"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            
            awayImgView.kf.setImage(
                with: URL(string: match.away_team_logo ?? ""),placeholder: UIImage(named: "6"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
        }else{
            HomeImgView.kf.setImage(
                with: URL(string: match.event_first_player_logo ?? ""), placeholder: UIImage(named: "5"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
            
            awayImgView.kf.setImage(
                with: URL(string: match.event_second_player_logo ?? ""),placeholder: UIImage(named: "5"),
                options: [
                    .processor(processor),
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(1)),
                    .cacheOriginalImage
                ])
        }
        
        if sport == "cricket"{
            HomeLbl.text = match.event_home_team
            awayLbl.text = match.event_away_team
            timeLbl.text = match.event_time
            StadiumLbl.text = match.event_date_start
        }else if sport == "tennis"{
            HomeLbl.text = match.event_first_player
            awayLbl.text = match.event_second_player
            timeLbl.text = match.event_time
            StadiumLbl.text = match.event_date
        }
        else{
            HomeLbl.text = match.event_home_team
            awayLbl.text = match.event_away_team
            timeLbl.text = match.event_time
            StadiumLbl.text = match.event_date
        }
       
        
        
        
        
        //        HomeImgView.image?.kf.setImage(with: match.home_team_logo, placeholder:UIImage(named: "1"))
        
    }

}
