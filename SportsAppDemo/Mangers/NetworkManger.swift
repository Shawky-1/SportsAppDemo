//
//  NetworkManger.swift
//  SportsAppDemo
//
//  Created by Ahmed Shawky on 15/02/2023.
//

import Foundation
import Alamofire



class Fetch{
    
    private let key = "f0c91c252b484b72584eaff6bae73fd89b14cf1171ef9e9964572081f14d2868"
    
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
    
    func fetchTeams(sport:String,leagueId:Int,complition:@escaping (Result<Teams, Error>)->Void){
        
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/")
        
        let parameters:[String: Any] = ["met": "Teams",
                                        "APIkey": key,
                                        "leagueId": leagueId]
        
        if sport != "tennis"{
            
            AF.request(url!, parameters: parameters).validate().response { responseData in
                switch responseData.result{
                case .success(let data):
                    do{
                        let teams = try JSONDecoder().decode(Teams.self, from: data!)
                        complition(.success(teams))
                    }catch{
                        complition(.failure(error))
                    }
                case .failure(let error):
                    complition(.failure(error))
                }
            }
            
        }

        
    }
    
    
    func fetchLeagueFixtures(leagueID: Int , sport: String,complition:@escaping(Result<Fixtures, Error>)->Void){
        let todayDate = Date()
        let calenderr = Calendar.current
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let dateWeekAhead = calenderr.date(byAdding: .day, value: 7, to: todayDate)
        
        let todayInString = dateFormatter.string(from: todayDate)
        let weekAheadString = dateFormatter.string(from: dateWeekAhead!)
        
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/")
        
        let parameters:[String: Any] = ["met": "Fixtures",
                                        "APIkey": key,
                                        "from": todayInString,
                                        "to": weekAheadString,
                                        "leagueId": leagueID]
        
        AF.request(url!, parameters: parameters).validate().response { responseData in
            switch responseData.result{
            case .success(let data):
                do {
                    let fixtures = try JSONDecoder().decode(Fixtures.self, from: data!)
                    complition(.success(fixtures))
                } catch{
                    complition(.failure(error))
                }
            case .failure(let error):
                complition(.failure(error))
                
            }
        }
        
    }
    
    func fetchLeagueStandings(leagueID: Int , sport: String,complition:@escaping(Result<Fixtures, Error>)->Void){
        
        let todayDate = Date()
        let calenderr = Calendar.current
        let dateWeekAgo = calenderr.date(byAdding: .day, value: -7, to: todayDate)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let todayInString = dateFormatter.string(from: todayDate)
        let weekAgoDate = dateFormatter.string(from: dateWeekAgo!)
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/")
        
        let parameters:[String: Any] = ["met": "Fixtures",
                                        "APIkey": key,
                                        "from": weekAgoDate,
                                        "to": todayInString,
                                        "leagueId": leagueID]
        
        AF.request(url!, parameters: parameters).validate().response { responseData in
            
            switch responseData.result{
            case.success(let data):
                do{
                    let fixtures = try JSONDecoder().decode(Fixtures.self, from: data!)
                    complition(.success(fixtures))
                } catch {
                    complition(.failure(error))
                }
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }
}










