//
//  CatagoryCell.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/2/19.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class CatagoryCell:UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        backgroundColor = Constant.fbBlue
    }
}
