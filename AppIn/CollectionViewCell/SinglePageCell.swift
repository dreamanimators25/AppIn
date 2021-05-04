//
//  SinglePageCell.swift
//  AppIn
//
//  Created by sameer khan on 01/11/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import DropDown
import SwiftyJSON
import HCVimeoVideoExtractor
import AVFoundation
import AVKit
import MediaPlayer

class SinglePageCell: UICollectionViewCell {
    
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var goThereBtn: UIButton!
    @IBOutlet weak var shareBtn: UIButton!
    
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var channelImageView: UIImageView!
    @IBOutlet weak var pageTitleLbl: UILabel!
    @IBOutlet weak var pageBackgroundView: UIView!
    //@IBOutlet weak var pagebackgroundVideoView: ContentVideo!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var backgroundVideoView: ContentVideo?
    var stickerImageView = UIImageView()
    var componentViews = [ContentView]()
        
    let cellDropDown = DropDown()
    var vimeoUrl : String?
    var audioPlayer: Player?
    var pauseMp3 : (()-> (Void))?
    var delegate: MultiPageDelegate?
    
    var accessCode : String = ""
    var QrCode : String = ""
    var pageID : String = ""
        
    //var content:Content? {
    var content : AllFeedPages? {
        didSet {
            
            if (content != nil) {
                
                if let third = self.content?.thirdParty {
                    if third == "0" {
                        self.shareBtn.isHidden = true
                    }else {
                        self.shareBtn.isHidden = false
                    }
                }
                
                DispatchQueue.main.async {                    
                    
                    //self.backgroundImageView.image = nil
                    //self.backgroundVideoView = nil
                    
                    self.backgroundUpdated(self.content)
                    
                    self.pageTitleLbl.text = self.content?.title
                    
                    
                    //let s = self.content?.title
                    //let utf8View: String.UTF8View = (s ?? "").utf8
                    //let newString = String(utf8View)
                    //self.pageTitleLbl.text = newString
                    
                    
                    if self.content?.actionButtonMeta == nil || self.content?.actionButtonMeta == "" {
                        self.goThereBtn.setTitle("Read more", for: .normal)
                    }else {
                        self.goThereBtn.setTitle(self.content?.actionButtonMeta, for: .normal)
                    }
                   
                }
            }
            
        }
    }
    
    var mp3URL : String? {
        didSet {
            if let audioFile = mp3URL {
                //OperationQueue.main.addOperation {
                    
                    self.audioPlayer = MPCacher.sharedInstance.getObjectForKey(audioFile) as? Player
                    self.audioPlayer?.isMuted = true
                    self.audioPlayer?.volume = 0.0
                    self.audioPlayer?.play()
                    
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                        // Change `2.0` to the desired number of seconds.
                        // Code you want to be delayed
                        
                        self.audioPlayer?.isMuted = false
                        self.audioPlayer?.volume = 0.5
                    }
                    
                    //To Pause mp3 in background
                    self.pauseMp3 = {
                        //DispatchQueue.main.async {
                            if let player = self.audioPlayer {
                                player.pause()
                                
                                self.pauseMp3 = nil
                                
                                let seekTime: CMTime = CMTimeMake(value: 0, timescale: 1)
                                player.seek(to: seekTime)
                            }
                        //}
                    }
                    
                //}
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        cellDropDown.anchorView = self.moreBtn
        cellDropDown.dataSource = ["Invite to channel","About"]
        cellDropDown.cellConfiguration = { (index, item) in return "\(item)" }
       
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        
    }
    
    func pauseMedia() {
        //self.backgroundImageView.image = nil
        //self.backgroundVideoView = nil
        //self.backgroundVideoView?.removeFromSuperview()
        //self.pageBackgroundView.willRemoveSubview(self.backgroundVideoView ?? UIView())
        
        /*
        for component in componentViews {
            if let component = component as? ContentMusic {
                component.reset()
            } else if let component = component as? ContentVideo {
                component.reset()
            }
        }*/
    }
    
    //MARK: IBActions on Cells
    @IBAction func channelNameBtnClicked(_ sender: UIButton) {
    
        if let channel = CVChannelClick {
            channel(self.pageID)
        }
        
    }
    
    @IBAction func moreBtnClicked(_ sender: UIButton) {
        cellDropDown.selectionAction = { (index: Int, item: String) in
            
            if let selectedIndex = CVDropDownIndex {
                selectedIndex(index,self.accessCode,self.QrCode,self.pageID)
            }
        }

        cellDropDown.width = 130
        //cellDropDown.layer.cornerRadius = 20.0
        cellDropDown.setupCornerRadius(10.0)
        cellDropDown.backgroundColor = UIColor.white
        cellDropDown.selectionBackgroundColor = .white
        
        cellDropDown.bottomOffset = CGPoint(x: -100, y:(cellDropDown.anchorView?.plainView.bounds.height)!)
        cellDropDown.show()
    }
    
    @IBAction func goThereBtnClicked(_ sender: UIButton) {
        if let selectedIndex = callDisclaimer {
            selectedIndex(self.content?.disclaimer ?? "", self.content?.contentType ?? "", self.content?.content ?? "", self.content, self.channelNameLbl.text ?? "")
        }
    }
    
    @IBAction func shareBtnClicked(_ sender: UIButton) {
        self.callShareContentWebService()
        
        //if let share = CVChannelShare {
            //share()
        //}
        
        self.shareChannel()
    }
    
    func shareChannel() {
        
        self.goThereBtn.isHidden = true
      
        let sharedImage = UIView().takeScreenshot(captureView: self.contentView)
      
        self.goThereBtn.isHidden = false
       
        if let share = CVChannelShare {
            share(sharedImage ?? UIImage())
        }
        
    }
    
    //MARK: Web Service
    func callShareContentWebService() {
        
        let userData = UserDefaults.getUserData()
                
        var params = [String : Any]()
        params = ["contentId" : self.content?.channelId ?? 0,
                  "user_id" : userData?.UserId ?? "",
                  "pageId" : self.content?.pageId ?? ""]
        
        print("params = \(params)")
        
        Alamofire.request(kShareContentURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
            
            print(responseData)
                        
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    print(json)
                    
                }
                
            case .failure(let error):
                
                if error.localizedDescription.contains("Internet connection appears to be offline"){
                    //Alert.showAlert(strTitle: "Error!!", strMessage: "Internet connection appears to be offline", Onview: self)
                }else{
                    //Alert.showAlert(strTitle: "Error!!", strMessage: "something went wrong", Onview: self)
                }
            }
            
        }
        
    }
    
}

