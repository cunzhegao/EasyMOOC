//
//  userInfo.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/11.
//  Copyright © 2017年 高存折. All rights reserved.
//

import Foundation
import LeanCloud

struct UserInfo {
    
    let userName: String
    let objectID: String
    let identity: Identity
    
    init(withObject user: LCUser) {
        userName = (user.username?.stringValue)!
        let id = (user.value(forKey: "identity") as! LCString).stringValue!
        identity = id == "student" ? .student : .teacher
        objectID = (user.objectId?.stringValue)!
        
    }
    
    enum Identity: Int {
        case student = 0
        case teacher
    }
}
