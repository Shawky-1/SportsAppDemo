//
//  Fixture-Standing-Teams view.swift
//  SportsAppDemo
//
//  Created by Abdelrahman on 17/02/2023.
//

import UIKit
import Kingfisher
import SkeletonView

class LeagueDetailsVC: UIViewController {
    var sport:String = ""
    var leagueID:Int = 0
    let fixturexStandingTeams = Fetch()
    var teamsData = Teams()
    var fixturesData = Fixtures()
    var standingData = Fixtures()
    var tennisPlayersData = Fixtures()
    var tennisFixturesData = Fixtures()
    var teamsNamesArray:[String] = []
    let dummyMatches = matchs()
    let dummyTeams = teamsItems(team_key: 0, team_name: "", team_logo: "", players: nil)
    
    @IBOutlet weak var FixtureCollectionView: UICollectionView!
    @IBOutlet weak var TeamsCollectionView: UICollectionView!
    @IBOutlet weak var standingTableView: UITableView!
    @IBOutlet weak var noFixturesLabel: UILabel!
    @IBOutlet weak var noStandingResultsLabel: UILabel!
    @IBOutlet weak var connectionImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCells()
        standingData.result = [dummyMatches]
        teamsData.result = [dummyTeams]
        showSkeletonViews()
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    func showSkeletonViews(){
        standingTableView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .asbestos),
                                                       animation: nil,
                                                       transition: .crossDissolve(0.25))
        TeamsCollectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .asbestos),
                                                         animation: nil,
                                                         transition: .crossDissolve(0.25))
        
        FixtureCollectionView.showAnimatedGradientSkeleton(usingGradient: .init(baseColor: .asbestos),
                                                           animation: nil,
                                                           transition: .crossDissolve(0.25))
    }
}


extension LeagueDetailsVC{
    
    func setupCells(){
        FixtureCollectionView.register(UINib(nibName: "FixturesCell", bundle: nil),
                                       forCellWithReuseIdentifier: "FixturesCell")
        fetchFixtures()
        fetchStandings()
        fetchTeams()
        fetchTennisPlayers()
        fetchTennisFixtures()
        self.title = "League Info"
    }
    
    func fetchFixtures(){
        fixturexStandingTeams.fetchLeagueFixtures(leagueID: leagueID, sport: sport) { [weak self] fixtures in
            guard let self = self else {return}
            switch fixtures{
            case .success(let fixtures):
                self.fixturesData = fixtures
                self.fixturesData.result = self.fixturesData.result?.reversed()
                self.FixtureCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                
                if self.fixturesData.result == nil && self.sport != "tennis"{
                    self.FixtureCollectionView.isHidden = true
                    self.noFixturesLabel.isHidden = false
                }
            case .failure(let error):
                self.FixtureCollectionView.isHidden = true
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
                self.standingTableView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                if self.standingData.result == nil && self.sport != "tennis"{
                    self.standingTableView.isHidden = true
                    self.noStandingResultsLabel.isHidden = false
                }
            case .failure(let error):
                self.standingTableView.isHidden = true
                self.connectionImageView.image = UIImage(named: "no_internet")
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
                guard let team = team.result else {return}
                for index in 0...team.count-1{
                    self.teamsNamesArray.append((team[index].team_name)!)
                }
                self.TeamsCollectionView.hideSkeleton()
                self.TeamsCollectionView.reloadData()
            case .failure(let error):
                self.TeamsCollectionView.isHidden = true
                print(error)
            }
        }
    }
    func fetchTennisPlayers(){
        fixturexStandingTeams.fetchTennisPlayers(sport:sport) { [weak self]players in
            guard let self = self else {return}
            switch players{
            case .success(let player):
                self.tennisPlayersData = player
                self.TeamsCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
            case .failure(let error):
                //setup for placeholder
                print(error)
            }
        }
    }
    
    func fetchTennisFixtures(){
        fixturexStandingTeams.fetchTennisFixtures(sport: sport) { [weak self]players in
            guard let self = self else {return}
            switch players{
            case .success(let player):
                self.tennisFixturesData = player
                self.FixtureCollectionView.reloadData()
                self.standingTableView.reloadData()
                //self.FixtureCollectionView.hideSkeleton(reloadDataAfter: true, transition: .crossDissolve(0.25))
                //print(self.tennisFixturesData.result?[2].event_first_player)
            case .failure(let error):
                //setup for placeholder
                print(String(describing: error))
            }
        }
    }
}

