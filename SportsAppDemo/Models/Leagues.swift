//
//  Leagues.swift
//  SportsAppDemo
//
//  Created by Abdelrahman on 17/02/2023.
//

import Foundation


struct Leagues: Codable{
    var success:Int
    var result:[Items]?
    init(success: Int, result: [Items]? = nil) {
        self.success = success
        self.result = result
    }
}

struct Items: Codable{
    var league_name:String
    var league_key:Int
    var league_logo:String?
    
}
