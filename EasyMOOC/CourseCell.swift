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
        print(self.course!)
        
        let url = (course?.get("thumbnail") as! LCDictionary).value(forKey: "url") as? String
        let imageURL = NSURL(string: url!)
        
        
        //thumbnail.image = #imageLiteral(resourceName: "search-7")
        courseName.text = (course?.get("courseName") as! LCString).stringValue
        university.text = (course?.get("university") as! LCString).stringValue
        teacher.text = (course?.get("teacher") as! LCString).stringValue
        self.setNeedsDisplay()
    }
}
