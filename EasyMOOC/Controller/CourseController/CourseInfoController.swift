//
//  CourseInfoController.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/4.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit
import LeanCloud

class CourseInfoController: UIViewController {
    
    
    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var imgTeacher: UIImageView!
    @IBOutlet weak var imgCollege: UIImageView!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var collegeName: UILabel!
    @IBOutlet weak var teacherName: UILabel!
    @IBOutlet weak var btnLike: UIButton!
    @IBOutlet weak var courseInfo: UITextView!
    @IBOutlet weak var btnJoin: UIButton!
    var isLike:Bool = false
    var course:Course?
    
    @IBAction func back(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func like(_ sender: Any) {
        if isLike {
            isLike = false
            btnLike.setImage(#imageLiteral(resourceName: "like"), for: .normal)
        }else {
            isLike = true
            btnLike.setImage(#imageLiteral(resourceName: "likeFill"), for: .normal)
        }
    }
    
    
    @IBAction func share(_ sender: Any) {
        
    }
    
    
    @IBAction func joinCourse(_ sender: Any) {
//        if btnJoin.titleLabel?.text == "开始学习" {
//            let playerVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "player") as! VideoPlayerController
//            navigationController?.pushViewController(playerVC, animated: true)
//        }else {
//            let couserToInsert = LCObject(className: "Course", objectId: (course?.objectID)!)
//            Constant.lcuser?.insertRelation("myCourses", object: couserToInsert)
//            Constant.lcuser?.save() { result in
//                switch result {
//                case .success:
//                    self.btnJoin.setTitle("开始学习", for: .normal)
//                    Constant.aler(with: "成功加入课程", title: "")
//                case .failure(let error):
//                    Constant.aler(with: "加入课程失败：\(error)", title: "")
//                }
//            }
//        }
        
        let playerVC = VideoPlayerController()
        navigationController?.pushViewController(playerVC, animated: true)

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        imgTeacher.layer.cornerRadius = imgTeacher.frame.width * 0.5
        imgTeacher.clipsToBounds = true
        imgCollege.layer.cornerRadius = imgCollege.frame.width * 0.5
        imgCollege.clipsToBounds = true
        
        configInfo()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    func configInfo() {
        guard let course = course else {return}
        
        imgHeader.contentMode = .scaleAspectFill
        if let url = course.thumnailUrl {
            HttpManager.fetchImage(url: url) { image in
                self.imgHeader.image = image
            }
        }else {
            imgHeader.image = Constant.getImg(courseName: course.courseName)?[0]
        }

        
        imgCollege.contentMode = .scaleAspectFill
        if let url2 = course.collegeImgUrl {
            HttpManager.fetchImage(url: url2) { image in
                self.imgCollege.image = image
            }
        }else {
            imgCollege.image = Constant.getImg(courseName: course.courseName)?[1]
        }

        collegeName.text = course.collegeName
        teacherName.text = course.teacherName
        courseName.text = course.courseName
        courseInfo.text = course.info
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
