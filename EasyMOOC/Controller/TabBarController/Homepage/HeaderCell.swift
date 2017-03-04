//
//  HeaderCell.swift
//  EasyMOOC
//
//  Created by 高存折 on 2017/2/22.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit


class HeaderCell: UICollectionViewCell,UIScrollViewDelegate {
    
    let scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.size.width, height: 200))
    var frameZero: CGRect = CGRect.zero
    let pageControl : UIPageControl = UIPageControl(frame: CGRect(x: 90, y: 170, width: 200, height: 50))
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.isPagingEnabled = true
        addSubview(scrollView)
        for index in 0..<4 {
            
            frameZero.origin.x = scrollView.frame.size.width * CGFloat(index)
            frameZero.size = scrollView.frame.size
            
            let subView = UIImageView(frame: frameZero)
            subView.image = UIImage(named: "header\(index)")
            scrollView .addSubview(subView)
        }
        
        scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * 4, height: self.scrollView.frame.size.height)
        
        configurePageControl()
    
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configurePageControl() {
        pageControl.numberOfPages = 4
        pageControl.currentPage = 0
        pageControl.pageIndicatorTintColor = UIColor.lightGray
        pageControl.currentPageIndicatorTintColor = UIColor.white
        pageControl.addTarget(self, action: Selector(("changePage:")), for: UIControlEvents.valueChanged)
        addSubview(pageControl)
        
    }
    
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x:x,y:0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
}
