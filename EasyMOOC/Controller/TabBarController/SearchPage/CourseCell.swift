//
//  CourseCell.swift
//  EasyMOOC
//
//  Created by 高存折 on 2017/2/5.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit
import LeanCloud
import Alamofire

class CourseCell: UITableViewCell {
    
    @IBOutlet weak var thumbnail: UIImageView!
    @IBOutlet weak var courseName: UILabel!
    @IBOutlet weak var university: UILabel!
    @IBOutlet weak var teacher: UILabel!
    
    var course: Course? {
        didSet {
            updateUI()
        }
    }
    
    func updateUI() {
        
        
        thumbnail.contentMode = .scaleAspectFit
        let url = course?.thumnailUrl
        guard let imageUrl = url else {print("url is nil");return}
        HttpManager.fetchImage(url: imageUrl) { image in
            self.thumbnail.image = image
        }
        
        
        //thumbnail.image = #imageLiteral(resourceName: "search-7")
        courseName.text = course?.courseName
        university.text = course?.collegeName
        teacher.text = course?.teacherName
        setNeedsDisplay()
    }
}
