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

    //MARK: -Login and Register
    @IBAction func login(_ sender: Any) {
        
        if !isStudent && !isTeacher {
            Constant.aler(with: "请选择你的身份", title: "提示")
        }else if userName.text == "" || userPwd.text == "" {
            Constant.aler(with: "账号/密码不能为空", title: "提示")
        }else {
            LCUser.logIn(username: userName.text!, password: userPwd.text!) { (result) in
                switch result {
                    case .success(_):
                        Constant.aler(with: "登陆成功", title: "")
                        break
                    case .failure(let err):
                        Constant.aler(with: "登录失败 \(err)", title: "")
                }
            }
        }
    }
    @IBAction func reigister(_ sender: Any) {
        
        self.navigationController?.navigationBar.isHidden = false
        let rvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "register")
        rvc.title = "用户注册"
        self.navigationController?.pushViewController(rvc, animated: true)
    }
    
    //MARK: -Turn the button green when user select identity
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
    
    //MARK: -Set up UI
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.toolbar.isHidden = true
        userName.delegate = self
        userPwd.delegate = self
        userPwd.isSecureTextEntry = true
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
    
    //MARK: -TextField Delegate
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
