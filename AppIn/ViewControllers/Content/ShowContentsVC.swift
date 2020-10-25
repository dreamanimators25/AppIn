//
//  ShowContentsVC.swift
//  AppIn
//
//  Created by sameer khan on 28/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import HCVimeoVideoExtractor
import AVFoundation
import AVKit
import MessageUI
import Crashlytics

var loadVimeoPlayer : ((_ url:String)-> (Void))?
var loadCollectionView : ((_ index:IndexPath)-> (Void))?
var actualContents = [Content]()

class ShowContentsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var captureView: UIView!
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var lblContentTitle: UILabel!
    @IBOutlet weak var rightButton: UIButton!
    @IBOutlet weak var leftButton: UIButton!
    
    var documentInteractionController : UIDocumentInteractionController!
    var strTitle : String?
    
    static var ambassadorId: Int?
    var contentId: Int?
    
    var selectedInd = 0
    
    // MARK: Data
    var ambassadorship: Ambassadorship? {
        didSet {
            if let ambassadorship = ambassadorship {
                ShowContentsVC.ambassadorId = ambassadorship.id
                
                updateContentWithId(ambassadorship.id)
            }
        }
    }
    
    var contentArray = [Content]()
    var contents: [Content]? {
        didSet {
            self.setupStatistics(self.contents ?? [])
        }
    }
    
    var user: User? {
        didSet {
            print("USER HAS BEEN SET")
            guard let user = user else { return }
        }
    }
    
    static var currentContent = 0
    var currentSubPage = 0
    static var currentPage: Int = 0
    
    // MARK: - Statistics
    var statistics: AmbassadorStatistic?
    var statsTimer = Timer()
    var startTime = TimeInterval()
    var secondsOnPage: Int = 0
    var clicksOnPage: Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let str = strTitle {
            self.lblContentTitle.text = str
        }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        
        loadVimeoPlayer = { vimURL in
            self.showVimeoPlayer(vimURL)
        }
        
        loadCollectionView = { ind in
            self.contentCollectionView.reloadData()
            
            self.contentCollectionView.scrollToItem(at: IndexPath.init(row: ind.row, section: ind.section), at: [.centeredHorizontally,.centeredVertically], animated: false)
        }
        
        self.contentCollectionView.performBatchUpdates({
            print("Loaded Done!")
        }) { (result) in
            print(result)
            
            if let sec = selectedSection {
                self.contentCollectionView.reloadData()
                
                self.contentCollectionView.scrollToItem(at: IndexPath.init(row: sec, section: 0), at: [.centeredHorizontally,.centeredVertically], animated: false)
                selectedRaw = self.selectedInd
                selectedSection = nil
            }
        }
                
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: - Content WebService
    
    func updateContentWithId(_ id: Int) {
        ContentManager.sharedInstance.getContentForId(id) { (contents, error) in
            if let contents = contents {
                self.contentArray += contents
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    self.updateContentWithContentId((self.user?.id)!)
                })
                
                print("Added contents from channel to array")
                DispatchQueue.main.async(execute: {
                    
                    self.setupStatistics(contents)
                    self.handleContentButtons()
                    //self.contentCollectionView.reloadData()
                })
            } else if let error = error {
                Crashlytics.sharedInstance().recordError(error)
            }
        }
    }
    
    func updateContentWithContentId(_ id: Int) {
        ContentManager.sharedInstance.getSharedContent(id, completion: {contents, error in
            if let contents = contents {
                
                self.contentArray += contents
                self.contents = self.contentArray
                
                actualContents = self.contentArray
                
                print("Just added contents from other user to array")
                DispatchQueue.main.async(execute: {
                    
                    self.setupStatistics(self.contents ?? [])
                    self.handleContentButtons()
                    self.contentCollectionView.reloadData()
                })
            } else if let error = error {
                Crashlytics.sharedInstance().recordError(error)
            }
        })
    }
    
    //MARK: Custom Methods
    
    func closeChannel() {
        let cells = contentCollectionView.visibleCells
        
        for cell in cells {
            if let cell = cell as? MultiPageCVCell {
                cell.closeCell = false
                cell.reset()
            }
        }
        
        self.endStats()
    }
    
    // MARK: - Statistics
    func setupStatistics(_ contents: [Content]) {
        backgroundThread(0.0, background: {
            var contentIds = [Int]()
            var pageIds = [Int:[Int]]()
            var i = 0
            for content in contents {
                contentIds.append(content.id)
                var ids = [Int]()
                for page in content.pages {
                    ids.append(page.id)
                }
                pageIds[i] = ids
                i += 1
            }
            var statId = 0
            if let id = self.contentId {
                statId = id
            } else if let ambassadorship = self.ambassadorship {
                statId = ambassadorship.id
            }
            self.statistics = AmbassadorStatistic(id: statId, contentIds: contentIds, pageIds: pageIds)
            }, completion: {
                self.resetTimer()
                self.startTimer()
        })
    }
    
    func resetTimer() {
        statsTimer.invalidate()
    }
    
    func startTimer() {
        if !statsTimer.isValid {
            statsTimer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
            startTime = Date.timeIntervalSinceReferenceDate
        }
    }
    
    @objc func updateTime() {
        let currentTime = Date.timeIntervalSinceReferenceDate
        var elapsedTime: TimeInterval = currentTime - startTime
        let minutes = round(elapsedTime / 60.0)
        
        elapsedTime -= (TimeInterval(minutes) * 60)
        let seconds = round(elapsedTime)
        
        secondsOnPage = Int(seconds)
    }
    
    func endStats() {
        if let statis = statistics {
            statis.addPageDuration(ShowContentsVC.currentContent, page: ShowContentsVC.currentPage, seconds: secondsOnPage)
            StatisticsManager.sharedInstance.sendAmbassadorStatistics(statis, completion: { success, error in
                 debugPrint("Error: \(String(describing: error))")
            })
        }
    }
    
    func addClickCount() {
        if let stats = statistics {
            stats.addPageClicks(ShowContentsVC.currentContent, page: ShowContentsVC.currentPage, clicks: 1)
        }
    }
    
    func addDuration() {
        resetTimer()
        if let stats = statistics {
            stats.addPageDuration(ShowContentsVC.currentContent, page: ShowContentsVC.currentPage, seconds: secondsOnPage)
        }
        startTimer()
    }
    
    //MARK: IBAction
    @IBAction func leftButtonPressed(_ sender: UIButton) {
        scrollContent(-1)
    }
    
    @IBAction func rightButtonPressed(_ sender: UIButton) {
        scrollContent(1)
    }
    
    func scrollContent(_ direction: Int) {
        contentCollectionView.scrollHorizontal(ShowContentsVC.currentContent + direction, animated: true)
    }
    
    @IBAction func backBtnClicked(_ sender: UIButton) {
        selectedRaw = nil
        selectedSection = nil
        
        self.closeChannel()        
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func againBackBtnClicked(_ sender: UIButton) {
        selectedRaw = nil
        selectedSection = nil
        
        self.closeChannel()
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareContentImageBtnClicked(_ sender: UIButton) {
        
        // text to share
        let sharedText = "Shared via AppIn! Download AppIn Now from Apple App Store and Google Play Store!"
        
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
        let sharedImage = UIView().takeScreenshot(captureView: self.captureView)
        
        //To Show GoThereButton After capture image of whole view
        for cell in cells {
            if let cell = cell as? MultiPageCVCell {
                cell.goThereBtn.isHidden = btnStt
            }
        }
        
        // set up activity view controller
        let sharedData = [ sharedImage ?? UIImage() , sharedText] as [Any]
        let activityViewController = UIActivityViewController(activityItems: sharedData, applicationActivities: nil)
        
        // so that iPads won't crash
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.assignToContact, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.message, UIActivity.ActivityType.openInIBooks, UIActivity.ActivityType.postToTencentWeibo, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.postToFlickr ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    //MARK: UICollectionView DataSource & Delegates
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return contents?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let multiPageCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MultiPageCVCell", for: indexPath) as! MultiPageCVCell
        
        //From Old Code
        //let content = contents?[indexPath.row]
        //multiPageCVCell.content = content
        //multiPageCVCell.delegate = self
        
        return multiPageCVCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let cell = cell as? MultiPageCVCell {
            let content = contents?[indexPath.row]
            cell.content = content
            cell.delegate = self
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
                
        if let cell = cell as? MultiPageCVCell {
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
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        selectedRaw = nil
        selectedSection = nil
        
        if let cells = self.contentCollectionView.visibleCells as? [MultiPageCVCell] {
            for cell in cells {
                cell.reset()
            }
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
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
                
                let player = AVPlayer(url: videoURL)
                let playerController = AVPlayerViewController()
                playerController.player = player
                self.present(playerController, animated: true) {
                    player.play()
                }
                
            }
        })
    }

}

protocol ContentView {
    var view: UIView {get}
    var topMarginPercent: CGFloat {get set}
    var horizontalMarginPercent: CGFloat {get set}
    var bottomMarginPercent: CGFloat {get set}
    var marginEdgePercentage: CGFloat {get set}
    var height: CGFloat {get}
    var width: CGFloat {get}
    
    func prepareForReuse()
}

extension ShowContentsVC: MultiPageDelegate {
    
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
        contentViewController.user = user
        
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
        currentSubPage = page
        print("curr sub page = \(currentSubPage)")
    }

    func currentPage(_ page: Int) {
        addDuration()
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

extension ShowContentsVC : UIScrollViewDelegate {
    
    // MARK: - UIScrollViewDelegate
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        var scrollOffset = scrollView.contentOffset.x
        let contentWidht = contentCollectionView.contentSize.width - contentCollectionView.frame.size.width
        
        var indexPath:IndexPath?
        //print("Cell indexPath is:-\(indexPath.row)")
        
        if scrollOffset < 0 {
            indexPath = IndexPath(row: 0, section: 0)
        } else if scrollOffset > contentWidht {
            indexPath = IndexPath(row: contentCollectionView.numberOfHorizontalPages()-1, section: 0)
            print("Cell indexPath is:-\(indexPath?.row ?? 0)")
            scrollOffset = scrollOffset - contentWidht
        }
        if let indexPath = indexPath {
            if let cell = contentCollectionView.cellForItem(at: indexPath) as? MultiPageCVCell {
                cell.zoomBackground(scrollOffset, y: 0)
            }
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        calculateCurrentContentNumber()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        calculateCurrentContentNumber()
    }
    
    func calculateCurrentContentNumber() {
        addDuration()
        handleContentButtons()
    }
    
    func handleContentButtons() {
        guard let scroll = contentCollectionView else { return }
        
        ShowContentsVC.currentContent = scroll.currentHorizontalPage()
        print("curr = \(ShowContentsVC.currentContent)")
        
        shareButtons(ShowContentsVC.currentContent, 0)
        if let contents = contents, !contents.isEmpty {
            leftButton.isHidden = ShowContentsVC.currentContent == 0
            rightButton.isHidden = contents.count - 1 == ShowContentsVC.currentContent
        } else {
            leftButton.isHidden = true
            rightButton.isHidden = true
        }
    }
    
}

extension ShowContentsVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
}

