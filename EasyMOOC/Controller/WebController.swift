//
//  WebController.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/17.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class WebController: UIViewController, UIWebViewDelegate, UIScrollViewDelegate {

    var url: String?
    var filePath: String?
    var webView: UIWebView?
    
    let indicator: UIActivityIndicatorView = {
        let iv = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.startAnimating()
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        webView = UIWebView(frame: view.frame)
        webView?.delegate = self
        webView?.scrollView.delegate  = self
        webView?.scalesPageToFit = true
        var request: URLRequest
        if filePath != nil {
            request = URLRequest(url: URL(fileURLWithPath: filePath!))
        }else {
            request = URLRequest(url: URL(string: url!)!)
        }
        webView?.loadRequest(request)
        view.addSubview(webView!)
        
        webView?.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        indicator.stopAnimating()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (context) in
            self.webView?.frame = self.view.frame
        }, completion: nil)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
}
