//
//  AskQuestionView.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/19.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class AskQuestionView: UIView, UITextFieldDelegate, UITextViewDelegate {

    
    @IBOutlet weak var questionTitle: UITextField!
    @IBOutlet weak var questionDetail: UITextView!
    
    override func awakeFromNib() {
        questionTitle.delegate = self
        questionDetail.delegate = self
    }
    
    @IBAction func cancle(_ sender: Any) {
        self.removeFromSuperview()
        if let topNav = UIApplication.topViewController()?.navigationController {
            topNav.setNavigationBarHidden(false, animated: true)
        }
    }
    
    
    @IBAction func ask(_ sender: Any) {
        
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "问题具体描述" {
            textView.text = ""
            textView.textColor = UIColor(white: 0.1, alpha: 1)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "问题具体描述"
            textView.textColor = UIColor(r: 200, g: 200, b: 200)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        questionDetail.becomeFirstResponder()
        return true
    }
}
