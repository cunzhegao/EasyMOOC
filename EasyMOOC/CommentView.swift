//
//  CommentView.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/17.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class CommentView: UIView {
    
    @IBOutlet weak var icon1: UIImageView!
    @IBOutlet weak var icon2: UIImageView!
    @IBOutlet weak var icon3: UIImageView!
    @IBOutlet weak var icon4: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    
    @IBAction func like(_ sender: UIButton) {
        let labels = [label1,label2,label3,label4]
        sender.setImage(#imageLiteral(resourceName: "thumbUpFill"), for: .normal)
        labels[sender.tag - 1]?.text = "1"
    }

    
    
    
    override func awakeFromNib() {
        icon1.layer.cornerRadius = 0.5 * icon1.bounds.size.width
        icon2.layer.cornerRadius = 0.5 * icon2.bounds.size.width
        icon3.layer.cornerRadius = 0.5 * icon3.bounds.size.width
        icon4.layer.cornerRadius = 0.5 * icon4.bounds.size.width
        icon1.clipsToBounds = true
        icon2.clipsToBounds = true
        icon3.clipsToBounds = true
        icon4.clipsToBounds = true
        
    }
}
