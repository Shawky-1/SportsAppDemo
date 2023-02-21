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
    var leagues:Leagues?
    var filteredLeagues:Leagues?
    let fLeagus = Fetch()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchLeagues()
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: namesSearchBar)
    }
    
    func fetchLeagues(){
        fLeagus.fetchLeagues(sport: sport) { [weak self] result in
            guard let self = self else {return}
            switch result{
            case .success(let leagues):
                self.leagues = leagues
                self.filteredLeagues = leagues
                self.tableView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
}

extension LeaguesVC: UITableViewDelegate,UITableViewDataSource{
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return filteredLeagues?.result?.count ?? 0
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! LeaguesCells
        guard let result = filteredLeagues?.result else {return cell}
        
        cell.label.text = result[indexPath.row].league_name
        let url = URL(string: result[indexPath.row].league_logo ?? "")
        
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
        secVc.leagueID = filteredLeagues?.result?[indexPath.row].league_key ?? 0
        
        self.navigationController?.pushViewController(secVc, animated: true)
    }
    
}


extension LeaguesVC:UISearchBarDelegate{
    
    //    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //        if searchText != ""{
    //            filteredLeagues?.result?.removeAll()
    //            self.filteredLeagues?.result = self.leagues?.result?.filter{
    //                $0.league_name.contains(searchText)}
    //            self.tableView.reloadData()
    //        }else{
    //            self.filteredLeagues?.result = self.leagues?.result
    //            self.tableView.reloadData()
    //        }
    //    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            filteredLeagues = leagues
            tableView.reloadData()
        } else {
            filteredLeagues?.result = leagues?.result?.filter{
                $0.league_name.lowercased().contains(searchText.lowercased()) }
            tableView.reloadData()
        }
    }
    
}


extension LeaguesVC:UIScrollViewDelegate{
    
}
