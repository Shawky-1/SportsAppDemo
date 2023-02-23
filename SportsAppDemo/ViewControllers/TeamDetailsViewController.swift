//
//  TeamDetailsViewController.swift
//  SportsAppDemo
//
//  Created by Bassant on 19/02/2023.
//

import UIKit
import Kingfisher

class TeamDetailsViewController: UIViewController {

    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    var sport:String = ""
    var leagueID:Int = 0
    var teamName:String = ""
    var teamLogo:String = ""
    var PlayersDetails:[player] = []
    var coreData = CoreData.coreDataObj
    var exist = false
    
    

    @IBOutlet weak var detailTeamLogo: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamNameLabel.text = teamName
        let url = URL(string: teamLogo)
        detailTeamLogo.kf.setImage(with: url,placeholder: UIImage(named: "6"))
        if sport == "tennis"{
            detailTeamLogo.image = UIImage(named: "5")
        }else{
            detailTeamLogo.kf.setImage(with: url,placeholder: UIImage(named: "6"))
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if coreData.itemExists(sportName: sport, teamName: teamName){
            favButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            exist = true
        }
    }

    @IBAction func AddToFavorite(_ sender: UIButton) {
        if exist{
           sender.setImage(UIImage(systemName: "star"), for: .normal)
           coreData.del(sportName: sport, leagueID: leagueID, teamName: teamName)
       }else{
           sender.setImage(UIImage(systemName: "star.fill"), for: .normal)
           coreData.save(sportName: sport, leagueID: leagueID, teamName: teamName, teamLogo: teamLogo, players: PlayersDetails)
       }
        exist = !exist
    }
    
}

extension TeamDetailsViewController:UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return PlayersDetails.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! PlayerDetailCell
       
        cell.playerName.text = PlayersDetails[indexPath.row].player_name
        cell.playerAge.text = PlayersDetails[indexPath.row].player_age
        cell.playerPosition.text = PlayersDetails[indexPath.row].player_type
        
        let url = URL(string: PlayersDetails[indexPath.row].player_image ?? "")
        cell.playerImage.kf.setImage(with: url,placeholder: UIImage(named: "5"))
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 100
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if sport == "football"{
            return "Players"
        }else{
            return ""
        }
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
    
        
    }

