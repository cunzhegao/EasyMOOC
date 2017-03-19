//
//  VideoPlayerController.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/15.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit

class VideoPlayerController: UIViewController, UIScrollViewDelegate  {

    var playerView: VideoPlayerView? = nil
    var scrollView: UIScrollView?
    var segment: UISegmentedControl?
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        let videoViewFrame = CGRect(x: 0, y: 0, width: view.frame.width + 1, height: view.frame.width * 9 / 16)
        playerView = VideoPlayerView(frame: videoViewFrame)
        view.addSubview(playerView!)
     
        setupScollView()
        setupSegment()
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        playerView?.player?.play()
        playerView?.btnPausePlay.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        playerView?.player?.pause()
        playerView?.btnPausePlay.setImage(#imageLiteral(resourceName: "play"), for: .normal)
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.current.orientation.isLandscape {
            coordinator.animate(alongsideTransition: { (context) in
                self.playerView?.frame = self.view.frame
                self.playerView?.playerLayer?.frame = self.view.layer.frame
                self.playerView?.controlContainerView.frame = (self.playerView?.frame)!
                self.segment?.isHidden = true
                self.scrollView?.isHidden = true
            }, completion: nil)
        }else {
            coordinator.animate(alongsideTransition: { (context) in
                self.playerView?.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.width * 9 / 16)
                self.playerView?.playerLayer?.frame = (self.playerView?.layer.frame)!
                self.playerView?.controlContainerView.frame = (self.playerView?.frame)!
                self.segment?.isHidden = false
                self.scrollView?.isHidden = false
            }, completion: nil)
        }
    }
    
    //MARK: - Setup Custom View
    func setupScollView() {
        var frameZero = CGRect.zero
        let scrollViewFrame = CGRect(x: 0, y: (playerView?.frame.height)! + 41,
                                     width: view.frame.width, height:  view.frame.height - (playerView?.frame.height)! - 41)
        scrollView = UIScrollView(frame: scrollViewFrame)
        scrollView?.contentSize = CGSize(width: scrollViewFrame.width * 4 , height: scrollViewFrame.height)
        
        for index in 0..<4 {
            
            frameZero.origin.x = scrollViewFrame.width * CGFloat(index)
            if index == 0 {
                let view = UINib(nibName: "DetailView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
                view.frame = CGRect(origin: frameZero.origin, size: scrollViewFrame.size)
                scrollView?.addSubview(view)

            }else if index == 1 {
                let view = UINib(nibName: "MaterialView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
                view.frame = CGRect(origin: frameZero.origin, size: scrollViewFrame.size)
                scrollView?.addSubview(view)
            }else if index == 2 {
                let view = UINib(nibName: "QuizView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
                view.frame = CGRect(origin: frameZero.origin, size: scrollViewFrame.size)
                scrollView?.addSubview(view)
            }else {
                let view = UINib(nibName: "CommentView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! UIView
                view.frame = CGRect(origin: frameZero.origin, size: scrollViewFrame.size)
                scrollView?.addSubview(view)
            }

        }
        scrollView?.showsHorizontalScrollIndicator = false
        scrollView?.isPagingEnabled = true
        scrollView?.delegate = self
        view.addSubview(scrollView!)
    }
    
    func setupSegment() {
        
        let segmentFrame = CGRect(x: 0, y: (playerView?.frame.height)! + 1, width: view.frame.width, height: 40)
        segment = UISegmentedControl(frame: segmentFrame)
        segment?.insertSegment(withTitle: "详情", at: 0, animated: false)
        segment?.insertSegment(withTitle: "资料", at: 1, animated: false)
        segment?.insertSegment(withTitle: "考核", at: 2, animated: false)
        segment?.insertSegment(withTitle: "评论", at: 3, animated: false)
        segment?.tintColor = Constant.fbBlue
        segment?.setTitleTextAttributes([NSFontAttributeName : UIFont.boldSystemFont(ofSize: 16)], for: .normal)
        segment?.addTarget(self, action: #selector(didSelectSegment), for: .valueChanged)
        segment?.selectedSegmentIndex = 0
        view.addSubview(segment!)
    }
    
    //MARK: - Segment and Scroll View Delegate Method
    func didSelectSegment(segment:UISegmentedControl) {
        let offsetX = (scrollView?.frame.width)! * CGFloat(segment.selectedSegmentIndex)
        scrollView?.setContentOffset(CGPoint(x:offsetX,y:0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let index = round(scrollView.contentOffset.x / scrollView.frame.width)
        segment?.selectedSegmentIndex = Int(index)
        let offsetX = scrollView.frame.width * CGFloat((segment?.selectedSegmentIndex)!)
        scrollView.setContentOffset(CGPoint(x:offsetX,y:0), animated: true)
    }
}
