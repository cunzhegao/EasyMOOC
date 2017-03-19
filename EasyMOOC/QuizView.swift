//
//  QuizView.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/17.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class QuizView: UIView {
    
    
    
    
    @IBOutlet weak var btnTest: UIButton!
    
    @IBAction func test(_ sender: Any) {
        
        
    }
    
    @IBAction func standard(_ sender: Any) {
        let filePath = Bundle.main.path(forResource: "standard", ofType: ".pdf")
        let webVC = WebController()
        webVC.filePath = filePath
        if let topNav = UIApplication.topViewController()?.navigationController {
            topNav.pushViewController(webVC, animated: true)
        }
    }
    
    override func awakeFromNib() {
        btnTest.layer.cornerRadius = 10
    }
}