extension SinglePageCell {
    
    // MARK: - Set Backgrounds
    
    func backgroundUpdated(_ backgroundArg: AllFeedPages?) {
//        guard let background = backgroundArg else {
//            pageBackgroundView.backgroundColor = Color.backgroundColorDark()
//            return
//        }
        
//        guard background.order == 0 else {
//            return
//        }
        
        //print("BackGround Type = \(background.type)")
        //switch background.type {
        switch self.content?.backgroundType {
        case "0":
            //if let fileurl = background.file_url {
            //self.pauseMedia()
            
            DispatchQueue.main.async {
                self.pageBackgroundView.willRemoveSubview(self.backgroundVideoView ?? UIView())
                self.setBackgroundImage(backgroundArg?.backgroundMeta ?? "")
            }
            
            //}
            //if let file = background.file {
                //setBackgroundImage(backgroundArg?.backgroundMeta ?? "")
            //}
        case "1":
            //if let fileUrl = background.file_url {
            //} else if let file = background.file {
                //setBackgroundVideo(file)
            //}
            
            DispatchQueue.main.async {
                self.backgroundImageView.image = nil
                if let file = backgroundArg?.backgroundMeta {
                    self.setBackgroundVideo(file)
                }
            }
                        
        case "2":
            //self.pauseMedia()
            //if let meta = background.meta, let color = meta["color"] as? String {
            
            DispatchQueue.main.async {
                self.backgroundImageView.image = nil
                self.backgroundVideoView = nil
                self.backgroundVideoView?.removeFromSuperview()
                self.pageBackgroundView.willRemoveSubview(self.backgroundVideoView ?? UIView())
                self.pageBackgroundView.backgroundColor = UIColor(hexString: backgroundArg?.backgroundMeta ?? "")
            }
                
            //}

        case .none:
            break
        case .some(_):
            break
        }
    }
    
    func addBackgroundSubview(_ view: UIView,subview: UIView) {
        subview.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(subview)
        let views = ["subview" : subview]
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[subview]|", options: .alignAllLastBaseline, metrics: nil, views: views))
        view.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[subview]|", options: .alignAllLastBaseline, metrics: nil, views: views))
    }
    
    // MARK: - Image Background
    func setBackgroundImage(_ file: String) {
        if backgroundImageView == nil {
            //pageBackgroundView.addSubview(stickerImageView)
            //pageBackgroundView.bringSubviewToFront(stickerImageView)
        }
        
        if let url = URL(string: file) {
            self.backgroundImageView.af_setImage(withURL: url)
        }
        
    }
    
    // MARK: - Video Background
    func setBackgroundVideo(_ file: String) {
        if let backgroundVideoView = backgroundVideoView {
            backgroundVideoView.play(muted: true)
        } else {
            backgroundVideoView = ContentVideo(frame: frame, file: file)
            addBackgroundSubview(pageBackgroundView, subview: backgroundVideoView!)
            backgroundVideoView?.play(muted: true)
        }
    }
    
    // MARK: - Background Zoom
    
    func zoomBackground(_ x: CGFloat, y: CGFloat) {
        if let pageBackgroundView = pageBackgroundView {
            let width = bounds.width
            let scale = (width + 2.0*abs(0.5*(x+y)))/width
            pageBackgroundView.transform = CGAffineTransform.identity.translatedBy(x: x, y: y)
            pageBackgroundView.transform = pageBackgroundView.transform.scaledBy(x: scale, y: scale)
        }
    }
    
}
