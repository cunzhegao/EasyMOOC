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
        
        tabBar.barTintColor = UIColor.white
        
        
        setupController()
    }
    
    func setupController() {
        
        let layout = UICollectionViewFlowLayout()
        let homeController = HomeViewController(collectionViewLayout: layout)
        homeController.navigationItem.title = "首页"
        let firstNaviController = UINavigationController(rootViewController: homeController)
        firstNaviController.title = "主首页"
        firstNaviController.tabBarItem.image = #imageLiteral(resourceName: "home-7")
        //firstNaviController.tabBarItem.imageInsets = UIEdgeInsetsMake(1, 1, 1, 1)
        firstNaviController.navigationBar.barStyle = .black
        firstNaviController.navigationBar.barTintColor = Constant.fbBlue
        firstNaviController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        
        let searchController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "search") as? SearchController
        searchController?.navigationItem.title = "搜索课程"
        let secondNaviController = UINavigationController(rootViewController:searchController!)
        secondNaviController.title = "搜索课程"
        secondNaviController.tabBarItem.image = #imageLiteral(resourceName: "search-7")
        // secondNaviController.tabBarItem.imageInsets = UIEdgeInsetsMake(1.5, 1.5, 1.5, 1.5)
        secondNaviController.navigationBar.barStyle = .black
        secondNaviController.navigationBar.barTintColor = Constant.fbBlue
        secondNaviController.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        
        
        let userController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "profile") as! UserViewController
        userController.navigationItem.title = "用户信息"
        let thirdNaviController = UINavigationController(rootViewController: userController)
        thirdNaviController.title = "用户信息"
        thirdNaviController.tabBarItem.image = #imageLiteral(resourceName: "circle-user-7")
        //  thirdNaviController.tabBarItem.imageInsets = UIEdgeInsetsMake(1.5, 1.5, 1.5, 1.5)
        thirdNaviController.navigationBar.barStyle = .black
        
        
        viewControllers = [firstNaviController,secondNaviController,thirdNaviController]
    }
    
    func logout() {
        
        dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}
