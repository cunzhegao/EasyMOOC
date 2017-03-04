//
//  HttpManager.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/3.
//  Copyright © 2017年 高存折. All rights reserved.
//

import Foundation
import Alamofire
import LeanCloud

struct HttpManager {
    
    static func login(userName:String,userPwd:String,completion:@escaping (String) -> Void) {
        
        LCUser.logIn(username: userName, password: userPwd) { (result) in
            switch result {
            case .success(_):
                completion("success")
                break
            case .failure(let err):
                completion(err.reason!)
            }
        }
    }
    
    static func register(userName:String,userPwd:String,identity:String, completion:@escaping (String) -> Void) {
        let registerUser = LCUser()
        registerUser.username = LCString(userName)
        registerUser.password = LCString(userPwd)
        let userIdentity = identity
        registerUser.set("identity", value: userIdentity)
        
        switch registerUser.signUp() {
        case .success:
            completion("success")
            break
        case .failure(_):
            completion("fail")
            break
        }
    }
    
    static func fetchImage(url:String, completion:@escaping (UIImage?) -> Void) {
        let imageURL = URL(string: url)
        let request  =  try! URLRequest(url: imageURL!, method: .get)
        
        Alamofire.request(request).response { (response) in
            
            let image = UIImage(data: response.data!)
            DispatchQueue.main.async {
                completion(image)
            }
        }
    }
    
    static func fetchCourses(catagoryName:String, completion:@escaping ([LCObject]) -> Void) {
        let typeQuery  = LCQuery(className: "Course")
        typeQuery.whereKey("type", .matchedSubstring(catagoryName))
        
        typeQuery.find { result in
            switch result {
            case .success(let searchResult):
                completion(searchResult)
            case .failure(let error):
                print("search fail : \(error.reason)")
            }
        }
    }
    
    static func fetchCourse(courseName:String,completion:@escaping (LCObject) -> Void) {
        let courseQuery = LCQuery(className: "Course")
        courseQuery.whereKey("courseName", .matchedSubstring(courseName))
        
        courseQuery.find { result in
            switch result {
            case .success(let reusltCourse) :
                completion(reusltCourse[0])
            case .failure(let err):
                print("search fail : \(err.reason)")
            }
        }
    }
    
    
}
