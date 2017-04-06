//
//  CreateCourseController.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/12.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class CreateCourseController: UIViewController {
    
    var navTitle: String?
    var pickerVC =  UIImagePickerController()
    var uploadTag:Int = 0
    @IBOutlet weak var tfCourseName: UITextField!
    @IBOutlet weak var tfTeacherName: UITextField!
    @IBOutlet weak var tfCollegeName: UITextField!
    @IBOutlet weak var tfCourseType: UITextField!
    @IBOutlet weak var tfCourseInfo: UITextField!
    @IBOutlet weak var btnCover: UIButton!
    @IBOutlet weak var btnIcon: UIButton!
    @IBOutlet weak var imgCover: UIImageView!
    @IBOutlet weak var imgIcon: UIImageView!
    
    @IBAction func createCourse(_ sender: Any) {
        if tfCourseName.text == "" || tfTeacherName.text == ""  || tfCollegeName.text == ""  || tfCourseType.text == ""  || tfCourseInfo.text == "" || imgCover.image == nil || imgIcon.image == nil {
            Constant.aler(with: "请完整填写各项信息并上传对应照片", title: "提示")
        }
        
        var cover = imgCover.image
        if (cover?.size.width)! / (cover?.size.height)! < 375 / 211 {
            cover = Constant.cropImage(imageToCrop: cover!)
        }
        
        Constant.saveImg(courseName: tfCourseName.text! , imgCover: cover!, imgIcon: imgIcon.image!)
        
        let course = Course(courseName: tfCourseName.text!, teacherName: tfTeacherName.text!, collegeName: tfCollegeName.text!, type: tfCourseType.text!, info: tfCourseInfo.text!)
        HttpManager.createCourse(course: course) { result in
            if result == "success" {
                _ = self.navigationController?.popViewController(animated: true)
                Constant.aler(with: "成功创建课程", title: "")
            }
        }
    
    }
    
    @IBAction func uploadImage(_ sender: UIButton) {
        pickerVC.allowsEditing = false
        pickerVC.sourceType = .photoLibrary
        uploadTag = sender.tag
        present(pickerVC, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerVC.delegate = self
        btnCover.layer.cornerRadius = 5
        btnIcon.layer.cornerRadius = 5
        tfCourseName.delegate = self
        tfTeacherName.delegate = self
        tfCourseType.delegate = self
        tfCollegeName.delegate = self
        tfCourseInfo.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = Constant.fbBlue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.title = navTitle
    }
}

extension CreateCourseController:UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            if uploadTag == 1 {
                imgCover.image = image
            }else {
                imgIcon.image = image
            }
        }
        dismiss(animated: true, completion: nil)
    }
}

extension CreateCourseController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == tfCourseName {
            tfTeacherName.becomeFirstResponder()
        }
        if textField == tfTeacherName {
            tfCollegeName.becomeFirstResponder()
        }
        if textField == tfCollegeName {
            tfCourseType.becomeFirstResponder()
        }
        if textField == tfCourseType {
            tfCourseInfo.becomeFirstResponder()
        }
        if textField == tfCourseInfo {
            textField.resignFirstResponder()
        }
        
        return true
    }
}
