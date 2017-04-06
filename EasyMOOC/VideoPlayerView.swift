//
//  VideoPlayerView.swift
//  EasyMOOC
//
//  Created by 高存折 on 17/3/15.
//  Copyright © 2017年 高存折. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    
    var player: AVPlayer?
    var playerLayer: AVPlayerLayer?
    weak var controller:VideoPlayerController?
    var totalSecond: Float?
    var isPlaying = true

    //MARK: - View Property
    let controlContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 1)
        return view
    }()
    
    let indicator: UIActivityIndicatorView =  {
        let aiv = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        aiv.translatesAutoresizingMaskIntoConstraints = false
        aiv.startAnimating()
        return aiv
    }()
    
    lazy var btnPausePlay: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.isHidden = true
        btn.addTarget(self, action: #selector(pauseAndPlay), for: .touchUpInside)
        return btn
    }()
    
    let currentTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor.white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let totalTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "00:00"
        label.font = UIFont.boldSystemFont(ofSize: 13)
        label.textColor = UIColor.white
        label.textAlignment = .right
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var timeSlider: UISlider = {
        let slider = UISlider()
        slider.setThumbImage(UIImage(), for: .normal)
        slider.minimumTrackTintColor = Constant.fbBlue
        slider.maximumTrackTintColor = UIColor.white
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.addTarget(self, action: #selector(dragSlider), for: .valueChanged)
        return slider
    }()
    
    lazy var btnFull: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "fullScreen"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(rotateScreen), for: .touchUpInside)
        return btn
    }()
    
    lazy var btnBack: UIButton = {
        let btn = UIButton()
        btn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(goBack), for: .touchUpInside)
        return btn
    }()
    
    //MARK: - Init
    override init(frame:CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.black
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTab)))
        setupPlayer()
//        setupGradientLayer()
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - View Related Action
    func handleTab() {
        UIView.animate(withDuration: 0.5) { 
            self.controlContainerView.isHidden = !self.controlContainerView.isHidden
        }
    }
    
    func pauseAndPlay() {
        if isPlaying {
            player?.pause()
            btnPausePlay.setImage(#imageLiteral(resourceName: "play"), for: .normal)
        }else {
            player?.play()
            btnPausePlay.setImage(#imageLiteral(resourceName: "pause"), for: .normal)
        }
        isPlaying = !isPlaying
    }
    
    func dragSlider() {
        let seekSecond = totalSecond! * timeSlider.value
        let minute = Int(seekSecond / 60)
        let second = Int(seekSecond.truncatingRemainder(dividingBy: 60))
        currentTimeLabel.text = "\(minute):\(second)"
        let seekTime = CMTime(seconds: Double(seekSecond), preferredTimescale: 1)
    
        player?.seek(to: seekTime)
    }
    
    func rotateScreen() {
        if UIDevice.current.orientation.isPortrait {
            UIDevice.current.setValue(UIInterfaceOrientation.landscapeRight.rawValue, forKey: "orientation")
        }else {
            UIDevice.current.setValue(UIInterfaceOrientation.portrait.rawValue, forKey: "orientation")
        }
    }
    
    func goBack() {
        if let topNav = UIApplication.topViewController()?.navigationController {
            topNav.popViewController(animated: true)
        }
    }
    
    //MARK: - Setup Custom View
    private func setupPlayer() {
        guard let path = Bundle.main.path(forResource: "sample", ofType: ".mp4") else {print("file not exist");return}
        player = AVPlayer(url: URL(fileURLWithPath: path))
        playerLayer = AVPlayerLayer(player: player)
        layer.addSublayer(playerLayer!)
        playerLayer?.frame = self.frame
        player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        player?.play()
        
        //track player progress
        let interval = CMTime(value: 1, timescale: 1)
        player?.addPeriodicTimeObserver(forInterval: interval, queue: DispatchQueue.main, using: { (progress) in
            let seconds = CMTimeGetSeconds(progress)
            let minute = String(format: "%02d", Int(seconds / 60))
            let second = String(format: "%02d", Int(seconds.truncatingRemainder(dividingBy: 60)))
            self.currentTimeLabel.text = "\(minute):\(second)"
            //move slider thumb
            if let total = self.totalSecond {
                self.timeSlider.value = Float(seconds) / total
            }
        })
    }
    
    private func setupView() {
        controlContainerView.frame = frame
        addSubview(controlContainerView)
        
        controlContainerView.addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        
        controlContainerView.addSubview(btnPausePlay)
        btnPausePlay.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        btnPausePlay.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        btnPausePlay.widthAnchor.constraint(equalToConstant: 50)
        btnPausePlay.heightAnchor.constraint(equalToConstant: 50)
        
        controlContainerView.addSubview(currentTimeLabel)
        currentTimeLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 5).isActive = true
        currentTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        currentTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        currentTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlContainerView.addSubview(totalTimeLabel)
        totalTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -2).isActive = true
        totalTimeLabel.heightAnchor.constraint(equalToConstant: 24).isActive = true
        totalTimeLabel.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
        controlContainerView.addSubview(timeSlider)
        timeSlider.leftAnchor.constraint(equalTo: currentTimeLabel.rightAnchor).isActive = true
        timeSlider.rightAnchor.constraint(equalTo: totalTimeLabel.leftAnchor).isActive = true
        timeSlider.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        timeSlider.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        controlContainerView.addSubview(btnFull)
        btnFull.rightAnchor.constraint(equalTo: rightAnchor,constant: -5).isActive = true
        btnFull.leftAnchor.constraint(equalTo: totalTimeLabel.rightAnchor, constant: 5).isActive = true
        btnFull.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5).isActive = true
        btnFull.heightAnchor.constraint(equalToConstant: 25).isActive = true
        btnFull.widthAnchor.constraint(equalToConstant: 25).isActive = true
        
        controlContainerView.addSubview(btnBack)
        btnBack.topAnchor.constraint(equalTo: topAnchor, constant:10).isActive = true
        btnBack.leftAnchor.constraint(equalTo: leftAnchor,constant: 10).isActive = true
        btnBack.widthAnchor.constraint(equalToConstant: 30).isActive = true
        btnBack.heightAnchor.constraint(equalToConstant: 30).isActive = true

    }
    
    //MARK: - Observer
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        //when player is loaded and ready to play
        if keyPath == "currentItem.loadedTimeRanges" {
            indicator.stopAnimating()
            btnPausePlay.isHidden = false
            controlContainerView.backgroundColor = UIColor.clear
            
            if let totalTime = player?.currentItem?.duration {
                totalSecond = Float(CMTimeGetSeconds(totalTime))
                let minute = Int(totalSecond! / 60)
                let second = Int(totalSecond!.truncatingRemainder(dividingBy: 60))
                totalTimeLabel.text = "\(minute):\(second)"
            }
        }
    }
    
    //add a shadow layer below slider and time label
//    private func setupGradientLayer() {
//        let gradientLayer = CAGradientLayer()
//        gradientLayer.frame = bounds
//        gradientLayer.colors = [UIColor.clear.cgColor,UIColor.black.cgColor]
//        gradientLayer.locations = [0.85,1.2]
//        controlContainerView.layer.addSublayer(gradientLayer)
//    }
}
