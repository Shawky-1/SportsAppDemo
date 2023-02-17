//
//  Leagues.swift
//  SportsAppDemo
//
//  Created by Abdelrahman on 17/02/2023.
//

import Foundation


class Leagues:Decodable{
    var success:Int?
    var result:[Items]
    
    }

class Items:Decodable{
    var league_name:String?
    var league_key:Int?
    var league_logo:String?
    
}
