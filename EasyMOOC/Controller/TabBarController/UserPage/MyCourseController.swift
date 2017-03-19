//
//  MyCourseController.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/2/18.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class MyCourseController: UITableViewController {
    
    var navTitle: String?
    let cellId = "course"
    var courses:[Course]? {
        didSet {
            tableView.reloadData()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let cellNib = UINib(nibName: "CourseCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "course")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = Constant.fbBlue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.title = navTitle
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return courses == nil ? 0 : (courses?.count)!
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CourseCell
        cell.selectionStyle = .none
        cell.course = courses?[indexPath.row]
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if courses != nil {
            let infoVC = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "info") as! CourseInfoController
            infoVC.course = courses?[indexPath.row]
            let topVC = UIApplication.topViewController()
            topVC?.navigationController?.pushViewController(infoVC, animated: true)
            topVC?.tabBarController?.tabBar.isHidden = true
        }
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
