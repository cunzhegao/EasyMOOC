//
//  CourseCell.swift
//  EasyMOOC
//
//  Created by 高存折 on 2017/2/5.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit
import LeanCloud

class CourseCell: UITableViewCell {
   
    let courseName = UILabel()
    let teacher    = UILabel()
    let university = UILabel()
    var thumbnail:UIImageView?
    
    init(with course:LCObject) {
        super.init(style: .default, reuseIdentifier: "course")
        
        courseName.text = (course.get("courseName") as! LCString).stringValue
        teacher.text = (course.get("teacher") as! LCString).stringValue
        university.text = (course.get("university") as! LCString).stringValue
        
        self.addSubview(courseName)
        self.addSubview(teacher)
        self.addSubview(university)
        //self.addSubview(thumbnail)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
