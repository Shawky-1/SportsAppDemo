//
//  ViewController.swift
//  SportsAppDemo
//
//  Created by Ahmed Shawky on 14/02/2023.
//

import UIKit

class HomeVC: UIViewController {
    
    let sportTypes = [SportType(sportName: "Football", sportImage: "FootBall"),
                      SportType(sportName: "Basketball", sportImage: "BasketBall"),
                      SportType(sportName: "Cricket", sportImage: "Cricket"),
                      SportType(sportName: "Tennis", sportImage: "Tennis")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Sports"
        showWalkThrough()
    }
    
    private func showWalkThrough(){
        if UserDefaults.standard.bool(forKey: "didFinishWalkThrough") != true {
            let walkThroughVC = self.storyboard?.instantiateViewController(withIdentifier: "WalkThroughVC") as! WalkThroughVC
            walkThroughVC.modalPresentationStyle = .overFullScreen
            self.present(walkThroughVC, animated: false)
        }
    }
}

//MARK: collectionView DataSource (Abdelrahman)
extension HomeVC:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sportTypes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SportsCell", for: indexPath) as! SportsTypes
        
        cell.configureCell(SportType: sportTypes[indexPath.row])
        return cell
    }
}

//MARK: CollectionViewDelegate
extension HomeVC: UICollectionViewDelegate{
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leagueVC = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesVC") as! LeaguesVC
        
        leagueVC.sport = sportTypes[indexPath.row].sportName.lowercased()
        leagueVC.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(leagueVC, animated: true)
    }
}
 
//MARK: CollectionViewFlowLayout
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: self.view.frame.width/2 - 10,
                      height: self.view.frame.height / 2 - self.view.frame.height / 6.5)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 5, bottom: 0, right: 5)
    }
}
