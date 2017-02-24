//
//  CourseCell.swift
//  EasyMOOC
//
//  Created by 高存折 on 2017/2/5.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit
import LeanCloud
import Alamofire

class CourseCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var university: UILabel!
    @IBOutlet weak var teacher: UILabel!
    
    var course:LCObject? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        print(course!)
        
        
        thumbnail.contentMode = .scaleAspectFit
        guard let dic = (course?.get("thumbnail") as! LCDictionary).jsonValue as? NSDictionary else {return}
        let url = dic.value(forKey: "url") as? String
        let imageURL = URL(string: url!)
        let request  =  try! URLRequest(url: imageURL!, method: .get)
        
        Alamofire.request(request).response { (response) in
            
            let image = UIImage(data: response.data!)
            DispatchQueue.main.async {
                self.thumbnail.image = image
            }
        }
        
        //thumbnail.image = #imageLiteral(resourceName: "search-7")
        courseName.text = (course?.get("courseName") as! LCString).stringValue
        university.text = (course?.get("university") as! LCString).stringValue
        teacher.text = (course?.get("teacher") as! LCString).stringValue
        setNeedsDisplay()
    }
}
