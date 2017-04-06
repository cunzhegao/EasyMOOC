//
//  ForumController.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/19.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class ForumController: UIViewController {
    
    let cellID = "question"
    var navTitle: String?
    var questions: [Question]?
    
    lazy var searchControl: UISearchController = {
        let sc = UISearchController(searchResultsController: nil)
        sc.searchBar.delegate = self
        sc.searchResultsUpdater = self
        sc.searchBar.sizeToFit()
        sc.searchBar.placeholder = "搜索问题"
        sc.searchBar.showsCancelButton = false
        sc.searchBar.barTintColor = Constant.fbBlue
        sc.dimsBackgroundDuringPresentation = false
        sc.hidesNavigationBarDuringPresentation  = false
        sc.searchBar.translatesAutoresizingMaskIntoConstraints = false
        sc.searchBar.isTranslucent = false
        return sc
    }()
    
    lazy var tableView: UITableView = {
        let view = UITableView()
        view.delegate = self
        view.dataSource = self
        let cell = UINib(nibName: "QuestionCell", bundle: nil)
        view.register(cell.self, forCellReuseIdentifier: self.cellID)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        
        searchControl.searchBar.frame = CGRect(x: 0, y: 0, width: 300, height: 44)
        navigationItem.titleView = searchControl.searchBar
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "ask"), style: .plain, target: self, action: #selector(askQuestion))
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationController?.navigationBar.barTintColor = Constant.fbBlue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        
        fetchQuestion()
    }
    
    func askQuestion() {
        let askQuestionView = UINib(nibName: "AskQuestionView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! AskQuestionView
        askQuestionView.frame = CGRect(x: 0, y: view.frame.height, width: view.frame.width, height: 400)
        view.addSubview(askQuestionView)
        UIView.animate(withDuration: 0.3, delay: 0.0, options: UIViewAnimationOptions.curveEaseInOut, animations: {
            askQuestionView.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
            self.navigationController?.setNavigationBarHidden(true, animated: true)
            self.tableView.scrollsToTop = true
            self.tableView.isScrollEnabled = false
            askQuestionView.questionTitle.becomeFirstResponder()
            askQuestionView.owner = self
        }) { (_) in

        }
    }
    
    func fetchQuestion() {
        HttpManager.fectchQuestion { (questions) in
            self.questions = questions
            self.tableView.reloadData()
        }
    }
    
}

extension ForumController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questions == nil ? 0 : (questions?.count)!
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! QuestionCell
        cell.question = questions?[indexPath.row]
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let answerVC = AnswerController()
        answerVC.question = questions?[indexPath.row]
        navigationController?.pushViewController(answerVC, animated: true)
    }
}

extension ForumController: UISearchResultsUpdating,UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let searchText = searchBar.text ?? ""
        if searchText == "" {
            return
        }
        searchBar.resignFirstResponder()
        searchControl.dismiss(animated: true, completion: nil)
        HttpManager.searchQuestions(searchText: searchText) { results in
            self.questions = results
            self.tableView.reloadData()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text ?? "updating empty")
    }
    
}
