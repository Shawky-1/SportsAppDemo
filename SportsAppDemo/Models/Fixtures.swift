//
//  Fixtures.swift
//  SportsAppDemo
//
//  Created by Ahmed Shawky on 15/02/2023.
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


