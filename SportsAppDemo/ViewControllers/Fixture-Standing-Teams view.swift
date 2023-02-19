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
    var fixturesData: Fixtures?
    
    var teamsNamesArray:[String] = []
    
    
    @IBOutlet weak var FixtureCollectionView: UICollectionView!
    
    @IBOutlet weak var TeamsCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLeagueFixtures(leagueID: leagueID, sport: sport) {  fixtures in
            guard let fixtureObj = fixtures else {return}
            self.fixturesData = fixtureObj
            DispatchQueue.main.async {
                self.FixtureCollectionView.reloadData()
            }
            
        }
        
        //********************
        
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
extension Fixture_Standing_Teams_view:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        var sectionNums = 0
        if collectionView == FixtureCollectionView{
            
            
            
            sectionNums = fixturesData?.result.count ?? 2
        }else if collectionView == TeamsCollectionView{
    
                sectionNums = teamsNamesArray.count
        }
        return sectionNums
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == FixtureCollectionView{
            let cell = FixtureCollectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! FixturesCollectionViewCell
            if fixturesData?.result[indexPath.row].event_home_team == nil {
                cell.HomeTeamName.text = "no matches today"
            }else{
                
                cell.HomeTeamName.text = fixturesData?.result[indexPath.row].event_home_team
                cell.AwayTeamName.text = fixturesData?.result[indexPath.row].event_away_team
                cell.date.text = fixturesData?.result[indexPath.row].event_date
                cell.time.text = fixturesData?.result[indexPath.row].event_time
                
                let homeUrl = URL(string: fixturesData?.result[indexPath.row].home_team_logo ?? "")
                let awayUrl = URL(string: fixturesData?.result[indexPath.row].away_team_logo ?? "")
                
                switch sport{
                case "football":
                    cell.homeTeamLogo.kf.setImage(with: homeUrl, placeholder:UIImage(named: "1"))
                    cell.awayTeamLogo.kf.setImage(with: awayUrl, placeholder:UIImage(named: "1"))
                case "basketball":
                    cell.homeTeamLogo.kf.setImage(with: homeUrl, placeholder:UIImage(named: "2"))
                    cell.awayTeamLogo.kf.setImage(with: awayUrl, placeholder:UIImage(named: "2"))
                case "cricket":
                    cell.homeTeamLogo.kf.setImage(with: homeUrl, placeholder:UIImage(named: "3"))
                    cell.awayTeamLogo.kf.setImage(with: awayUrl, placeholder:UIImage(named: "3"))
                default:
                    cell.homeTeamLogo.kf.setImage(with: homeUrl, placeholder:UIImage(named: "4"))
                    cell.awayTeamLogo.kf.setImage(with: awayUrl, placeholder:UIImage(named: "4"))
                }
            }
            
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
        var CGSizee = CGSize(width: 0, height: 0)
        if collectionView == FixtureCollectionView{
            
            
             CGSizee = CGSize(width: 400, height: 200)
        }else if collectionView == TeamsCollectionView{
            
            
            
             CGSizee = CGSize(width: 150, height: 150)
            
            
        }
        return CGSizee
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == TeamsCollectionView{
            let teamDetails = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController

            teamDetails.sport = sport
            teamDetails.leagueID = leagueID
            teamDetails.teamName = teamsNamesArray[indexPath.row]

            self.navigationController?.pushViewController(teamDetails, animated: true)
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
