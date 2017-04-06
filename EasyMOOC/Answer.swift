//
//  Answer.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/20.
//  Copyright © 2017年 高存折. All rights reserved.
//

import Foundation
import LeanCloud

class Answer: NSObject {
    
    let detail: String
    let userName: String
    let time: String
    let objectID: String?
    
    init(with object:LCObject) {
        detail = (object.get("detail") as! LCString).stringValue!
        userName = (object.get("userName") as! LCString).stringValue!
        time = (object.get("time") as! LCString).stringValue!
        objectID = object.objectId?.stringValue!
    }
    
    init(detail: String, userName: String, time: String) {
        self.detail = detail
        self.userName = userName
        self.time = time
        self.objectID = nil
    }
}