//MARK: CollectionViewDataSource
extension LeagueDetailsVC:SkeletonCollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == FixtureCollectionView{
            if sport == "tennis"{
                return tennisFixturesData.result?.count ?? 1
            }else{
                return fixturesData.result?.count ?? 1
            }
            
            
            
        }else if collectionView == TeamsCollectionView{
            if sport == "tennis"{
                return tennisPlayersData.result?.count ?? 0
            } else {
                return teamsData.result?.count ?? 0
                
            }
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch collectionView {
        case FixtureCollectionView:
            let cell = FixtureCollectionView.dequeueReusableCell(withReuseIdentifier: "FixturesCell", for: indexPath) as! FixturesCell
            //            guard let result = fixturesData.result?[indexPath.row] else { return cell}
            if sport == "tennis"{
                cell.configureCell(match: tennisFixturesData.result?[indexPath.row] ?? dummyMatches, sport: sport)
            }else{
                cell.configureCell(match: fixturesData.result?[indexPath.row] ?? dummyMatches,sport: sport)
            }
            
            
            return cell
        case TeamsCollectionView:
            let cell = TeamsCollectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! TeamsCollectionViewCell
            cell.teamView.backgroundColor = .secondarySystemBackground
            if sport == "tennis"{
                cell.teamName.text = tennisPlayersData.result?[indexPath.row].player ?? ""
                cell.teamImageV.image = UIImage(named: "5")
                cell.backgroundView?.backgroundColor = .clear
                cell.teamView.backgroundColor = .clear
            }else{
                cell.configureCell(img: teamsData.result?[indexPath.row].team_logo ?? "",
                                   teamName: teamsData.result?[indexPath.row].team_name ?? "")
            }
            
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
}
//MARK: CollectionViewDelegateFlowLayout
extension LeagueDetailsVC: UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
    }
}


//MARK: CollectionViewDelegate
extension LeagueDetailsVC: UICollectionViewDelegate{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == FixtureCollectionView{
            return CGSize(width: collectionView.bounds.width - 10, height: collectionView.bounds.height - 20)
            
        }else if collectionView == TeamsCollectionView{
            return CGSize(width: TeamsCollectionView.bounds.height, height: TeamsCollectionView.bounds.height)
            
        } else{
            return CGSize(width: 100, height: 200)
            
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == TeamsCollectionView{
            let teamDetails = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController
            
            teamDetails.sport = sport
            teamDetails.leagueID = leagueID
            if sport == "tennis"{
                teamDetails.teamName = tennisPlayersData.result?[indexPath.row].player ?? ""
                
            }else{
                teamDetails.teamName = teamsNamesArray[indexPath.row]
                teamDetails.teamLogo = teamsData.result?[indexPath.row].team_logo ?? ""
            }
            
            
            if sport == "football"{
                guard let players = (teamsData.result?[indexPath.row].players) else {return}
                
                teamDetails.PlayersDetails = players
            }
            
            self.navigationController?.pushViewController(teamDetails, animated: true)
        }
    }
}

//MARK: UITableViewDataSource
extension LeagueDetailsVC:UITableViewDataSource, SkeletonTableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if sport == "tennis"{
            return tennisFixturesData.result?.count ?? 1
        }else{
            return standingData.result?.count ?? 0
        }
        
        
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StandingTableViewCell
        
        if sport == "tennis"{
            cell.homeTeamName.text = tennisFixturesData.result?[indexPath.row].event_first_player
            cell.awayTeamName.text = tennisFixturesData.result?[indexPath.row].event_second_player
            cell.resultLabel.text = tennisFixturesData.result?[indexPath.row].event_final_result
        }else{
            cell.homeTeamName.text = standingData.result?[indexPath.row].event_home_team
            cell.awayTeamName.text = standingData.result?[indexPath.row].event_away_team
            cell.resultLabel.text = standingData.result?[indexPath.row].event_final_result
            cell.cRes1.text = standingData.result?[indexPath.row].event_home_final_result
            cell.cRes2.text = standingData.result?[indexPath.row].event_away_final_result
            cell.homeLogo.kf.setImage(with: URL(string: standingData.result?[indexPath.row].home_team_logo ?? ""))
            cell.awayLogo.kf.setImage(with: URL(string: standingData.result?[indexPath.row].away_team_logo ?? ""))
            cell.date.text = standingData.result?[indexPath.row].event_date
            cell.liveTime.text = standingData.result?[indexPath.row].event_time
        }
        
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
}

//MARK: CollectionViewSkeleton
extension LeagueDetailsVC {
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> SkeletonView.ReusableCellIdentifier {
        switch skeletonView{
        case FixtureCollectionView:
            return "FixturesCell"
        case TeamsCollectionView:
            return "item"
        default:
            return ""
        }
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, skeletonCellForItemAt indexPath: IndexPath) -> UICollectionViewCell? {
        switch skeletonView {
        case FixtureCollectionView:
            let cell = FixtureCollectionView.dequeueReusableCell(withReuseIdentifier: "FixturesCell", for: indexPath) as! FixturesCell
            
            return cell
        case TeamsCollectionView:
            let cell = TeamsCollectionView.dequeueReusableCell(withReuseIdentifier: "item", for: indexPath) as! TeamsCollectionViewCell
            cell.teamImageV.skeletonCornerRadius = Float(cell.teamImageV.bounds.width / 2)
            cell.backgroundView?.backgroundColor = .clear
            cell.teamName.text = ""
            
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
}

//MARK: TableViewSkeleton
extension LeagueDetailsVC{
    func collectionSkeletonView(_ skeletonView: UITableView, cellIdentifierForRowAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return "cell"
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionSkeletonView(_ skeletonView: UITableView, skeletonCellForRowAt indexPath: IndexPath) -> UITableViewCell? {
        let cell = skeletonView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! StandingTableViewCell
        cell.homeLogo.layer.cornerRadius = 15
        cell.awayLogo.layer.cornerRadius = 15
        return cell
        
    }
}
