//
//  SearchController.swift
//  EasyMOOC
//
//  Created by 高存折 on 2017/2/5.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit
import LeanCloud

class SearchController: UITableViewController {
    
    let cellId = "course"
    let searchController = UISearchController(searchResultsController: nil)
    var courses:[Course]? {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.barTintColor = Constant.fbBlue
        searchController.searchBar.tintColor = UIColor.white
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "课程名、学校、教师"
        
        let lineView = UIView(frame: CGRect(x: 0, y: 0, width: 375, height: 1))
        lineView.backgroundColor = Constant.fbBlue
        tableView.addSubview(lineView)
        tableView.tableHeaderView = searchController.searchBar
        
        let cellNib = UINib(nibName: "CourseCell", bundle: nil)
        tableView.register(cellNib, forCellReuseIdentifier: "course")
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        tabBarController?.tabBar.isHidden = false
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
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
    

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
}

extension SearchController: UISearchResultsUpdating,UISearchBarDelegate {

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchText = searchBar.text ?? ""
        if searchText == "" {
            return
        }
        searchBar.resignFirstResponder()
        searchController.dismiss(animated: true, completion: nil)
        HttpManager.searchCourses(searchText: searchText) { courses in
            self.courses = courses
        }
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "updating empty")
    }
    
}
