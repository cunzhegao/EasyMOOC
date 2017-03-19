//
//  ItemCell.swift
//  EasyMOOC
//
//  Created by 高存折 on 2017/2/22.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit
import LeanCloud
import Alamofire

class ItemCell: UICollectionViewCell {
    
    var course: Course? {
        didSet {
            setupView()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView:UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "e-course")
        iv.contentMode = .scaleAspectFit
        iv.layer.cornerRadius = 5
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let courseName: UILabel = {
        let label  = UILabel()
        label.textColor = UIColor(white: 0, alpha: 0.9)
        label.font = UIFont.systemFont(ofSize: 12)
        return label
    }()
    
    let universityName: UILabel = {
        let label  = UILabel()
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
        
        courseName.text = course?.courseName
        universityName.text = course?.collegeName
        let imageUrl = course?.thumnailUrl
        
        guard let url = imageUrl  else {return}
        
        HttpManager.fetchImage(url: url) { image in
            self.imageView.image = image
        }
        
        
    }
}
