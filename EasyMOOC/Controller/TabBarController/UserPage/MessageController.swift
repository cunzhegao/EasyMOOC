//
//  MessageController.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/17.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class MessageController: UITableViewController {

    let cellID = "message"
    var navTitle: String?
    let times = ["15:59","10:20","3天前","1周前"]
    let titles = ["Objective-c 课程更新了","讨论区有新回复","西藏历史与文化 课程更新了","动物与中国文化 课程更新了"]
    let infos = ["你参与的斯坦福大学的 Objective-c iPhone App软件设计课程更新了，赶快来看看吧！","你在讨论区发布的‘请问这个题怎么解’帖子有新的回答，点击查看！",
                 "你参与的四川大学的西藏历史与文化课程更新了，赶快来看看吧","你参与的东北林业大学的动物与中国文化课程更新了，赶快来看看吧！"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let msgCell = UINib(nibName: "MessageCell", bundle: nil)
        tableView.register(msgCell.self, forCellReuseIdentifier: cellID)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = Constant.fbBlue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationItem.title = navTitle
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! MessageCell
        cell.selectionStyle = .none
        cell.time.text = times[indexPath.row]
        cell.title.text = titles[indexPath.row]
        cell.info.text = infos[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
