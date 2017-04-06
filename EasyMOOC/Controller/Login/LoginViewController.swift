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
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var register: UIButton!
    
    //MARK: -Login and Register
    @IBAction func login(_ sender: Any) {
        
        if userName.text == "" || userPwd.text == "" {
            Constant.aler(with: "账号/密码不能为空", title: "提示")
        }else {
            HttpManager.login(userName: userName.text!,userPwd: userPwd.text!) { result in
                if result == "success" {
                    Constant.isLogin = true
                    let mainVC = MainTabBarViewController()
                    self.present(mainVC, animated: false, completion: nil)
                    Constant.aler(with: "登陆成功", title: "")
                }else {
                    Constant.isLogin = false
                    Constant.aler(with: "登录失败 :\(result)", title: "")
                }
            }
        }
    }
    @IBAction func reigister(_ sender: Any) {
        
        navigationController?.navigationBar.isHidden = false
        let rvc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "register")
        rvc.title = "用户注册"
        navigationController?.pushViewController(rvc, animated: true)
    }
    
    //MARK: -Controller Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

//        let mainVC = MainTabBarViewController()
//        present(mainVC, animated: false, completion: nil)
        
        view.backgroundColor = UIColor.white
        navigationController?.navigationBar.barStyle = .black
        
        userName.delegate = self
        userPwd.delegate = self
        userPwd.isSecureTextEntry = true
        userName.placeholder = " 账号"
        userPwd.placeholder  = " 密码"
        userName.backgroundColor = UIColor.white
        userPwd.backgroundColor  = UIColor.white
        userName.autocorrectionType = .no

        loginButton.backgroundColor = UIColor(r: 226, g: 226, b: 226)
        loginButton.isEnabled = false
        loginButton.layer.cornerRadius = 5
        register.backgroundColor = UIColor.white
        register.layer.cornerRadius = 5
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
        userName.text = ""
        userPwd.text  = ""
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    //MARK: -TextField Delegate
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == userName {
            userPwd.becomeFirstResponder()
        }else {
            userPwd.resignFirstResponder()
            login(self)
        }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if userPwd.text != "" && userName.text != "" {
            loginButton.backgroundColor = Constant.fbBlue
            loginButton.isEnabled = true
        }else {
            loginButton.backgroundColor = UIColor(r: 226, g: 226, b: 226)
            loginButton.isEnabled = false
        }
        
        return true
    }
    
}
