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
    
    var course: LCObject? {
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
        
        courseName.text = (course?.get("courseName") as! LCString).stringValue
        universityName.text = (course?.get("university") as! LCString).stringValue
        guard let dic = (course?.get("thumbnail") as! LCDictionary).jsonValue as? NSDictionary else {return}
        let url = dic.value(forKey: "url") as? String
        let imageURL = URL(string: url!)
        let request  =  try! URLRequest(url: imageURL!, method: .get)
        
        Alamofire.request(request).response { (response) in
            
            let image = UIImage(data: response.data!)
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
        
    }
}
