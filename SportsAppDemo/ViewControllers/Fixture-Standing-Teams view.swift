//
//  Fixture-Standing-Teams view.swift
//  SportsAppDemo
//
//  Created by Abdelrahman on 17/02/2023.
//

import UIKit

class Fixture_Standing_Teams_view: UIViewController {
    
    
    @IBOutlet weak var FixtureCollectionView: UICollectionView!
    
    @IBOutlet weak var TeamsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    

  

}


/// Fixtures-Teams collection view controller
extension Fixture_Standing_Teams_view:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == FixtureCollectionView{
            
            
            
            return 5
        }else{
            
            
            
            return 6
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == FixtureCollectionView{
            let cell = FixtureCollectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! FixturesCollectionViewCell
            
            
            
            
            return cell
        }
        let cell = TeamsCollectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! TeamsCollectionViewCell
        
            
            
            
            
            
            return cell
    }
    
    

    
}

///  standing table view controller
extension Fixture_Standing_Teams_view:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StandingTableViewCell

        return cell
    }
    
        
    }
