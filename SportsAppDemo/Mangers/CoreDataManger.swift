//
//  CoreDataManger.swift
//  SportsAppDemo
//
//  Created by Ahmed Shawky on 15/02/2023.
//

import Foundation
import UIKit
import CoreData

class CoreData{
    var context : NSManagedObjectContext?
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    // singleton object
    static let coreDataObj = CoreData()
    private init(){}
    
    func save(sportName:String, leagueID:Int, teamName:String)->Void {
        context = appDelegate.persistentContainer.viewContext
        let sportsEntity = NSEntityDescription.entity(forEntityName: "Sports", in: context!)
        
        let team = NSManagedObject(entity: sportsEntity!, insertInto: context!)
        team.setValue(sportName, forKey: "sportName")
        team.setValue(leagueID, forKey: "leagueID")
        team.setValue(teamName, forKey: "teamName")
        
        try? context?.save()
        print("object saved")
    }

    func fetch()->[NSManagedObject] {
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Sports")
        var teams = try? context?.fetch(fetchReq)
        return teams ?? []
    }
 
    func del(sportName:String, leagueID:Int, teamName:String)->Void {
        let fetchReq = NSFetchRequest<NSManagedObject>(entityName: "Sports")
        let myPredicate = NSPredicate(format: "sportName == %@ AND leagueID == %ld AND teamName == %@", sportName, leagueID, teamName)
        fetchReq.predicate = myPredicate
        let teams = try? context?.fetch(fetchReq)
        
        context?.delete((teams?[0])!)
        try? context?.save()
        print("object deleted")
    }
   
    func itemExists(sportName:String, leagueID:Int, teamName:String) -> Bool {
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Sports")
        fetchRequest.predicate = NSPredicate(format: "sportName == %@ AND leagueID == %ld AND teamName == %@", sportName, leagueID, teamName)
        let results = try? context?.fetch(fetchRequest)
        
        return results?.count ?? 0 > 0
    }
}
