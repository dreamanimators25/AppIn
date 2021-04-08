//
//  InformationVC.swift
//  AppIn
//
//  Created by sameer khan on 23/11/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import WebKit

class InformationVC: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var lblChannelName: UILabel?
    @IBOutlet weak var lblChannelDesc: UILabel?
    //@IBOutlet weak var lblContentData: UILabel!
    
    @IBOutlet weak var viewForWeb: UIView?
    @IBOutlet weak var webViewProgress: UIProgressView?
    var webView: WKWebView?
    var isComeFrom: String?
    var loadableUrlStr: String?
    
    @IBOutlet weak var pageBackgroundView: UIView?
    @IBOutlet weak var backgroundImageView: UIImageView?
    
    var backgroundVideoView: ContentVideo?
    var strChannelName: String?
    
    var singleContent : AllFeedPages? {
        didSet {
            
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setStatusBarColor()
        
        self.lblChannelName?.text = self.strChannelName ?? ""
        self.lblChannelDesc?.text = self.singleContent?.title
 
        self.backgroundImageView?.image = nil
        self.backgroundVideoView = nil
        
        self.backgroundUpdated(self.singleContent)
        self.loadableUrlStr = self.singleContent?.content
        
        
        self.LoadWebView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: IBAction
    @IBAction func shareBtnClicked(_ sender: UIButton) {
        
    }
    
    //MARK: Custom Methods
    func LoadWebView() {
        webView = self.addWKWebView(viewForWeb: viewForWeb ?? UIView())
        webView?.uiDelegate = self
        webView?.navigationDelegate = self
        
        if self.loadableUrlStr != nil || self.loadableUrlStr != "" {
            if isComeFrom == "Feed" {
                //webView?.loadHTMLString(loadableUrlStr ?? "", baseURL: nil)
                
                let str = "\(loadableUrlStr?.htmlToString ?? "")"
                webView?.loadHTMLString(str, baseURL: nil)
                webView?.scrollView.isScrollEnabled = false
   
            }else {
                let myURL = URL(string: loadableUrlStr ?? "")
                let myRequest = URLRequest(url: myURL!)
                webView?.load(myRequest)
            }
            
            //add observer to get estimated progress value
            self.webView?.addObserver(self, forKeyPath: "estimatedProgress", options: .new, context: nil)
        }
        
    }
    
    //MARK: WKWebView Delegate
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        
    }
    
    func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
        
    }
    
    //MARK: Observe value
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "estimatedProgress" {
            print(self.webView?.estimatedProgress ?? 0.0)
            //self.webViewProgress.progress = Float(self.webView.estimatedProgress)
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}

extension InformationVC {
    
    // MARK: - Set Backgrounds
    
    func backgroundUpdated(_ backgroundArg: AllFeedPages?) {
        guard let background = backgroundArg else {
            pageBackgroundView?.backgroundColor = Color.backgroundColorDark()
            return
        }
        
//        guard background.order == 0 else {
//            return
//        }
        
        //print("BackGround Type = \(background.type)")
        //switch background.type {
        switch self.singleContent?.backgroundType {
        case "0":
            //if let fileurl = background.file_url {
            //self.pauseMedia()
            setBackgroundImage(backgroundArg?.backgroundMeta ?? "")
            //}
            //if let file = background.file {
                //setBackgroundImage(backgroundArg?.backgroundMeta ?? "")
            //}
        case "1":
            //if let fileUrl = background.file_url {
            //} else if let file = background.file {
                //setBackgroundVideo(file)
            //}
            
                
            if let file = background.backgroundMeta {
                setBackgroundVideo(file)
            }
                        
        case "2":
            //self.pauseMedia()
            //if let meta = background.meta, let color = meta["color"] as? String {
            pageBackgroundView?.backgroundColor = UIColor(hexString: backgroundArg?.backgroundMeta ?? "")
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
            self.backgroundImageView?.af_setImage(withURL: url)
        }
        
    }
    
    // MARK: - Video Background
    func setBackgroundVideo(_ file: String) {
        if let backgroundVideoView = backgroundVideoView {
            backgroundVideoView.play(muted: true)
        } else {
            backgroundVideoView = ContentVideo(frame: self.backgroundVideoView?.frame ?? CGRect(), file: file)
            addBackgroundSubview(pageBackgroundView ?? UIView(), subview: backgroundVideoView!)
            backgroundVideoView?.play(muted: true)
        }
    }
    
    // MARK: - Background Zoom
    
   
}
