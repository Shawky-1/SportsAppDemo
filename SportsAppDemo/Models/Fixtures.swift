//
//  Fixtures.swift
//  SportsAppDemo
//
//  Created by Ahmed Shawky on 15/02/2023.
//

import Foundation

struct Fixtures:Codable {
    let awayTeamName:String
    let homeTeamName:String
    
    enum CodingKeys:String, CodingKey{
        case awayTeamName = "event_away_team"
        case homeTeamName = "event_home_team"
    }
    
}

