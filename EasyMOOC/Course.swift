//
//  Course.swift
//  EasyMOOC
//
//  Created by 高存折 on 2017/2/5.
//  Copyright © 2017年 高存折. All rights reserved.
//

import Foundation
import LeanCloud

struct Course {
    
    let courseName: String
    let teacherName: String
    let collegeName: String
    let type: String
    let info: String
    let thumnailUrl: String?
    let collegeImgUrl: String?
    let objectID: String?
    
    
    init(withObject course:LCObject) {
        
        let dic1 = (course.get("thumbnail") as? LCDictionary)?.jsonValue as? NSDictionary
        thumnailUrl = dic1?.value(forKey: "url") as? String
        
        let dic2 = (course.get("collegeImg") as? LCDictionary)?.jsonValue as? NSDictionary
        collegeImgUrl = dic2?.value(forKey: "url") as? String
        
        type = (course.get("type") as! LCString).stringValue!
        info = (course.get("info") as! LCString).stringValue!
        teacherName = (course.get("teacher") as! LCString).stringValue!
        collegeName = (course.get("university") as! LCString).stringValue!
        courseName = (course.get("courseName") as! LCString).stringValue!
        objectID = (course.objectId?.stringValue)!
    }
    
    init(courseName:String, teacherName:String, collegeName:String, type:String, info:String) {
        
        self.courseName = courseName
        self.teacherName = teacherName
        self.collegeName = collegeName
        self.type = type
        self.info = info
        self.thumnailUrl = nil
        self.collegeImgUrl = nil
        self.objectID = nil
    }
}
