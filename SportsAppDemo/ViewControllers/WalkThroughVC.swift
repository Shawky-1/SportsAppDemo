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
    
    
    let walkthroughData = [walkThroughModel(title: "First Title", desc: "First Desc", img: ""),
                           walkThroughModel(title: "Second Title", desc: "Second Label", img: ""),
                           walkThroughModel(title: "Third Title", desc: "Third Desc", img: "")]
    
    
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
            skipBtn.titleLabel?.text = "Continue"
        } else{
            skipBtn.titleLabel?.text = "Skip"
        }
    }
}
