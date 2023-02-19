//
//  Fixtures.swift
//  SportsAppDemo
//
//  Created by Ahmed Shawky on 15/02/2023.
//

import Foundation


class Fixtures : Decodable {
    
    var success : Int?
    var result : [matchs]
    
}

class matchs : Decodable{
    var event_date : String?
    var event_time : String?
    var event_away_team : String?
    var event_home_team : String?
    var event_final_result :String?
    var league_name : String?
    var league_round : String?
    var league_logo : String?
    var home_team_logo : String?
    var away_team_logo : String?
    var league_season : String?
    var  event_live : String?
    var event_stadium : String?
}
