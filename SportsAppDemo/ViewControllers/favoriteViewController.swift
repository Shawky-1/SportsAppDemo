//
//  favoriteViewController.swift
//  SportsAppDemo
//
//  Created by Bassant on 17/02/2023.
//

import UIKit
import CoreData
import Kingfisher

class favoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var favTable: UITableView!
    
    var sport = ""
    var favArray: [NSManagedObject] = []
    var coreData = CoreData.coreDataObj
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favTable.delegate = self
        favTable.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        favArray = coreData.fetch()
        favTable.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favTable.dequeueReusableCell(withIdentifier: "favCell") as! favoriteCell
        
        let logo = URL(string: favArray[indexPath.row].value(forKey: "teamLogo") as? String ?? "")
        cell.favTeamLogo.kf.setImage(with: logo, placeholder:UIImage(named: "6"))
        
        cell.favLabel.text = favArray[indexPath.row].value(forKey: "teamName") as? String
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        // Alert
        
        //alert controller
        var alert = UIAlertController(title: "Delete", message: "Delete team from favorite list", preferredStyle: .actionSheet)
        
        //actions
        let deleteAction = UIAlertAction(title: "Delete", style: UIAlertAction.Style.destructive) {
                UIAlertAction in
            if editingStyle == UITableViewCell.EditingStyle.delete {
                var item = self.favArray[indexPath.row]  // Item to be deleted
                self.favArray.remove(at: indexPath.row)  // delete item from favorite array
                self.coreData.del(sportName: item.value(forKey: "sportName") as! String, leagueID: item.value(forKey: "leagueID") as! Int, teamName: item.value(forKey: "teamName") as! String)   // delete item from coreData
                tableView.deleteRows(at: [indexPath], with: UITableView.RowAnimation.automatic)
                //self.favTable.reloadData()
            }
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel)
        
        // Add the actions
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        // Present the controller
        self.present(alert, animated: true)

    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let teamDetails = self.storyboard?.instantiateViewController(withIdentifier: "TeamDetailsViewController") as! TeamDetailsViewController

        teamDetails.sport = favArray[indexPath.row].value(forKey: "sportName") as! String
        teamDetails.leagueID = favArray[indexPath.row].value(forKey: "leagueID") as! Int
        teamDetails.teamName = favArray[indexPath.row].value(forKey: "teamName") as! String
        teamDetails.teamLogo = favArray[indexPath.row].value(forKey: "teamLogo") as! String
        teamDetails.PlayersDetails = favArray[indexPath.row].value(forKey: "players") as! [player]

        self.navigationController?.pushViewController(teamDetails, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

}
