//
//  MaterialView.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/17.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class MaterialView: UIView {
    let aboutURL = "https://developer.apple.com/library/content/documentation/Cocoa/Conceptual/ProgrammingWithObjectiveC/Introduction/Introduction.html"
    let wikiURL = "https://en.wikipedia.org/wiki/Objective-C?oldformat=true"
    let runtimeURL = "https://developer.apple.com/reference/objectivec/objective_c_runtime"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    @IBAction func loadWebView(_ sender: UIButton) {
        if sender.tag == 1 {
            let webVC = WebController()
            webVC.url = aboutURL
            if let topNav = UIApplication.topViewController()?.navigationController {
                topNav.pushViewController(webVC, animated: true)
            }
        }
        if sender.tag == 2 {
            let webVC = WebController()
            webVC.url = wikiURL
            if let topNav = UIApplication.topViewController()?.navigationController {
                topNav.pushViewController(webVC, animated: true)
            }
        }
        if sender.tag == 3 {
            let filePath = Bundle.main.path(forResource: "Lecture 1", ofType: "pdf")
            let webVC = WebController()
            webVC.filePath = filePath
            if let topNav = UIApplication.topViewController()?.navigationController {
                topNav.pushViewController(webVC, animated: true)
            }
        }
        if sender.tag == 4 {
            let webVC = WebController()
            webVC.url = runtimeURL
            if let topNav = UIApplication.topViewController()?.navigationController {
                topNav.pushViewController(webVC, animated: true)
            }
        }
    }
}
