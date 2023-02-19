//
//  NetworkManger.swift
//  SportsAppDemo
//
//  Created by Ahmed Shawky on 15/02/2023.
//

import Foundation
import Alamofire



class Fetch{
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
    
    
    func fetchLeagueFixtures(leagueID: Int , sport: String,complition:@escaping(Fixtures?)->Void){
        
        let todayDate = Date()
        let calenderr = Calendar.current
        var dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let dateWeekAhead = calenderr.date(byAdding: .day, value: 7, to: todayDate)
        
        let todayInString = dateFormatter.string(from: todayDate)
        let weekAheadString = dateFormatter.string(from: dateWeekAhead!)
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&APIkey=f0c91c252b484b72584eaff6bae73fd89b14cf1171ef9e9964572081f14d2868&from=\(todayInString)&to=\(weekAheadString)&leagueId=\(leagueID)")
        
        AF.request(url!).validate().responseJSON { response in
            do{
                let fixtures = try JSONDecoder().decode(Fixtures.self, from: response.data!)
                complition(fixtures)
            }catch{
                //print(error.localizedDescription)
                print(String(describing: error))
                complition(nil)
                
            }
        }
    }
    
    func fetchLeagueStandings(leagueID: Int , sport: String,complition:@escaping(Fixtures?)->Void){
        
        let todayDate = Date()
        let calenderr = Calendar.current
        let dateWeekAgo = calenderr.date(byAdding: .day, value: -7, to: todayDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let todayInString = dateFormatter.string(from: todayDate)
        let weekAgoDate = dateFormatter.string(from: dateWeekAgo!)
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/?met=Fixtures&APIkey=f0c91c252b484b72584eaff6bae73fd89b14cf1171ef9e9964572081f14d2868&from=\(weekAgoDate)&to=\(todayInString)&leagueId=\(leagueID)")
        
        AF.request(url!).validate().responseJSON { response in
            do{
                let fixtures = try JSONDecoder().decode(Fixtures.self, from: response.data!)
                complition(fixtures)
            }catch{
                //print(error.localizedDescription)
                print(String(describing: error))
                complition(nil)
                
            }
        }
    }
}










