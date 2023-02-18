//
//  Fixture-Standing-Teams view.swift
//  SportsAppDemo
//
//  Created by Abdelrahman on 17/02/2023.
//

import UIKit
import Kingfisher

class Fixture_Standing_Teams_view: UIViewController {
    
    var sport:String = ""
    var leagueID:Int = 0
    
    
    let teams = FetchTeams()
    
    var teamsData:Teams?
    
    var teamsNamesArray:[String] = []
    
    @IBOutlet weak var FixtureCollectionView: UICollectionView!
    
    @IBOutlet weak var TeamsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teams.fetchTeams(sport: sport, leagueId: leagueID) { teams in
            
            DispatchQueue.main.async {
                self.TeamsCollectionView.reloadData()
            }
            self.teamsData = teams
            
            guard let cTeams = teams else{return}
            
            for each in cTeams.result{
                let team = each.team_name!
                self.teamsNamesArray.append(team)
                
            }
            
        }
        
       

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
            
            
            
            return teamsNamesArray.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == FixtureCollectionView{
            let cell = FixtureCollectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! FixturesCollectionViewCell
            
            
            
            
            return cell
            
            
        }else{
            let cell = TeamsCollectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! TeamsCollectionViewCell
            
            cell.teamName.text = teamsNamesArray[indexPath.row]
           
            let url = URL(string: (teamsData?.result[indexPath.row].team_logo ?? "") )
            switch sport{
            case "football":
                cell.teamImageV.kf.setImage(with: url, placeholder:UIImage(named: "1"))
            case "basketball":
                cell.teamImageV.kf.setImage(with: url, placeholder:UIImage(named: "2"))
            case "cricket":
                cell.teamImageV.kf.setImage(with: url, placeholder:UIImage(named: "3"))
            default:
                cell.teamImageV.kf.setImage(with: url, placeholder:UIImage(named: "4"))
            }
                
                
                return cell
        }
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == FixtureCollectionView{
            
            
            return CGSize(width: 200, height: 200)
        }
        else{
            
            
            return CGSize(width: 150, height: 150)
        }
        
        
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == TeamsCollectionView{
            
        }
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
