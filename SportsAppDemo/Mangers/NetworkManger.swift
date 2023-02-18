//
//  NetworkManger.swift
//  SportsAppDemo
//
//  Created by Ahmed Shawky on 15/02/2023.
//

import Foundation
import Alamofire


class FetchLeagues{
    func fetchLeagues(sport:String,complition:@escaping (Leagues?)->Void){
            let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Leagues&APIkey=948dffee8d69a2f1394c8afa15cf24ce972f8326f28d0e9270e26a9a24779b24")
        
            AF.request(url!).validate().responseJSON { (response) in
                do{
                    let Leagues = try JSONDecoder().decode(Leagues.self, from: response.data!)
                    complition(Leagues)
                    
                    
                    
                }catch{
                    complition(nil)
                    print(error.localizedDescription)
                }
            }
            
            
            
                
            }
}


class FetchTeams{
    func fetchTeams(sport:String,leagueId:Int,complition:@escaping (Teams?)->Void){
        
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?&met=Teams&leagueId=\(leagueId)&APIkey=948dffee8d69a2f1394c8afa15cf24ce972f8326f28d0e9270e26a9a24779b24&fbclid=IwAR2UWH0vmNLAOzK0ASZqx4VPJd_wpZ1BudOXucs4s4-DuXMmM_taOP3MDmw")
        
        if sport != "tennis"{
            
            AF.request(url!).validate().responseJSON { (response) in
                do{
                    let Teams = try JSONDecoder().decode(Teams.self, from: response.data!)
                    
                    complition(Teams)
                    
                    
                    
                    
                }catch{
                    complition(nil)
                    //print(error.localizedDescription)
                    print(String(describing: error))
                }
            }
            
        }else{
            complition(nil)
        }
        
        
        
    }
}
