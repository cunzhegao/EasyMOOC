//
//  QuestionHeaderCell.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/19.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class QuestionHeaderCell: UITableViewCell {

    
    
    @IBOutlet weak var questionTile: UILabel!
    @IBOutlet weak var questionDetail: UILabel!
    @IBOutlet weak var userIcon: UIImageView!
    @IBOutlet weak var userName: UILabel!
    @IBOutlet weak var time: UILabel!
    var question:  Question? {
        didSet {
            updateUI()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        userIcon.layer.cornerRadius = 0.5 * userIcon.bounds.size.width
        userIcon.clipsToBounds = true
    }
    
    private func updateUI() {
        questionTile.text = question?.title
        questionDetail.text = question?.detail
        userName.text = question?.userName
        time.text = question?.time
    }
}
