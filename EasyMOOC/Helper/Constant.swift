//
//  Constant.swift
//  EasyMOOC
//
//  Created by 高存折 on 2017/1/12.
//  Copyright © 2017年 高存折. All rights reserved.
//

import Foundation
import UIKit
import LeanCloud

struct Constant {
    
    //UI Element Color
    static let selectedGreen = UIColor(r: 83, g: 215, b: 105)
    static let fbBlue = UIColor(r: 61, g: 91, b: 151)
    static let btnBlue = UIColor(r: 80, g: 101, b: 161)
    
    static var isLogin = false
    static var currentUser:UserInfo?
    static var lcuser: LCUser?
    
    static func cropImage(imageToCrop:UIImage) -> UIImage {
        let width = imageToCrop.size.width
        let ratio:CGFloat = 375/211
        let height = width / ratio
        let yPosition = imageToCrop.size.height / 2 - height / 2
        let rect = CGRect(x: 0, y: yPosition, width: width, height: height)
        
        let cgImage = imageToCrop.cgImage?.cropping(to: rect)
        let croppedImage = UIImage(cgImage: cgImage!)
        return croppedImage
    }
    
    static func saveImg(courseName:String, imgCover:UIImage, imgIcon:UIImage) {
        let coverData = UIImageJPEGRepresentation(imgCover, 0.5)
        let iconData  = UIImageJPEGRepresentation(imgIcon, 1.0)
        UserDefaults.standard.set(coverData, forKey: courseName + "cover")
        UserDefaults.standard.set(iconData, forKey: courseName + "icon")
    }
    
    static func getImg(courseName:String) -> [UIImage]? {
        guard let coverData = UserDefaults.standard.value(forKey: courseName + "cover") as? Data else {return nil}
        guard let iconData  = UserDefaults.standard.value(forKey: courseName + "icon") as? Data else {return nil}
        var images = [UIImage]()
        images.append(UIImage(data: coverData)!)
        images.append(UIImage(data: iconData)!)
        return images
    }
    
    static func aler(with msg:String,title:String){
        
        let alerWindow = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        alerWindow.addAction(UIAlertAction(title: "确定", style: .default, handler: { (_) in
            alerWindow.dismiss(animated: true, completion: nil)
        }))
        
        let vc = UIApplication.topViewController()
        vc?.present(alerWindow, animated: true, completion: nil)
    }
    
    static func addShadowView() {
        
    }
    
    static func removeShadowView() {
        
    }
}
