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
    var isLike:Bool = false
    var course:LCObject?
    
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
    
    func configInfo() {
        guard let course = course else {return}
        
        imgHeader.contentMode = .scaleAspectFill
        guard let headerDic = (course.get("thumbnail") as! LCDictionary).jsonValue as? NSDictionary else {return}
        let headerUrl = headerDic.value(forKey: "url") as? String
        HttpManager.fetchImage(url: headerUrl!) { image in
            self.imgHeader.image = image
        }
        
        imgCollege.contentMode = .scaleAspectFill
        guard let collegeDic = (course.get("collegeImg") as! LCDictionary).jsonValue as? NSDictionary else {return}
        let collegeUrl = collegeDic.value(forKey: "url") as? String
        HttpManager.fetchImage(url: collegeUrl!) { image in
            self.imgCollege.image = image
        }
        
        collegeName.text = (course.get("university") as! LCString).stringValue
        teacherName.text = (course.get("teacher") as! LCString).stringValue
        courseName.text = (course.get("courseName") as! LCString).stringValue
        courseInfo.text = (course.get("info") as! LCString).stringValue

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }

}
