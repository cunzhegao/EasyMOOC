//
//  UserViewController.swift
//  EasyMOOC
//
//  Created by 高存折 on 2017/2/5.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit
import LeanCloud

class UserViewController: UIViewController,UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var myCourseCell: UIView!
    @IBOutlet weak var downloadCell: UIView!
    @IBOutlet weak var forumsCell: UIView!
    @IBOutlet weak var messageCell: UIView!
    @IBOutlet weak var exitCell: UIView!
    @IBOutlet weak var downloadIcon: UIImageView!
    @IBOutlet weak var downloadLabel: UILabel!
    @IBOutlet weak var badge: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIcon.layer.cornerRadius = 0.5 * userIcon.bounds.size.width
        userIcon.clipsToBounds = true
        userName.text = Constant.currentUser?.userName
        badge.layer.cornerRadius = 0.5 * badge.bounds.size.width
        
//        if Constant.currentUser?.identity == .teacher {
            userIcon.image = #imageLiteral(resourceName: "teacherIcon")
            downloadIcon.image = #imageLiteral(resourceName: "teacher")
            downloadLabel.text = "创建课程"
//        }
        
        addGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    func addGesture() {
        myCourseCell.tag = 1
        downloadCell.tag = 2
        forumsCell.tag   = 3
        messageCell.tag  = 4
        exitCell.tag     = 5
        
        myCourseCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toMyCourse)))
        downloadCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toDownloadHistory)))
        forumsCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toForums)))
        messageCell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toMessageBox)))
        exitCell.addGestureRecognizer(UITapGestureRecognizer(target: self.tabBarController, action: #selector(MainTabBarViewController.logout)))
    }
    
    
    
    func toMyCourse() {
        HttpManager.fetchCourses(relationKey: "myCourses") { result in
            let myCourseVC = MyCourseController()
            myCourseVC.courses = result
            myCourseVC.navTitle = "我的课程"
            self.navigationController?.pushViewController(myCourseVC, animated: true)
            self.tabBarController?.tabBar.isHidden = true
            
        }
    }
    
    func toDownloadHistory() {
        if downloadLabel.text == "下载记录" {
            HttpManager.fetchCourses(relationKey: "myCourses") { result in
                let myCourseVC = MyCourseController()
                myCourseVC.courses = result
                myCourseVC.navTitle = "下载记录"
                self.navigationController?.pushViewController(myCourseVC, animated: true)
                self.tabBarController?.tabBar.isHidden = true
                
            }
        }else {
            let createVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "create") as! CreateCourseController
            createVC.navTitle = "创建课程"
            self.navigationController?.pushViewController(createVC, animated: true)
            self.tabBarController?.tabBar.isHidden = true

        }
    }
    
    func toForums() {
        let forumVC = ForumController()
        forumVC.navTitle = "讨论区"
        navigationController?.pushViewController(forumVC, animated: true)
        tabBarController?.tabBar.isHidden = true
    }
    
    func toMessageBox() {
        let msgVC = MessageController()
        msgVC.navTitle = "消息中心"
        navigationController?.pushViewController(msgVC, animated: true)
        tabBarController?.tabBar.isHidden = true
    }
    
    
}
