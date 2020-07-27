//
//  ContentYoutubeCVCell.swift
//  AppIn
//
//  Created by sameer khan on 27/07/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import Crashlytics
import Alamofire
import AlamofireImage
import YouTubePlayer
import AVFoundation
import AVKit

class ContentYoutubeCVCell: UICollectionViewCell {
    
    @IBOutlet weak var videoPlayer: YouTubePlayerView!
    @IBOutlet weak var pageBackgroundView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    
    var backgroundVideoView: ContentVideo?
    var stickerImageView = UIImageView()
    var componentViews = [ContentView]()
    
    var background: ContentPageBackground? {
        didSet {
            self.stickerImageView.image = nil
            self.stickerImageView.removeFromSuperview()
            
            backgroundUpdated(background)
        }
    }
    
    var stickerURL: String? {
        didSet {
            setStickerFromString(stickerURL ?? "")
        }
    }
    
    var component : ContentPageComponent? {
        didSet {
            if let url = component?.youtubeUrl {
                let split = url.split(separator: "/")
                
                if let embed = split.last {
                    let id = String.init(embed).replacingOccurrences(of: "\"", with: "")
                    videoPlayer.loadVideoID(id)
                }
            }
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension ContentYoutubeCVCell {
    
    // MARK: - Set Backgrounds
    
    func backgroundUpdated(_ backgroundArg: ContentPageBackground?) {
        guard let background = backgroundArg else {
            pageBackgroundView.backgroundColor = Color.backgroundColorDark()
            return
        }
        
        guard background.order == 0 else {
            return
        }
        
        print("BackGround Type = \(background.type)")
        switch background.type {
        case .Color:
            if let meta = background.meta, let color = meta["color"] as? String {
                pageBackgroundView.backgroundColor = UIColor(hexString: color)
            }
        case .Video:
            if let fileUrl = background.file_url {
                setBackgroundVideo(fileUrl)
                
            } else if let file = background.file {
                setBackgroundVideo(file)
            }
        case .Image:
            if let fileurl = background.file_url {
                setBackgroundImage(fileurl)
            }
            if let file = background.file {
                setBackgroundImage(file)
            }
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
    
    func setStickerFromString(_ urlString: String) {
        if let url = URL(string: urlString) {
                        
            stickerImageView.af_setImage(withURL: url, placeholderImage: nil, filter: nil, progress: nil, imageTransition: UIImageView.ImageTransition.crossDissolve(0.5), runImageTransitionIfCached: true, completion: { (response: DataResponse<UIImage>) in
                
                self.stickerImageView.frame = CGRect.init(x: 0, y: self.contentView.frame.size.height - SCREENSIZE.width/3, width: SCREENSIZE.width, height: SCREENSIZE.width/3)
                self.stickerImageView.contentMode = .scaleToFill
                self.stickerImageView.clipsToBounds = true
                
                self.backgroundImageView.addSubview(self.stickerImageView)
                self.backgroundImageView.bringSubviewToFront(self.stickerImageView)
            })
            
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
