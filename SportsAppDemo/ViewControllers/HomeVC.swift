//
//  ViewController.swift
//  SportsAppDemo
//
//  Created by Ahmed Shawky on 14/02/2023.
//

import UIKit

class HomeVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showWalkThrough()
        

        print("Test4")
        

        print("Test3")

    }
    
    private func showWalkThrough(){
        if UserDefaults.standard.bool(forKey: "didFinishWalkThrough") != false {
            let walkThroughVC = self.storyboard?.instantiateViewController(withIdentifier: "WalkThroughVC") as! WalkThroughVC
            walkThroughVC.modalPresentationStyle = .overFullScreen
            self.present(walkThroughVC, animated: false)
        }
    }
}

