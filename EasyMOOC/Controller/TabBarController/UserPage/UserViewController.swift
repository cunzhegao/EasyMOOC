//
//  UserViewController.swift
//  EasyMOOC
//
//  Created by 高存折 on 2017/2/5.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userIcon.layer.cornerRadius = 0.5 * userIcon.bounds.size.width
        userIcon.clipsToBounds = true
        userName.text = Constant.currentUser ?? "Kubrick"
        
        if Constant.isTeacherUser {
            userIcon.image = #imageLiteral(resourceName: "teacherIcon")
            downloadIcon.image = #imageLiteral(resourceName: "teacher")
            downloadLabel.text = "创建课程"
        }
        
        addGesture()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
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
        
        let myCourseVC = MyCourseController()
        navigationController?.pushViewController(myCourseVC, animated: true)
        tabBarController?.tabBar.isHidden = true
    }
    
    func toDownloadHistory() {
        
    }
    
    func toForums() {
        
    }
    
    func toMessageBox() {
        
    }
    
    
}
