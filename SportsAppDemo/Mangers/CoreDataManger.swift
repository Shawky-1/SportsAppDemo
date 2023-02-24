//
//  CoreDataManger.swift
//  SportsAppDemo
//
//  Created by Ahmed Shawky on 15/02/2023.
//

import Foundation
import UIKit
import CoreData

class CoreData{
    var context : NSManagedObjectContext?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // singleton object
    static let coreDataObj = CoreData()
    private init(){
        context = appDelegate.persistentContainer.viewContext
    }
    
    func save(sportName:String, leagueID:Int, teamName:String, teamLogo:String, players:[player])->Void {
        let team = Sports(context: context!)
        
        team.sportName = sportName
        team.leagueID = Int64(leagueID)
        team.teamName = teamName
        team.teamLogo = teamLogo
                
        for i in 0..<players.count{
            let playerX = Player(context: context!)
            playerX.playerName = players[i].player_name
            playerX.playerNumber = players[i].player_number
            playerX.playerType = players[i].player_type
            playerX.playerAge = players[i].player_age
            playerX.playerImage = players[i].player_image
            
            team.addToSportsToPlayer(playerX)
        }
        
        try? context?.save()
        print("object saved")
    }

    func fetchTeams()->[NSManagedObject] {
        let fetchTeamReq: NSFetchRequest<Sports> = Sports.fetchRequest()
        let teams = try? context?.fetch(fetchTeamReq)
        
        return teams ?? []
    }
    
    func fetchPlayers(team:Sports)->[NSManagedObject]{
        let fetchPlayerReq: NSFetchRequest<Player> = Player.fetchRequest()
        fetchPlayerReq.predicate = NSPredicate(format: "playerToSports = %@", team)
        let players = (try? context?.fetch(fetchPlayerReq)) ?? []
        return players
    }
 
    func del(sportName:String, leagueID:Int, teamName:String)->Void {
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Sports")
        let myPredicate = NSPredicate(format: "sportName == %@ AND leagueID == %ld AND teamName == %@", sportName, leagueID, teamName)
        fetchReq.predicate = myPredicate
        let teams = try? context?.fetch(fetchReq)
        
        context?.delete((teams?[0])!)
        try? context?.save()
        print("object deleted")
    }
   
    func itemExists(sportName:String, teamName:String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Sports")
        fetchRequest.predicate = NSPredicate(format: "sportName == %@ AND teamName == %@", sportName, teamName)
        let results = try? context?.fetch(fetchRequest)
        
        return results?.count ?? 0 > 0
    }
}
