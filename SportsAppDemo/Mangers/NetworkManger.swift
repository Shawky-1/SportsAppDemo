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
    
    func fetchLeagues(sport:String,complition:@escaping (Result<Leagues, Error>)->Void){
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/")
        
        let parameters:[String: Any] = ["met": "Leagues",
                                        "APIkey": key]
        
        AF.request(url!, parameters: parameters).validate().response { responseData in
            
            switch responseData.result{
            case .success(let data):
                do{
                    let Leagues = try JSONDecoder().decode(Leagues.self, from: data!)
                    complition(.success(Leagues))
                }catch{
                    complition(.failure(error))
                }
            case .failure(let error):
                complition(.failure(error))
            }
        }
    }
    
    
    func  fetchTennisPlayers(sport:String,complition:@escaping(Result<Fixtures,Error>)->Void){
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/")
        let parameters:[String: Any] = ["met": "Standings",
                                        "APIkey": key,
                                        "league": "ATP"]
        if sport == "tennis"{
            AF.request(url!, parameters: parameters).validate().response { responseData in
                switch responseData.result{
                case .success(let data):
                    do{
                        let players = try JSONDecoder().decode(Fixtures.self, from: data!)
                        complition(.success(players))
                    }catch{
                        complition(.failure(error))
                    }
                case .failure(let error):
                    complition(.failure(error))
                }
            }
        }
       
    }
    
    
    func  fetchTennisFixtures(sport:String,complition:@escaping(Result<Fixtures,Error>)->Void){
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/")
        let parameters:[String: Any] = ["met": "Livescore",
                                        "APIkey": key]
        if sport == "tennis"{
            AF.request(url!, parameters: parameters).validate().response { responseData in
                switch responseData.result{
                case .success(let data):
                    do{
                        let players = try JSONDecoder().decode(Fixtures.self, from: data!)
                        complition(.success(players))
                    }catch{
                        complition(.failure(error))
                    }
                case .failure(let error):
                    complition(.failure(error))
                }
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
        let dayAgo = calenderr.date(byAdding: .day, value: -1, to: todayDate)
        let dateWeekAgo = calenderr.date(byAdding: .day, value: -7, to: dayAgo!)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-dd"
        let todayInString = dateFormatter.string(from: todayDate)
        let dayAgoString = dateFormatter.string(from: dayAgo!)
        let weekAgoDate = dateFormatter.string(from: dateWeekAgo!)
        let url = URL(string: "https://apiv2.allsportsapi.com/\(sport)/")
        
        let parameters:[String: Any] = ["met": "Fixtures",
                                        "APIkey": key,
                                        "from": weekAgoDate,
                                        "to": dayAgoString,
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










