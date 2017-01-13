//
//  RegisterViewController.swift
//  EasyMOOC
//
//  Created by 高存折 on 2017/1/12.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit
import LeanCloud

class RegisterViewController: UIViewController,UITextFieldDelegate {

    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPwd: UITextField!
    @IBOutlet weak var identity: UITextField!
    
    @IBOutlet weak var registerButton: UIButton!
    @IBAction func register(_ sender: Any) {
        if userName.text == "" || userPwd.text == "" {
            Constant.aler(with: "账号/密码 不能为空", title: "提示")
        }else {
            let registerUser = LCUser()
            registerUser.username = LCString(userName.text!)
            registerUser.password = LCString(userPwd.text!)
            let userIdentity = identity.text
            registerUser.set("identity", value: userIdentity)
            
            switch registerUser.signUp() {
                case .success:
                    Constant.aler(with: "注册成功", title: "")
                    self.dismiss(animated: true, completion: nil)
                    break
                case .failure(_):
                    Constant.aler(with: "注册失败,该账户已存在", title: "")
                    break
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        userPwd.isSecureTextEntry = true
        userName.placeholder = "账号..."
        userPwd.placeholder  = "密码..."
        identity.placeholder = "学生/教师"
        registerButton.layer.cornerRadius = 10
        registerButton.backgroundColor = Constant.selectedGreen
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        self.navigationController?.navigationBar.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == userName {
            userPwd.becomeFirstResponder()
        }else if textField == userPwd {
            identity.becomeFirstResponder()
        }else {
            identity.resignFirstResponder()
            self.register(self)
        }
        return true
    }

}
