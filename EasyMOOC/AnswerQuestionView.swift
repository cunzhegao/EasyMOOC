//
//  AnswerQuestionView.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/19.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit
import LeanCloud

class AnswerQuestionView: UIView, UITextViewDelegate {

    
    @IBOutlet weak var answer: UITextView!
    var question: Question?
    weak var owner: AnswerController?


    @IBAction func cancel(_ sender: Any) {
        self.removeFromSuperview()
        owner?.fetchAnswer()
        owner?.navigationController?.setNavigationBarHidden(false, animated: true)
        owner?.tableView.isScrollEnabled = true
        }
    
    @IBAction func submit(_ sender: Any) {
        let currentTime = NSCalendar.current.dateComponents([.hour,.minute], from: Date())
        let timeString = String(format: "%02d%@%02d", currentTime.hour!, ":", currentTime.minute!)
        let answerToInsert = LCObject(className: "Answer")
        answerToInsert.set("detail", value: answer.text!)
        answerToInsert.set("userName", value: Constant.currentUser?.userName ?? "")
        answerToInsert.set("time", value: timeString)
        
        let questionObject = LCObject(className: "Question", objectId: (question?.objectID)!)
        questionObject.insertRelation("answers", object: answerToInsert)
        
        questionObject.save() { result in
            switch result {
            case .success:
                self.question?.answerCount += 1
                questionObject.set("answerCount", value: self.question?.answerCount)
                _ = questionObject.save()
                self.cancel(self)
            case .failure(let error):
                Constant.aler(with: "回答失败：\(error)， 请尝试重新提交回答", title: "")
            }
        }
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
