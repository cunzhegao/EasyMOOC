//
//  AnswerController.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/19.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class AnswerController: UITableViewController {

    let headerCellId = "questionHeader"
    let answerCellId = "answer"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "添加回答", style: .plain, target: self, action: #selector(answer))
        
        let headerCell = UINib(nibName: "QuestionHeaderCell", bundle: nil)
        tableView.register(headerCell.self, forCellReuseIdentifier: headerCellId)
        let answerCell = UINib(nibName: "AnswerCell", bundle: nil)
        tableView.register(answerCell.self, forCellReuseIdentifier: answerCellId)
    }

    func answer() {
        let answerQuestionView = UINib(nibName: "AnswerQuestionView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AnswerQuestionView
        answerQuestionView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 400)
        view.addSubview(answerQuestionView)
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            answerQuestionView.frame = CGRect(x: 0, y: -20, width: self.view.frame.width, height: 420)
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            answerQuestionView.answer.becomeFirstResponder()
        }) { (_) in
            
        }
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        }
        return 5
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerCellId, for: indexPath)
            cell.selectionStyle = .none
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: answerCellId, for: indexPath)
        cell.selectionStyle = .none
        return cell
        
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 1 {
            return 40
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == 1 {
            let lable = UILabel(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
            lable.text = "     全部回答"
            lable.font = UIFont.systemFont(ofSize: 12)
            lable.backgroundColor = UIColor(r: 226, g: 226, b: 226)
            lable.textColor = UIColor(white: 0.5, alpha: 1.0)
            return lable
        }
        
        return nil
    }
    
}
