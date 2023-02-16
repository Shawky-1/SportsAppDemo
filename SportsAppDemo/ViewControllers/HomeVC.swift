//
//  ViewController.swift
//  SportsAppDemo
//
//  Created by Ahmed Shawky on 14/02/2023.
//

import UIKit

class HomeVC: UIViewController {
   
    let sportTypesArray:[String] = ["Football","Basketball","Cricket","Tennis"]
    let sportTypesImages:[String] = ["1","2","3","4"]
    var sportType:String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showWalkThrough()
        

    }
    
    
    
    private func showWalkThrough(){
       
        if UserDefaults.standard.bool(forKey: "didFinishWalkThrough") != false {
            let walkThroughVC = self.storyboard?.instantiateViewController(withIdentifier: "WalkThroughVC") as! WalkThroughVC
            walkThroughVC.modalPresentationStyle = .overFullScreen
            self.present(walkThroughVC, animated: false)
        }
    }
}


/// collection view controller (Abdelrahman)

extension HomeVC:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 1
    }


    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 4
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! SportsTypes
    
        cell.label.text = sportTypesArray[indexPath.row]
        cell.imageView.image = UIImage(named: sportTypesImages[indexPath.row])
      
    
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width/2, height: 400)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let leagueVC = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
        
        switch indexPath.row{
        case 0:
            leagueVC.sport = "football"
        case 1:
            leagueVC.sport = "basketball"
        case 2:
            leagueVC.sport = "cricket"
        default:
            leagueVC.sport = "tennis"
            
        }
        
        self.navigationController?.pushViewController(leagueVC, animated: true)
        
    }
    
    
}

