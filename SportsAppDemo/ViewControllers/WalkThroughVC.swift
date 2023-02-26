//
//  WalkThroughVC.swift
//  SportsAppDemo
//
//  Created by Ahmed Shawky on 15/02/2023.
//

import UIKit

class WalkThroughVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var skipBtn: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
    
    let walkthroughData = [walkThroughModel(title: "View your Favorite Leagues",
                                            desc: "Our application lets you view the details of your favorite leagues and players.", img: "WalkThrough-1"),
                           walkThroughModel(title: "Save your Favorite Teams",
                                            desc: "You can save your favorite teams to your phone by clicking the star icon.", img: "WalkThrough-2"),
                           walkThroughModel(title: "Get the latest update",
                                            desc: "You can get updates on the latest matches, upcoming matches and details about the score right from the app.", img: "WalkThrough-3")]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI(){
        setupCells()
        pageControl.layer.cornerRadius = 7.5
    }
    
    func setupCells(){
        collectionView.register(UINib(nibName: "WalkThroughCell", bundle: nil), forCellWithReuseIdentifier: "WalkThroughCell")

    }
    
    
    @IBAction func didClickSkip(_ sender: Any) {
        UserDefaults.standard.setValue(true, forKey: "didFinishWalkThrough")
        self.dismiss(animated: true)
    }
    
}

extension WalkThroughVC:UICollectionViewDataSource{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return walkthroughData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "WalkThroughCell", for: indexPath) as! WalkThroughCell
        
        cell.configureCell(walkthroughData[indexPath.row])
        
        return cell
    }
}

extension WalkThroughVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let index = (scrollView.contentOffset.x) / (scrollView.frame.width)
        pageControl.currentPage = Int(index)
        if pageControl.currentPage == pageControl.numberOfPages - 1{
            skipBtn.setTitle("Continue", for: .normal)
        } else{
            skipBtn.setTitle("Skip", for: .normal)
        }
    }
}
