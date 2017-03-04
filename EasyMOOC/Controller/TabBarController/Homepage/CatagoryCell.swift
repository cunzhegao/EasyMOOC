//
//  CatagoryCell.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/2/19.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit
import LeanCloud
import Alamofire

class CatagoryCell:UICollectionViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    let cellId = "itemCell"
    
    var courses:[LCObject]?
    var catagory: String? {
        didSet {
            catagoryName.text = catagory
            HttpManager.fetchCourses(catagoryName:catagoryName.text!) { result in
                self.courses = result
                DispatchQueue.main.async {
                    self.courseCollectionView.reloadData()
                }
            }

        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //init property like this call before self.init
    let catagoryName: UILabel = {
        let label  = UILabel()
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
        return courses?.count ??  0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ItemCell
        cell.course = courses?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return  CGSize(width: collectionView.frame.width / 2 - 5, height: collectionView.frame.height / 2 - 20)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let coursrName = (collectionView.cellForItem(at: indexPath) as! ItemCell).courseName.text!
        HttpManager.fetchCourse(courseName: coursrName) { course in
            let infoVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "info") as! CourseInfoController
            infoVC.course = course
            let topVC = UIApplication.topViewController()
            topVC?.navigationController?.pushViewController(infoVC, animated: true)
            topVC?.tabBarController?.tabBar.isHidden = true
        }
    }
    
}

