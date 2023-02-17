//
//  Teams.swift
//  SportsAppDemo
//
//  Created by Abdelrahman on 17/02/2023.
//

import Foundation

struct Teams:Decodable{
    var success:Int?
    var result:result2
}



struct result2:Decodable{
    var total:[teamsItems]
    var home:[teamsItems]
    var away:[teamsItems]
}


struct teamsItems:Decodable{
    var standing_place:Int?
    var standing_team:String?
}
