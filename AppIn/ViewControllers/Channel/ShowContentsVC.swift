//
//  ShowContentsVC.swift
//  AppIn
//
//  Created by sameer khan on 28/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class ShowContentsVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var contentCollectionView: UICollectionView!
    @IBOutlet weak var lblContentTitle: UILabel!
    
    var documentInteractionController : UIDocumentInteractionController!
    var strTitle : String?
    
    static var ambassadorId: Int?
    var contentId: Int?
    
    // MARK: Data
    var ambassadorship: Ambassadorship? {
        didSet {
            if let ambassadorship = ambassadorship {
                ShowContentsVC.ambassadorId = ambassadorship.id
            }
        }
    }
    
    var contents: [Content]? {
        didSet {
            
        }
    }
    
    var user: User? {
        didSet {
            print("USER HAS BEEN SET")
            guard let user = user else { return }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let str = strTitle {
            self.lblContentTitle.text = str
        }

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
    
    @IBAction func againBackBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func shareContentImageBtnClicked(_ sender: UIButton) {
        
        // text to share
        let sharedText = "Shared via AppIn! Download AppIn Now from Apple App Store and Google Play Store!"
        
        // image to share
        //let sharedImage = #imageLiteral(resourceName: "logo_white")
        let sharedImage = UIView().takeScreenshot(captureView: self.contentCollectionView)
        
        // set up activity view controller
        let sharedData = [ sharedImage ?? UIImage() , sharedText] as [Any]
        let activityViewController = UIActivityViewController(activityItems: sharedData, applicationActivities: nil)
        
        // so that iPads won't crash
        activityViewController.popoverPresentationController?.sourceView = self.view
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.addToReadingList, UIActivity.ActivityType.assignToContact, UIActivity.ActivityType.copyToPasteboard, UIActivity.ActivityType.message, UIActivity.ActivityType.openInIBooks, UIActivity.ActivityType.postToTencentWeibo, UIActivity.ActivityType.postToWeibo, UIActivity.ActivityType.postToFlickr ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
        
        
        /*
        let sharedImage = UIView().takeScreenshot(captureView: self.contentCollectionView) ?? UIImage()

        if let imageData = sharedImage.jpegData(compressionQuality: 1.0) {
            let tempFile = NSURL(fileURLWithPath: NSHomeDirectory()).appendingPathComponent("Documents/whatsAppTmp.wai")!
            do {
                try imageData.write(to: tempFile, options: .atomic)
                self.documentInteractionController = UIDocumentInteractionController(url: tempFile)
                //self.documentInteractionController.uti = "net.whatsapp.image"
                self.documentInteractionController.uti = "Shared via AppIn! Download AppIn Now from Apple App Store and Google Play Store!"
                
                self.documentInteractionController.presentOpenInMenu(from: CGRect.zero, in: self.view, animated: true)
            } catch {
                print(error)
            }
        }
        */
        
        
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
    
        //from Old Code
        let content = contents?[indexPath.row]
        multiPageCVCell.content = content
        
        return multiPageCVCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentCollectionView.frame.size.width, height: self.contentCollectionView.frame.size.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        print(indexPath.row)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
