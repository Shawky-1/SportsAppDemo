//
//  LeaguesViewController.swift
//  SportsAppDemo
//
//  Created by Abdelrahman on 16/02/2023.
//

import UIKit
import Alamofire
import Kingfisher


class LeaguesVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var namesSearchBar: UISearchBar!
    
    
    var sport = ""
    var LeaguesV:Leagues?
    var leagueNames:[String] = []
    var filteredNames:[String] = []
    
    let fLeagus = Fetch()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fLeagus.fetchLeagues(sport: sport) { result in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
            
            self.LeaguesV = result
            
            for each in result!.result{
                let title = each.league_name
                self.leagueNames.append(title!)
            }
            
            self.filteredNames = self.leagueNames
        }
    }
    
  
    
}

extension LeaguesVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredNames.count
    }
    
 
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesCells

        
        
        cell.label.text = filteredNames[indexPath.row]
        let url = URL(string: (LeaguesV?.result[indexPath.row].league_logo ?? "") )
        switch sport{
        case "football":
            cell.imageV.kf.setImage(with: url, placeholder:UIImage(named: "1"))
        case "basketball":
            cell.imageV.kf.setImage(with: url, placeholder:UIImage(named: "2"))
        case "cricket":
            cell.imageV.kf.setImage(with: url, placeholder:UIImage(named: "3"))
        default:
            cell.imageV.kf.setImage(with: url, placeholder:UIImage(named: "4"))
        }
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Leagues"
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let secVc = self.storyboard?.instantiateViewController(withIdentifier: "LeagueDetailsVC") as! LeagueDetailsVC
        
        secVc.sport = sport
        secVc.leagueID = LeaguesV?.result[indexPath.row].league_key ?? 0
        
        self.navigationController?.pushViewController(secVc, animated: true)
    }
    
}


extension LeaguesVC:UISearchBarDelegate{
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != ""{
            filteredNames.removeAll()
            self.filteredNames = self.leagueNames.filter{$0 .contains(searchText)}
            self.tableView.reloadData()
            print(searchText)
            
        }else{
            self.filteredNames = self.leagueNames
            self.tableView.reloadData()
        }
    }
    
}


extension LeaguesVC:UIScrollViewDelegate{
    
}
