//
//  SearchController.swift
//  EasyMOOC
//
//  Created by 高存折 on 2017/2/5.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit
import LeanCloud


class SearchController: UITableViewController,UISearchResultsUpdating,UISearchBarDelegate {

    let cellId = "course"
    let searchController = UISearchController(searchResultsController: nil)
    var course:[LCObject]? {
        didSet {
            self.tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(CourseCell.self, forCellReuseIdentifier: cellId)
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.sizeToFit()
        searchController.searchBar.placeholder = "课程名、学校、教师"
        self.tableView.tableHeaderView = searchController.searchBar
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        
//        return 2 //course == nil ? 0 : (course?.count)!
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        
//        let cell = tableView.dequeueReusableCell(withIdentifier: cellId)
//        
//        return cell!
//    }

    //MARK: - Search controller delegate
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        let searchText = searchBar.text ?? ""
        print(searchText)
        searchController.searchBar.resignFirstResponder()
        
        let query = LCQuery(className: "Course")
        query.whereKey("university", .matchedSubstring(searchText))
        query.find { result in
            switch result {
                case .success(let searchResult):
                    self.course = searchResult
                case .failure(let error):
                    print("search fail : \(error.reason)")
            }
        }
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "updating empty")
    }

}
