//
//  MessageCell.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/17.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class MessageCell: UITableViewCell {

    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var info: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
