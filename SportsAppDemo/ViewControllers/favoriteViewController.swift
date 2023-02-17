//
//  favoriteViewController.swift
//  SportsAppDemo
//
//  Created by Bassant on 17/02/2023.
//

import UIKit

class favoriteViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var sport = ""
    var favArray: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        favTable.delegate = self
        favTable.dataSource = self
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = favTable.dequeueReusableCell(withIdentifier: "favCell") as! favoriteCell
        
        return cell
    }
    

    
    @IBOutlet weak var favTable: UITableView!
    
    
    
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
