//
//  QuestionCell.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/19.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class QuestionCell: UITableViewCell {

    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var answerCount: UILabel!
    @IBOutlet weak var time: UILabel!
    var question: Question? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI() {
        title.text = question?.title
        answerCount.text = String(format: "%d", (question?.answerCount)!)
        time.text = question?.time
    }
}
