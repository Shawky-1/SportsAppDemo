//
//  Teams.swift
//  SportsAppDemo
//
//  Created by Abdelrahman on 17/02/2023.
//

import Foundation

struct Teams:Decodable{
    var success:Int?
    var result:[teamsItems]?
}


struct teamsItems:Decodable{
    var team_key:Int?
    var team_name:String?
    var team_logo:String?
    var players:[player]?
}

struct player:Decodable{
    init(record: Player){
        self.player_name = record.playerName
        self.player_number = record.playerNumber
        self.player_type = record.playerType
        self.player_age = record.playerAge
        self.player_image = record.playerImage
    }
    var player_name:String?
    var player_number:String?
    var player_type:String?
    var player_age:String?
    var player_image:String?
}
