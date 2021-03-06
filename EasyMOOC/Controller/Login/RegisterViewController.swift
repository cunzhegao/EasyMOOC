//
//  RegisterViewController.swift
//  EasyMOOC
//
//  Created by 高存折 on 2017/1/12.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController,UITextFieldDelegate {
    
    
    @IBOutlet weak var userName: UITextField!
    @IBOutlet weak var userPwd: UITextField!
    @IBOutlet weak var identity: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    @IBAction func register(_ sender: Any) {
        if userName.text == "" || userPwd.text == "" {
            Constant.aler(with: "账号/密码 不能为空", title: "提示")
        }else {
            HttpManager.register(userName: userName.text!, userPwd: userPwd.text!, identity: identity.text!) {  result in
                if result == "success" {
                    Constant.aler(with: "注册成功", title: "")
                    self.dismiss(animated: true, completion: nil)
                }else {
                    Constant.aler(with: "注册失败,该账户已存在", title: "")
                }
            }
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.barTintColor = Constant.fbBlue
        navigationController?.navigationBar.tintColor    = UIColor.white
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        
        userPwd.isSecureTextEntry = true
        userName.placeholder = " 账号"
        userPwd.placeholder  = " 密码"
        identity.placeholder = " 学生/教师"
        userName.delegate = self
        userPwd.delegate = self
        identity.delegate = self
        userName.layer.cornerRadius = 5
        userPwd.layer.cornerRadius = 5
        identity.layer.cornerRadius = 5
        registerButton.layer.cornerRadius = 5
        userName.backgroundColor = UIColor.white
        userPwd.backgroundColor = UIColor.white;
        identity.backgroundColor = UIColor.white;
        userName.autocorrectionType = .no
        registerButton.backgroundColor = UIColor(r: 226, g: 226, b: 226)
        registerButton.isEnabled = false
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == userName {
            userPwd.becomeFirstResponder()
        }else if textField == userPwd {
            identity.becomeFirstResponder()
        }else {
            identity.resignFirstResponder()
            register(self)
        }
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if userPwd.text != "" && userName.text != "" && identity.text != ""{
            registerButton.backgroundColor = Constant.fbBlue
            registerButton.isEnabled = true
        }else {
            registerButton.backgroundColor = UIColor(r: 226, g: 226, b: 226)
            registerButton.isEnabled = false
        }
        
        return true
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
}
