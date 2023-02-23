//
//  SportsTypes.swift
//  SportsAppDemo
//
//  Created by Abdelrahman on 16/02/2023.
//

import UIKit

class SportsTypes: UICollectionViewCell {
    
    @IBOutlet weak var backImg: UIImageView!
    @IBOutlet weak var sportView: UIView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    func configureCell(SportType: SportType){
        
        switch SportType.sportName {
        case "Football":
            backImg.image = UIImage(named: "FootBall-Texture")
            
        case "Basketball": backImg.image = UIImage(named: "BasketBall-Texture")
        case "Cricket": backImg.image = UIImage(named: "Cricket-Texture")
        case "Tennis": backImg.image = UIImage(named: "Tennis-Texture")
            
        default:
            backImg.image = UIImage(named: "FootBall-Texture")
        }
        
        
        label.text = SportType.sportName
        imageView.image = UIImage(named: SportType.sportImage)
        configureShadow(View: sportView, opacity: 0.7, radius: 20, offset: CGSize(width: 10, height: 10))
        
        backImg.layer.cornerRadius = 45
        backImg.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        backImg.layer.borderWidth = 3
        configureShadow(View: label, opacity: 1, radius: 5, offset: CGSize(width: 0, height: 0))
        label.layer.shadowColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        sportView.layer.cornerRadius = sportView.bounds.height / 2 - 5
        
    }
    
    func configureShadow(View: UIView, opacity: Float, radius: Double, offset: CGSize){
        View.layer.shadowOpacity = opacity
        View.layer.shadowRadius = radius
        View.layer.shadowOffset = offset
    }
}
