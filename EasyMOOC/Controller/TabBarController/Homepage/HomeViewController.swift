//
//  HomeViewController.swift
//  EasyMOOC
//
//  Created by 高存折 on 2017/2/5.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class HomeViewController: UICollectionViewController,UICollectionViewDelegateFlowLayout {

    let cellId = "catagoryCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(CatagoryCell.self, forCellWithReuseIdentifier: cellId)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CatagoryCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 330)
    }
}
