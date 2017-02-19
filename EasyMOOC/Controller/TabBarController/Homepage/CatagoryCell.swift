//
//  CatagoryCell.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/2/19.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class CatagoryCell:UICollectionViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    let cellId = "itemCell"
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let catagoryName: UILabel = {
        let label  = UILabel()
        label.text = "文学历史"
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let moreLabel: UILabel = {
        let label  = UILabel()
        label.text = "查看更多"
        label.textColor = Constant.fbBlue
        label.font = UIFont.systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let dividerLineView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let  courseCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor.clear
        return collectionView
    }()

    
    func setupView() {
        backgroundColor = UIColor.clear
        
        addSubview(courseCollectionView)
        addSubview(catagoryName)
        addSubview(dividerLineView)
        addSubview(moreLabel)
        courseCollectionView.dataSource = self
        courseCollectionView.delegate = self
        courseCollectionView.register(ItemCell.self, forCellWithReuseIdentifier: cellId)
        
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0][v1]-10-|", options: NSLayoutFormatOptions(),
                                                      metrics: nil, views: ["v0" : catagoryName, "v1" : moreLabel]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-10-[v0]|", options: NSLayoutFormatOptions(),
                                                      metrics: nil, views: ["v0" : dividerLineView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-8-[v0]-8-|", options: NSLayoutFormatOptions(),
                                                      metrics: nil, views: ["v0" : courseCollectionView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v1(30)][v2(0.5)][v0]|", options: NSLayoutFormatOptions(),
                                                      metrics: nil, views: ["v0" : courseCollectionView, "v1" : catagoryName, "v2" : dividerLineView]))
        addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v1(30)][v2(0.5)][v0]|", options: NSLayoutFormatOptions(),
                                                      metrics: nil, views: ["v0" : courseCollectionView, "v1" : moreLabel, "v2" : dividerLineView]))
        
    }
    
    //MARK: -CollectionView DataSource
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemCell
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: collectionView.frame.width / 2 - 5, height: collectionView.frame.height / 2 - 20)
    }
    
    
}


//MARK: -Each Course Item in CollectionView
class ItemCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "courseIcon")
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let courseName: UILabel = {
        let label  = UILabel()
        label.text = "遗传与生物分子实验"
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let universityName: UILabel = {
        let label  = UILabel()
        label.text = "东京大学"
        label.textColor = UIColor.gray
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    func setupView() {
        backgroundColor = UIColor.clear
        
        addSubview(imageView)
        addSubview(courseName)
        addSubview(universityName)
        
        imageView.frame = CGRect(x: 0, y: 0, width: frame.width, height: frame.height - 20)
        courseName.frame = CGRect(x: 0, y: frame.height - 20, width: frame.width, height: 10)
        universityName.frame = CGRect(x: 0, y: frame.height - 5, width: frame.width, height: 10)
    }
}
