//
//  IntroSplashVC.swift
//  AppIn
//
//  Created by sameer khan on 14/10/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import AVKit

class IntroSplashVC: UIViewController {
    
    @IBOutlet weak var baseVideoView: UIView!
    
    var player : AVPlayer?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setStatusBarColor()
                
        self.playVideo()
    }
    
    private func playVideo() {
        
        guard let path = Bundle.main.path(forResource: "promo_bg", ofType: "mp4") else {
            debugPrint("promo_bg.mp4 not found")
            return
        }
        
        player = AVPlayer(url: URL(fileURLWithPath: path))
        let playerLayer = AVPlayerLayer(player: player)
        playerLayer.frame = self.view.frame
        playerLayer.videoGravity = .resizeAspectFill
        self.baseVideoView.layer.addSublayer(playerLayer)
        //self.baseVideoView.layer.insertSublayer(playerLayer, at: 0)
        player?.play()
        
        
        player?.actionAtItemEnd = AVPlayer.ActionAtItemEnd.none
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(playerItemDidReachEnd(notification:)),
                                               name: .AVPlayerItemDidPlayToEndTime,
                                               object: self.player?.currentItem)
        
    }
    
    @objc func playerItemDidReachEnd(notification: Notification) {
        if let playerItem = notification.object as? AVPlayerItem {
            playerItem.seek(to: CMTime.zero, completionHandler: nil)
        }
    }
    
    //MARK: IBAction
    @IBAction func createAccountBtnClicked(_ sender: UIButton) {
        let vc = DesignManager.loadViewControllerFromMainStoryBoard(identifier: "CreateAccountVC") as! CreateAccountVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func alreadyHaveAccountBtnClicked(_ sender: UIButton) {
        let vc = DesignManager.loadViewControllerFromMainStoryBoard(identifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }


}
