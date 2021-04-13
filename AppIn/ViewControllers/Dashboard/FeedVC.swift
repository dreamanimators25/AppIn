//
//  ProfileVC.swift
//  AppIn
//
//  Created by sameer khan on 21/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import HCVimeoVideoExtractor
import YouTubePlayer
import AVFoundation
import AVKit
import Alamofire
import SwiftyJSON
import MessageUI
import XCDYouTubeKit


var CVChannelShare : ((_ captureImg : UIImage)->(Void))?
var CVChannelClick : ((_ pgID : String)->(Void))?
var CVDropDownIndex : ((_ ind : Int, _ accessCode : String, _ qrCode : String,_ pgID : String) -> (Void))?
var CVgoThereIndex : ((_ contentType : String, _ content : String, _ singleContent : AllFeedPages?, _ name : String) -> (Void))?
var callDisclaimer : ((_ strDisclamer : String , _ contentType : String, _ content : String, _ singleContent : AllFeedPages?, _ name : String) -> (Void))?
//var loadNotification : ((_ channelId : Int, _ pageId : Int) -> (Void))?
var loadNotification : (() -> (Void))?
var loadChannel : (() -> (Void))?

class FeedVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    var arrFeedChannel : [AllFeedData]? = nil
    
    var actualChannelsID = [String]()
    var actualPagesID = [[String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarColor()
        
        //if AppDelegate.sharedDelegate().selChannelID == -1 {
            self.callGetAllChannelWebService()
            isFeedTabSelect = false
        //}
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isFeedTabSelect {
            self.callGetAllChannelWebService()
            isFeedTabSelect = false
        }
        
        
//        if AppDelegate.sharedDelegate().selChannelID == -1 && AppDelegate.sharedDelegate().selNotiChannelID == -1 {
//            self.callGetAllChannelWebService()
//        }
        
 
        /*
        // MARK: To handle navigation to channel tab from feed tab
        CVChannelClick = { (pgID) in
            
            self.contentCollectionView.scrollToItem(at: IndexPath.init(row: 0, section: 0), at: [.centeredHorizontally,.centeredVertically], animated: true)
            
            /*
            if let tabBarController = self.navigationController?.tabBarController {
                tabBarController.selectedIndex = 0
            }
            */
            
            
            /*
            let vc = DesignManager.loadViewControllerFromContentStoryBoard(identifier: "AboutVC") as! AboutVC
            vc.isComeFrom = "Channel"
            vc.isID = pgID
            self.navigationController?.pushViewController(vc, animated: true)
            */
            
        }
        */
        
        
        // MARK: To handle Share from channel
        CVChannelShare = { capturedImage in
            self.shareChannel(img: capturedImage)
        }
        
        
        // MARK: To handle navigation on other viewcontrollers
        CVDropDownIndex = { (index,accesCode,qrCode,pgID) in
            switch index {
            case 0:
                let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "InviteVC") as! InviteVC
                vc.strAccessCode = accesCode
                vc.strQrCode = qrCode
                self.navigationController?.pushViewController(vc, animated: true)
                
                break
            default:
                let vc = DesignManager.loadViewControllerFromContentStoryBoard(identifier: "AboutVC") as! AboutVC
                vc.isComeFrom = "Channel"
                vc.isID = pgID
                self.navigationController?.pushViewController(vc, animated: true)
                
                break
            }
        }
        
        // MARK: To handle action on contentTypes on buttons
        callDisclaimer = { (disclaimer, contType, content, singlePageContent, channelName) in
            
            if disclaimer != "" {
                
                DispatchQueue.main.async {
                    let vc = DesignManager.loadViewControllerFromChannelStoryBoard(identifier: "DisclaimerVC") as! DisclaimerVC
                    vc.modalPresentationStyle = .overCurrentContext
                    vc.strContent = disclaimer
                    vc.strContentType = contType
                    vc.strContentNo = content
                    vc.singleContent = singlePageContent
                    vc.strChannelName = channelName
                    self.present(vc, animated: true) {
                        
                    }
                }
                
            }else {
                
                if let selectedIndex = CVgoThereIndex {
                    selectedIndex(contType, content, singlePageContent, channelName)
                }
                
            }
                        
        }
        
        CVgoThereIndex = { (contType, content, singleContent, channelName) in
            
            switch contType {
            case "0":
                print("vimeo")
                
                DispatchQueue.main.async {
                    //self.showVimeoPlayer("https://player.vimeo.com/281116099")
                    self.showVimeoPlayer(content)
                }
                
                break
            case "1":
                print("youtube")
                
                //https://www.youtube.com/watch?v=rOax50EDIZQ
                //https://www.youtube.com/watch?v=YPohR_9v6HA
                
                DispatchQueue.main.async {
                    let split = content.split(separator: "/")
                    
                    if let embed = split.last {
                        let id = String.init(embed).replacingOccurrences(of: "\"", with: "")
                        //self.videoPlayer.loadVideoID(id)
                        
                        let idd = id.components(separatedBy: "=")
                        self.showYoutubePlayer(idd.last ?? "")
                        
                    }
                }

                break
            case "2":
                print("pdf")
                
                DispatchQueue.main.async {
                    self.openLinkInAppInWebView(link: content)
                }
                                
                break
            case "3":
                print("excel")
                
                DispatchQueue.main.async {
                    Downloader.load(url: URL.init(string: content)!, to: Int(contType) ?? 0) { (msg) in
                        
                        DispatchQueue.main.async {
                            
                            self.showAlertForIndexOnCell("", message: msg, alertButtonTitles: ["OK"], alertButtonStyles: [.default], vc: UIViewController(), completion: { (index) in
                                
                                DispatchQueue.main.async {
                                    self.openLinkInAppInWebView(link: content)
                                }
                                
                            })
                        }
                    }
                }
                                
                break
            case "4":
                print("contact")
                
                DispatchQueue.main.async {
                    guard let number = URL(string: "tel://\(content)") else { return }
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(number, options: [:], completionHandler: { (status) in })
                    } else {
                        UIApplication.shared.openURL(number)
                    }
                }
                                
                break
            case "5":
                print("email")
                
                DispatchQueue.main.async {
                    self.openEmailLink(link: content)
                }
                                
                break
            case "6":
                print("whatsapp")
                DispatchQueue.main.async {
                    
                    if self.schemeAvailable(scheme: "whatsapp://app")
                    {
                        if let url = NSURL(string: "https://api.whatsapp.com/send?phone=\(content)&text=") {
                            if #available(iOS 10, *) {
                                UIApplication.shared.open(url as URL)
                            } else {
                                UIApplication.shared.openURL(url as URL)
                            }
                        }
                    }
                    else
                    {
                        let urlStr = "https://itunes.apple.com/in/app/whatsapp-messenger/id310633997?mt=8"
                        if #available(iOS 10.0, *) {
                            UIApplication.shared.open(URL(string: urlStr)!, options: [:], completionHandler: nil)
                        } else {
                            UIApplication.shared.openURL(URL(string: urlStr)!)
                        }
                    }
                    
                }
                
                break
            case "7":
                print("content")
                
                DispatchQueue.main.async {
                    let vc = DesignManager.loadViewControllerFromContentStoryBoard(identifier: "InformationVC") as! InformationVC
                    vc.isComeFrom = "Feed"
                    vc.singleContent = singleContent
                    vc.strChannelName = channelName
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                
                
                /*
                DispatchQueue.main.async {
                    let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "WebViewVC") as! WebViewVC
                    vc.isComeFrom = ""
                    vc.loadableUrlStr = content
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                */
                                
                break
            case "8":
                print("link")
                
                DispatchQueue.main.async {
                    self.openLinkInAppInWebView(link: content)
                }
                                
                break
            default:
                print("Nothing")
                
                break
            }
            
        }
        
    }
    
    //MARK: Check App Install or not
    
    func schemeAvailable(scheme: String) -> Bool {
        if let url = URL(string: scheme) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: UICollectionView DataSource & Delegates
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
        //return self.arrFeedChannel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.arrFeedChannel?[section].channels?.count ?? 0
        //return self.arrFeedChannel?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let multiPageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MultiPageCell", for: indexPath) as! MultiPageCell
        
        //if let cell = cell as? MultiPageCell {
            multiPageCell.content = self.arrFeedChannel?[0].channels?[indexPath.item]
        //}
        
        return multiPageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
//        if let cell = cell as? MultiPageCell {
//            cell.content = self.arrFeedChannel?[0].channels?[indexPath.item]
//        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
                
        if let cell = cell as? MultiPageCell {
            cell.reset()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentCollectionView.frame.size.width, height: self.contentCollectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.init(top: 0, left: 0, bottom: 0, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    //MARK: Web Service
    func callGetAllChannelWebService() {
        
        let userData = UserDefaults.getUserData()
        
        var params = [String : String]()
        params = ["user_id" : userData?.UserId ?? ""]
        
        print("params = \(params)")
        self.showSpinner(onView: self.view)
        
        Alamofire.request(kGetAllChannelsURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
            
            self.removeSpinner()
            print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    //print(json)
                    
                    let responsModal = AllFeedBaseClass.init(json: json)
                    
                    if responsModal.status == "success" {
                        
                        self.arrFeedChannel = responsModal.data
                        self.contentCollectionView.reloadData()
                        
                        //let allChannel = self.arrFeedChannel?[0].channels ?? []
                        
                        // MARK: This case is handling the scrolling, when come from channelsVC
                        if AppDelegate.sharedDelegate().selChannelID == -1 {
                            
                            loadChannel = {
                                self.comeFromChannelVC()
                            }
                            
                        }else {
                            self.comeFromChannelVC()
                            
                            loadChannel = {
                                self.comeFromChannelVC()
                            }
                        }
                        
                        
                        // MARK: This case is handling the scrolling, when come from NotificationVC
                        if AppDelegate.sharedDelegate().selNotiChannelID == -1 {
                            
                            loadNotification = {
                                self.comeFromNotificationVC()
                            }
                            
                        }else {
                            self.comeFromNotificationVC()
                            
                            loadNotification = {
                                self.comeFromNotificationVC()
                            }

                        }
      
                    }else{
                        //Alert.showAlert(strTitle: "", strMessage: responsModal.msg ?? "", Onview: self)
                    }
                    
                }
                
            case .failure(let error):
                
                if error.localizedDescription.contains("Internet connection appears to be offline"){
                    Alert.showAlert(strTitle: "Error!!", strMessage: "Internet connection appears to be offline", Onview: self)
                }else{
                    Alert.showAlert(strTitle: "Error!!", strMessage: "something went wrong", Onview: self)
                }
            }
            
        }
        
    }
    
    func comeFromChannelVC() {
        
        for (index,channel) in (self.arrFeedChannel?[0].channels ?? []).enumerated() {
            if Int(channel.internalIdentifier ?? "0") == AppDelegate.sharedDelegate().selChannelID {
                self.contentCollectionView.scrollToItem(at: IndexPath.init(row: index, section: 0), at: [.centeredHorizontally,.centeredVertically], animated: true)
                AppDelegate.sharedDelegate().selChannelID = -1
            }
        }
        
    }
    
    func comeFromNotificationVC() {
        
        for (_,channel) in (self.arrFeedChannel?[0].channels ?? []).enumerated() {
            
            // MARK: To navigate on selected page of channel in notification
            var arrPg = [String]()
            for i in channel.pages ?? [] {
                arrPg.append(i.pageId ?? "")
            }
            
            self.actualChannelsID.append(channel.internalIdentifier ?? "")
            self.actualPagesID.append(arrPg)
            
            //loadNotification = {
                var raw = 0
                var sec = 0
                
                for (indax,i) in self.actualChannelsID.enumerated() {
                    if Int(i) == AppDelegate.sharedDelegate().selNotiChannelID {
                        raw = indax
                    }
                }
            
                let arrPage = self.actualPagesID[raw]
                for (indax,p) in arrPage.enumerated() {
                    if Int(p) == AppDelegate.sharedDelegate().selNotiPageID {
                        sec = indax
                        AppDelegate.sharedDelegate().multiNotiPageID = sec
                    }
                }
            
                self.contentCollectionView.reloadData()
                if AppDelegate.sharedDelegate().selNotiChannelID != -1 {
                    self.contentCollectionView.scrollToItem(at: IndexPath.init(row: raw, section: 0), at: [.centeredHorizontally,.centeredVertically], animated: false)
                    AppDelegate.sharedDelegate().selNotiChannelID = -1
                }
                
            //}
            
        }
    
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    func showYoutubePlayer(_ id: String) {
        
        XCDYouTubeClient.default().getVideoWithIdentifier(id) { (video, error) in
            guard error == nil else {
                //Alert.showAlert(strTitle: "Error!!", strMessage: (error! as NSError) as! String, Onview: self)
                return
            }
            
            AVPlayerViewControllerManager.shared.lowQualityMode = true
            AVPlayerViewControllerManager.shared.video = video
            self.present(AVPlayerViewControllerManager.shared.controller, animated: true) {
                AVPlayerViewControllerManager.shared.controller.player?.play()
            }
        }
        
    }
    
    func showVimeoPlayer(_ link: String) {
        
        let linkUrl = URL.init(string: link)
        
        HCVimeoVideoExtractor.fetchVideoURLFrom(url: linkUrl!, completion: { ( video:HCVimeoVideo?, error:Error?) -> Void in
            
            if let err = error {
                print("Error = \(err.localizedDescription)")
                return
            }
            
            guard let vid = video else {
                print("Invalid video object")
                return
            }
                        
            var vidUrl : HCVimeoVideoQuality!
            for item in vid.videoURL {
                vidUrl = item.key
            }
                        
            if let videoURL = vid.videoURL[vidUrl] {
                
                DispatchQueue.main.async {
                    let player = AVPlayer(url: videoURL)
                    let playerController = AVPlayerViewController()
                    playerController.player = player
                    self.present(playerController, animated: true) {
                        player.play()
                    }
                }
                
            }
        })
    }
    
    func shareChannel(img : UIImage) {
        // text to share
        // let sharedText = "Shared via AppIn! Download AppIn Now from Apple App Store and Google Play Store!"
        
        //*
        //To Hide GoThereButton
        var btnStt = false
        let cells = contentCollectionView.visibleCells
        for cell in cells {
            if let cell = cell as? MultiPageCVCell {
                btnStt = cell.goThereBtn.isHidden
                cell.goThereBtn.isHidden = true
            }
        }
        
        // image to share
        //let sharedImage = UIView().takeScreenshot(captureView: self.contentCollectionView)
        
        
        //To Show GoThereButton After capture image of whole view
        for cell in cells {
            if let cell = cell as? MultiPageCVCell {
                cell.goThereBtn.isHidden = btnStt
            }
        }
        //*/
        
        
        // set up activity view controller
        //let sharedData = [ sharedImage ?? UIImage() , sharedText] as [Any]
        let sharedData = [img] as [Any]
        //let sharedData = [sharedText] as [Any]
        let activityViewController = UIActivityViewController(activityItems: sharedData, applicationActivities: nil)
        
        // so that iPads won't crash
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.assignToContact, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.message, UIActivity.ActivityType.openInIBooks, UIActivity.ActivityType.postToTencentWeibo, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.postToFlickr ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }

}



extension FeedVC {
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func presentUseAlert(_ title: String, _ message: String) {
        
    }
    
    func showAlertOnCell(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "OK", style: .default) { action in
            
        }
        alert.addAction(ok)
        present(alert, animated: true)
    }
    
    func showAlertForIndexOnCell(_ title: String, message: String, alertButtonTitles: [String], alertButtonStyles: [UIAlertAction.Style], vc: UIViewController, completion: @escaping (Int) -> Void) {
        let alert = UIAlertController(title: title,message: message,preferredStyle: UIAlertController.Style.alert)
        
        for title in alertButtonTitles {
            let actionObj = UIAlertAction(title: title,style: alertButtonStyles[alertButtonTitles.firstIndex(of: title)!], handler: { action in
                completion(alertButtonTitles.firstIndex(of: action.title!)!)
            })
            
            alert.addAction(actionObj)
        }
        
        //alert.view.tintColor = Utility.themeColor
        
        //vc will be the view controller on which you will present your alert as you cannot use self because this method is static.
        //vc.present(alert, animated: true, completion: nil)
        present(alert, animated: true, completion: nil)
        
        //UIApplication.shared.keyWindow?.rootViewController?.present(alert, animated: true, completion: nil)
    }
    
    func shareFacebook(_ imageView: UIImageView, isBack: Bool, page: Int) {
        
    }
    
    func shareInstagram(_ imageView: UIImageView) {
        
    }
    
    func shareTwitter(_ imageView: UIImageView, isBack: Bool, page: Int) {
        
    }
    
    func shareFacebookLink(_ link: String) {
        
    }
    
    func shareTwitterLink(_ link: String) {
        
    }
    
    func openEmailLink(link: String) {
        
        if MFMailComposeViewController.canSendMail() {
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients([link])
            
            self.present(mailComposerVC, animated: true, completion: nil)
        } else {
            let coded = "mailto:\(link)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
        
            if let emailURL = coded
            {
                self.openLinkInAppInWebView(link: emailURL)
            }
        }
    }
    
    func openLinkInAppInWebView(link : String) {
        let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "WebViewVC") as! WebViewVC
        vc.isComeFrom = "APPIN"
        vc.loadableUrlStr = link
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func showContentViewController(_ amb: Ambassadorship) {
        
        let contentViewController = UIStoryboard(name: "Content", bundle: nil).instantiateViewController(withIdentifier: "ShowContentsVC") as! ShowContentsVC
        
        contentViewController.ambassadorship = amb
        //contentViewController.user = user
        
        self.navigationController?.pushViewController(contentViewController, animated: true)
    }
    
    func showGift(_ title: String, mess: String?, res: @escaping (Bool) -> ()) {
        let alertController = UIAlertController(title: title, message: mess, preferredStyle: UIAlertController.Style.actionSheet)
        
        alertController.addAction(UIAlertAction(title:  "Yes", style: UIAlertAction.Style.destructive, handler: { (alertAction: UIAlertAction) in
            res(true)
        }))
        
        alertController.addAction(UIAlertAction(title:  "No", style: UIAlertAction.Style.cancel, handler: { (alertAction: UIAlertAction) in
            res(false)
            alertController.dismiss(animated: true, completion: nil)
        }))
        
        present(alertController, animated: true, completion: nil)
    }

    func showMessage(_ title: String, _ message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showDialog(_ message: String) {
        let alert = UIAlertController(title: "Message", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func currentSubPage(_ page: Int) {
        //currentSubPage = page
        print("curr sub page = \(currentSubPage)")
    }

    func currentPage(_ page: Int) {
        //addDuration()
        print("curr page = \(ShowContentsVC.currentPage)")
        ShowContentsVC.currentPage = page
    }
    
    func shareContent(_ id: Int) {
        //showShare(id)
    }
    
    func shareContentOutbound(_ id: Int) {
        //showShareOutbound(id)
    }
    
    func vertical(_ verticalPage: Int) {
        
    }
    
    func retrieveImage(_ url: String) {
        
    }
    
    // TODO: Put this functionality in MultiPage, once done remove notifications. handleContentButtons func must switch delegate
    
    func shareButtons(_ contentNumber: Int?, _ subPageNumber: Int?) {
        
    }
 
}

extension UIViewController {
    func topMostViewController() -> UIViewController {
        if self.presentedViewController == nil {
            return self
        }
        if let navigation = self.presentedViewController as? UINavigationController {
            return navigation.visibleViewController!.topMostViewController()
        }
        if let tab = self.presentedViewController as? UITabBarController {
            if let selectedTab = tab.selectedViewController {
                return selectedTab.topMostViewController()
            }
            return tab.topMostViewController()
        }
        return self.presentedViewController!.topMostViewController()
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder!.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}

struct YouTubeVideoQuality {
    static let hd720 = NSNumber(value: XCDYouTubeVideoQuality.HD720.rawValue)
    static let medium360 = NSNumber(value: XCDYouTubeVideoQuality.medium360.rawValue)
    static let small240 = NSNumber(value: XCDYouTubeVideoQuality.small240.rawValue)
}

@objcMembers class AVPlayerViewControllerManager: NSObject {
    //MARK: - Public
    public static let shared = AVPlayerViewControllerManager()
    public var lowQualityMode = false
    public dynamic var duration: Float = 0
    
    public var video: XCDYouTubeVideo? {
        didSet {
            guard let video = video else { return }
            guard lowQualityMode == false else {
                guard let streamURL = video.streamURLs[XCDYouTubeVideoQualityHTTPLiveStreaming] ?? video.streamURLs[XCDYouTubeVideoQuality.medium360.rawValue] ?? video.streamURLs[XCDYouTubeVideoQuality.small240.rawValue] else { fatalError("No stream URL") }
                
                self.player = AVPlayer(url: streamURL)
                self.controller.player = self.player
                return
            }
            guard let streamURL = video.streamURL else { fatalError("No stream URL")}
            self.player = AVPlayer(url: streamURL)
            self.controller.player = self.player
        }
    }

    public var player: AVPlayer? {
        didSet {
            if let playerRateObserverToken = playerRateObserverToken {
                playerRateObserverToken.invalidate()
                self.playerRateObserverToken = nil
            }
            
            self.playerRateObserverToken = player?.observe(\.rate, changeHandler: { (item, value) in
                self.updatePlaybackRateMetadata()
            })
            
            guard let video = self.video else { return }
            if let token = timeObserverToken {
                oldValue?.removeTimeObserver(token)
                timeObserverToken = nil
            }
            self.setupRemoteTransportControls()
            self.updateGeneralMetadata(video: video)
            self.updatePlaybackDuration()
        }
    }
    
    public lazy var controller: AVPlayerViewController = {
        let controller = AVPlayerViewController()
        if #available(iOS 10.0, *) {
            controller.updatesNowPlayingInfoCenter = false
        }
        return controller
    }()
    
    override init() {
        super.init()
        
        NotificationCenter.default.addObserver(forName: AVAudioSession.interruptionNotification, object:  AVAudioSession.sharedInstance(), queue: .main) { (notification) in
            
            guard let userInfo = notification.userInfo,
                let typeValue = userInfo[AVAudioSessionInterruptionTypeKey] as? UInt,
                let type = AVAudioSession.InterruptionType(rawValue: typeValue) else {
                    return
            }
            
            if type == .began {
                self.player?.pause()
            } else if type == .ended {
                guard ((try? AVAudioSession.sharedInstance().setActive(true)) != nil) else { return }
                guard let optionsValue = userInfo[AVAudioSessionInterruptionOptionKey] as? UInt else { return }
                let options = AVAudioSession.InterruptionOptions(rawValue: optionsValue)
                guard options.contains(.shouldResume) else { return }
                self.player?.play()
            }
        }
    }
    
    public func disconnectPlayer() {
        self.controller.player = nil
    }
    
    public func reconnectPlayer(rootViewController: UIViewController) {
        let viewController = rootViewController.topMostViewController()
        guard let playerViewController = viewController as? AVPlayerViewController else {
            if rootViewController is UINavigationController {
                guard let vc = (rootViewController as! UINavigationController).visibleViewController else { return }
                for childVC in vc.children  {
                    guard let playerViewController = childVC as? AVPlayerViewController else { continue }
                    playerViewController.player = self.player
                    break
                }
            }
            return
        }
        playerViewController.player = self.player
    }
    
    //MARK: Private
    
    fileprivate var playerRateObserverToken: NSKeyValueObservation?
    fileprivate var timeObserverToken: Any?
    fileprivate let nowPlayingInfoCenter = MPNowPlayingInfoCenter.default()
    
    fileprivate func setupRemoteTransportControls() {
        let commandCenter = MPRemoteCommandCenter.shared()
        commandCenter.playCommand.addTarget { [unowned self] event in
            if self.player?.rate == 0.0 {
                self.player?.play()
                return .success
            }
            return .commandFailed
        }

        commandCenter.pauseCommand.addTarget { event in
            if self.player?.rate == 1.0 {
                self.player?.pause()
                return .success
            }
            return .commandFailed
        }
    }
    
    fileprivate func updateGeneralMetadata(video: XCDYouTubeVideo) {
        guard player?.currentItem != nil else {
            nowPlayingInfoCenter.nowPlayingInfo = nil
            return
        }
        
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        let title = video.title
        
        if let thumbnailURL = video.thumbnailURL {
            URLSession.shared.dataTask(with: thumbnailURL) { (data, _, error) in
                guard error == nil else { return }
                guard data != nil else { return }
                guard let image = UIImage(data: data!) else { return }
                
                let artwork = MPMediaItemArtwork(image: image)
                nowPlayingInfo[MPMediaItemPropertyArtwork] = artwork
                self.nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
            }.resume()
        }
        
        nowPlayingInfo[MPMediaItemPropertyTitle] = title
        nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
    }
    
    fileprivate func updatePlaybackDuration() {
        let interval = CMTime(seconds: 1.0, preferredTimescale: CMTimeScale(NSEC_PER_SEC))
        
        timeObserverToken = self.player?.addPeriodicTimeObserver(forInterval: interval, queue: .main, using: {  [weak self] (time) in
            guard let player = self?.player else { return }
            guard player.currentItem != nil else { return }
            
            var nowPlayingInfo = self!.nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
            self!.duration = Float(CMTimeGetSeconds(player.currentItem!.duration))
            nowPlayingInfo[MPMediaItemPropertyPlaybackDuration] = self!.duration
            nowPlayingInfo[MPNowPlayingInfoPropertyElapsedPlaybackTime] = CMTimeGetSeconds(player.currentItem!.currentTime())
            self!.nowPlayingInfoCenter.nowPlayingInfo = nowPlayingInfo
        })
    }
    
    fileprivate func updatePlaybackRateMetadata() {
        guard player?.currentItem != nil else {
            duration = 0
            nowPlayingInfoCenter.nowPlayingInfo = nil
            return
        }
        
        var nowPlayingInfo = nowPlayingInfoCenter.nowPlayingInfo ?? [String: Any]()
        nowPlayingInfo[MPNowPlayingInfoPropertyPlaybackRate] = player!.rate
        nowPlayingInfo[MPNowPlayingInfoPropertyDefaultPlaybackRate] = player!.rate
    }
}
