//
//  TeamDetailsViewController.swift
//  SportsAppDemo
//
//  Created by Bassant on 19/02/2023.
//

import UIKit

class TeamDetailsViewController: UIViewController {

    @IBOutlet weak var teamNameLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    var sport:String = ""
    var leagueID:Int = 0
    var teamName:String = ""
    var coreData = CoreData.coreDataObj
    var exist = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamNameLabel.text = teamName
        print(sport,leagueID,teamName)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if coreData.itemExists(sportName: sport, leagueID: leagueID, teamName: teamName){
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
           coreData.save(sportName: sport, leagueID: leagueID, teamName: teamName)
       }
        exist = !exist
    }
    
}
