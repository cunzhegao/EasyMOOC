//
//  AnswerQuestionView.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/19.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class AnswerQuestionView: UIView, UITextViewDelegate {

    
    @IBOutlet weak var answer: UITextView!
    

    @IBAction func cancel(_ sender: Any) {
        self.removeFromSuperview()
        if let topNav = UIApplication.topViewController()?.navigationController {
            topNav.setNavigationBarHidden(false, animated: true)
        }
    }
    
    @IBAction func submit(_ sender: Any) {
        
    }

    
    override func awakeFromNib() {
        answer.delegate = self
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == "填写回答内容" {
            textView.text = ""
            textView.textColor = UIColor(white: 0.1, alpha: 1)
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "填写回答内容"
            textView.textColor = UIColor(r: 200, g: 200, b: 200)
        }
        
    }

}
