//
//  MainTabBarViewController.swift
//  EasyMOOC
//
//  Created by 高存折 on 2017/2/5.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //set three navigationcontroller as root controller of tabbarcontroller
        let homeController = HomeViewController()
        homeController.navigationItem.title = "主页"
        let firstNaviController = UINavigationController(rootViewController: homeController)
        firstNaviController.title = "主页"
        firstNaviController.tabBarItem.image = #imageLiteral(resourceName: "home-7")
        
        let searchController = SearchController()
        searchController.navigationItem.title = "搜索课程"
        let secondNaviController = UINavigationController(rootViewController:searchController)
        secondNaviController.title = "搜索课程"
        secondNaviController.tabBarItem.image = #imageLiteral(resourceName: "search-7")
        
        let userController = UserViewController()
        userController.navigationItem.title = "用户信息"
        let thirdNaviController = UINavigationController(rootViewController: userController)
        thirdNaviController.title = "用户信息"
        thirdNaviController.tabBarItem.image = #imageLiteral(resourceName: "circle-user-7")
        
        self.viewControllers = [firstNaviController,secondNaviController,thirdNaviController]
    }
}
