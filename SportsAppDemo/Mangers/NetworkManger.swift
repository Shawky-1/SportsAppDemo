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
