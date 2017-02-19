//
//  Constant.swift
//  EasyMOOC
//
//  Created by 高存折 on 2017/1/12.
//  Copyright © 2017年 高存折. All rights reserved.
//

import Foundation
import UIKit

struct Constant {
    
    //UI Element Color
    static let selectedGreen = UIColor(r: 83, g: 215, b: 105)
    static let fbBlue = UIColor(r: 61, g: 91, b: 151)
    static let btnBlue = UIColor(r: 80, g: 101, b: 161)
    
    static var isLogin = false
    static var currentUser:String?
    static var isTeacherUser = false
    
    static var thumbnails:[String : UIImage]?
    
    static func aler(with msg:String,title:String){
        
        let alerWindow = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alerWindow.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) in
            alerWindow.dismiss(animated: true, completion: nil)
        }))
        
        let vc = UIApplication.topViewController()
        vc?.present(alerWindow, animated: true, completion: nil)
    }
}
