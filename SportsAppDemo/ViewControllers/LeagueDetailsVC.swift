//
//  Fixture-Standing-Teams view.swift
//  SportsAppDemo
//
//  Created by Abdelrahman on 17/02/2023.
//

import UIKit
import Kingfisher

class LeagueDetailsVC: UIViewController {
    var sport:String = ""
    var leagueID:Int = 0
    let fixturexStandingTeams = Fetch()
    var teamsData = Teams()
    var fixturesData = Fixtures()
    var standingData = Fixtures()
    var tennisPlayersData = Fixtures()
    var teamsNamesArray:[String] = []
    
    @IBOutlet weak var FixtureCollectionView: UICollectionView!
    @IBOutlet weak var TeamsCollectionView: UICollectionView!
    @IBOutlet weak var standingTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCells()
        fetchFixtures()
        fetchStandings()
        fetchTeams()
        fetchTennisPlayers()
        self.title = "League Info"
       

    }
    
    func fetchFixtures(){
        fixturexStandingTeams.fetchLeagueFixtures(leagueID: leagueID, sport: sport) { [weak self] fixtures in
            guard let self = self else {return}
            switch fixtures{
            case .success(let fixtures):
                self.fixturesData = fixtures
                self.FixtureCollectionView.reloadData()
            case .failure(let error):
                //setup for placeholder
                print(error)
            }
        }
    }
        
    func fetchStandings(){
        fixturexStandingTeams.fetchLeagueStandings(leagueID: leagueID, sport: sport) { [weak self] fixtures in
            guard let self = self else {return}
            switch fixtures{
            case .success(let fixtures):
                self.standingData = fixtures
                self.standingTableView.reloadData()
            case .failure(let error):
                //setup for placeholder
                print(error)
            }
        }
    }
    
    func fetchTeams(){
        fixturexStandingTeams.fetchTeams(sport: sport, leagueId: leagueID) {[weak self] teams in
            guard let self = self else {return}
            switch teams{
            case .success(let team):
                self.teamsData = team
                self.TeamsCollectionView.reloadData()
                
                
                guard let team = team.result else {return}
                for index in 0...team.count-1{
                    self.teamsNamesArray.append((team[index].team_name)!)
                }
            case .failure(let error):
                //setup for placeholder
                print(error)
            }
        }
    }
    func fetchTennisPlayers(){
        fixturexStandingTeams.fetchTennisPlayers { [weak self]players in
            guard let self = self else {return}
            switch players{
            case .success(let player):
                self.tennisPlayersData = player
                self.TeamsCollectionView.reloadData()

                print(self.tennisPlayersData.result![1].player!)
                
            case .failure(let error):
                //setup for placeholder
                print(error)
            }
        }
    }
    
    func setupCells(){
        FixtureCollectionView.register(UINib(nibName: "FixturesCell", bundle: nil),
                                       forCellWithReuseIdentifier: "FixturesCell")
    }
}


//MARK: CollectionViewDataSource
extension LeagueDetailsVC:UICollectionViewDataSource{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == FixtureCollectionView{
            
            return fixturesData.result?.count ?? 1
        }else if collectionView == TeamsCollectionView{
            
            return teamsNamesArray.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case FixtureCollectionView:
            let cell = FixtureCollectionView.dequeueReusableCell(withReuseIdentifier: "FixturesCell", for: indexPath) as! FixturesCell
            guard let result = fixturesData.result?[indexPath.row] else { return cell}
            cell.configureCell(match: result)
            
            return cell
        case TeamsCollectionView:
            let cell = TeamsCollectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! TeamsCollectionViewCell
            guard let result = teamsData.result?[indexPath.row] else {return cell}
        
            if sport == "tennis"{
                cell.configureCell(img: "3", teamName: tennisPlayersData.result?[indexPath.row].player ?? "")
            }else{
                cell.configureCell(img: result.team_logo ?? "",
                                   teamName: result.team_name!)
            }
            
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
//MARK: CollectionViewDelegateFlowLayout
extension LeagueDetailsVC: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == FixtureCollectionView{
            return CGSize(width: collectionView.bounds.width - 30, height: collectionView.bounds.height - 20)
            
        }else if collectionView == TeamsCollectionView{
            return CGSize(width: TeamsCollectionView.bounds.height, height: TeamsCollectionView.bounds.height)
            
        } else{
            return CGSize(width: 100, height: 200)
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 5, left: 20, bottom: 5, right: 5)
    }
}


//MARK: CollectionViewDelegate
extension LeagueDetailsVC: UICollectionViewDelegate{
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

//MARK: UITableViewDataSource
extension LeagueDetailsVC:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return standingData.result?.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StandingTableViewCell
        if sport == "tennis"{
            cell.homeTeamName.text = standingData.result?[indexPath.row].event_first_player
            cell.awayTeamName.text = standingData.result?[indexPath.row].event_second_player
            cell.resultLabel.text = standingData.result?[indexPath.row].event_final_result
        }else{
            cell.homeTeamName.text = standingData.result?[indexPath.row].event_home_team
            cell.awayTeamName.text = standingData.result?[indexPath.row].event_away_team
            cell.resultLabel.text = standingData.result?[indexPath.row].event_final_result
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
        
    }
