//
//  HomeViewController.swift
//  EasyMOOC
//
//  Created by 高存折 on 2017/2/5.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.red
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(title: " 登出", style: .plain, target: self.tabBarController, action: #selector(MainTabBarViewController.logout))
    }

}
