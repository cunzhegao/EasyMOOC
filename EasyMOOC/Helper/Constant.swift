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
    static let selectedGreen = UIColor(red: 83, green: 215, blue: 105)
    static let backgroundBlue = UIColor(red: 81, green: 187, blue: 248)
    
    static var isLogin = false
    static var currentUser = ""
    
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
