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
        let strokeTextAttributes = [
            NSAttributedString.Key.strokeColor : UIColor.secondarySystemBackground,
            NSAttributedString.Key.strokeWidth : -5.0]
            as [NSAttributedString.Key : Any]
        
//        label.text = SportType.sportName
        label.attributedText = NSMutableAttributedString(string: SportType.sportName, attributes: strokeTextAttributes)

        imageView.image = UIImage(named: SportType.sportImage)
        configureShadow(View: sportView, opacity: 0.7, radius: 20, offset: CGSize(width: 10, height: 10))
        
        backImg.layer.cornerRadius = 45
        backImg.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        backImg.layer.borderWidth = 3
        backImg.alpha = 1
        configureShadow(View: label, opacity: 1, radius: 1, offset: CGSize(width: 0, height: 2))
        
        sportView.layer.cornerRadius = sportView.bounds.height / 2 - 5
        
    }
    
    func configureShadow(View: UIView, opacity: Float, radius: Double, offset: CGSize){
        View.layer.shadowOpacity = opacity
        View.layer.shadowRadius = radius
        View.layer.shadowOffset = offset
    }
}
