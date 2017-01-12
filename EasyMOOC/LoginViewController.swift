//
//  LoginViewController.swift
//  EasyMOOC
//
//  Created by 高存折 on 2017/1/9.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit
import LeanCloud

class LoginViewController: UIViewController,UITextFieldDelegate {

    var isStudent = false
    var isTeacher = false
    
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPwd: UITextField!
    @IBOutlet weak var teacher: UIButton!
    @IBOutlet weak var student: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var register: UIButton!

    @IBAction func login(_ sender: Any) {
        
        if !isStudent && !isTeacher {
            Constant.aler(with: "请选择你的身份", title: "提示")
        }
    }
    @IBAction func reigister(_ sender: Any) {
        
    }
    @IBAction func selectStudent(_ sender: UIButton) {
        student.backgroundColor = Constant.selectedGreen
        isStudent = true
        teacher.backgroundColor = UIColor.clear
        isTeacher = false
    }
    @IBAction func selectTeacher(_ sender: UIButton) {
        teacher.backgroundColor = Constant.selectedGreen
        isTeacher = true
        student.backgroundColor = UIColor.clear
        isStudent = false
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.view.alpha = 0.9
        userName.delegate = self
        userPwd.delegate = self
        userName.placeholder = "账号..."
        userPwd.placeholder  = "密码..."
        //make the button round
        student.layer.cornerRadius = 0.5 * student.bounds.size.width
        student.clipsToBounds = true
        teacher.layer.cornerRadius = 0.5 * teacher.bounds.size.width
        teacher.clipsToBounds = true
        
        student.layer.borderWidth = 1
        student.layer.borderColor = UIColor.gray.cgColor
        teacher.layer.borderWidth = 1
        teacher.layer.borderColor = UIColor.gray.cgColor
        
        loginButton.backgroundColor = Constant.selectedGreen
        loginButton.layer.cornerRadius = 10
        register.backgroundColor = Constant.selectedGreen
        register.layer.cornerRadius = 10
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == userName {
            userPwd.becomeFirstResponder()
        }else {
            userPwd.resignFirstResponder()
            self.login(self)
        }
        
        return true
    }
    
        

}
