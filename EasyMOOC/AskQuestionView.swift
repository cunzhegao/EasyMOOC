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
    weak var owner: ForumController?
    
    override func awakeFromNib() {
        questionTitle.delegate = self
        questionDetail.delegate = self
    }
    
    @IBAction func cancle(_ sender: Any) {
        removeFromSuperview()
        owner?.fetchQuestion()
        owner?.navigationController?.setNavigationBarHidden(false, animated: true)
        owner?.tableView.isScrollEnabled = true
    }
    
    @IBAction func ask(_ sender: Any) {
        let currentTime = NSCalendar.current.dateComponents([.hour,.minute], from: Date())
        let timeString = String(format: "%02d%@%02d", currentTime.hour!, ":", currentTime.minute!)
        let newQuestion =  Question(title: questionTitle.text!, detail: questionDetail.text!, userName: (Constant.currentUser?.userName)!, time: timeString)
        HttpManager.createQuestion(question: newQuestion) { (result) in
            self.cancle(self)
        }
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
