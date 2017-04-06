//
//  Question.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/20.
//  Copyright © 2017年 高存折. All rights reserved.
//

import Foundation
import LeanCloud

class Question: NSObject {
   
    let title: String
    let detail: String
    let userName: String
    let time: String
    var answerCount: Int = 0
    let objectID: String?
    
    init(with object: LCObject) {
        title = (object.get("title") as! LCString).stringValue!
        detail = (object.get("detail") as! LCString).stringValue!
        userName = (object.get("userName") as! LCString).stringValue!
        time = (object.get("time") as! LCString).stringValue!
        answerCount = (object.get("answerCount") as! LCNumber).intValue!
        objectID = object.objectId?.stringValue!

    }
    
    init(title: String, detail: String, userName: String, time: String) {
        self.title = title
        self.detail = detail
        self.userName = userName
        self.time = time
        self.objectID = nil
    }
}
