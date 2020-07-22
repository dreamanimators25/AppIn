//
//  ChannelVC.swift
//  AppIn
//
//  Created by sameer khan on 28/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import Crashlytics
import AVFoundation
import MobileCoreServices

class ContentVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var lblChannelTitle: UILabel!
    
    var strTitle : String?
    
    static var ambassadorId: Int?
    var contentArray = [Content]()
    
    // MARK: Data
    var ambassadorship: Ambassadorship? {
        didSet {
            if let ambassadorship = ambassadorship {
                ContentVC.ambassadorId = ambassadorship.id
                updateContentWithId(ambassadorship.id)
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
            guard user != nil else { return }
            //updateContentWithContentId(user.id)
        }
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let str = strTitle {
            self.lblChannelTitle.text = str
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
    
    //MARK: Custom Methods
    func createThumbnailForVideo(atURL videoURL: URL , completion : @escaping (UIImage?)->Void) {
        
        let asset = AVAsset(url: videoURL)
        let assetImgGenerate = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        let time = CMTimeMakeWithSeconds(1, preferredTimescale: 60)
        let times = [NSValue(time: time)]
        
        assetImgGenerate.generateCGImagesAsynchronously(forTimes: times, completionHandler: {  _, image, _, _, _ in
            if let image = image {
                let uiImage = UIImage(cgImage: image)
                completion(uiImage)
            } else {
                completion(nil)
            }
        })
    }
    
    //MARK: - Content Web Service
    
    func updateContentWithId(_ id: Int) {
        ContentManager.sharedInstance.getContentForId(id) { (contents, error) in
            if let contents = contents {
                self.contentArray += contents
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
                    self.updateContentWithContentId((self.user?.id)!)
                })
                
                print("Added contents from channel to array")
                
//                DispatchQueue.main.async(execute: {
//                    self.contentTableView.reloadData()
//                })
                
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
                                
                print("Just added contents from other user to array")
                
                DispatchQueue.main.async(execute: {
                
                    self.contentTableView.reloadData()
                    
//                    self.contentTableView.performBatchUpdates({
//                        print("Loaded done")
//                    }, completion: { (bool) in
//
//                    })
                    
                })
            } else if let error = error {
                Crashlytics.sharedInstance().recordError(error)
            }
        })
    }
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: UITableView DataSource & Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.contents?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contentTVCell = tableView.dequeueReusableCell(withIdentifier: "ContentTVCell", for: indexPath) as! ContentTVCell
        
        contentTVCell.lblContentTitle.text = self.contents?[indexPath.row].title
        contentTVCell.contentCollectionView.tag = indexPath.row
        contentTVCell.contentCollectionView.reloadData()
                
        return contentTVCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
                
    }
    
    //MARK: UICollectionView DataSource & Delegates
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.contents?[collectionView.tag].pages.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let contentCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCVCell", for: indexPath) as! ContentCVCell
        
        let contentItem = self.contents?[collectionView.tag]
        let pageItem = contentItem?.pages[indexPath.row]
        let backGroundItem = pageItem?.backgrounds
        
        
        if backGroundItem?.type == .Image {
            
            OperationQueue.main.addOperation {
                guard contentCVCell.contentImageView.image == nil else {
                    return
                }
                
                if let url = URL(string: backGroundItem?.file_url ?? "") {
                    contentCVCell.contentImageView.af_setImage(withURL: url)
                    contentCVCell.contentImageView.backgroundColor = Color.backgroundColorFadedDark()
                } else {
                    contentCVCell.contentImageView.backgroundColor = Color.backgroundColorFadedDark()
                }
                
            }
            
        }else {
            if let url = URL(string: backGroundItem?.file_url ?? "") {
                
                DispatchQueue.global().async {
                    
                    OperationQueue.main.addOperation {
                        guard contentCVCell.contentImageView.image == nil else {
                            return
                        }
                    }
                    
                    self.createThumbnailForVideo(atURL: url) { (thumbnail) in
                        
                        //DispatchQueue.main.async {
                        OperationQueue.main.addOperation {
                            contentCVCell.contentImageView.image = thumbnail
                            contentCVCell.contentImageView.backgroundColor = Color.backgroundColorFadedDark()
                        }
                        
                    }
            }
                
            } else {
                contentCVCell.contentImageView.backgroundColor = Color.backgroundColorFadedDark()
            }
        }
        
        contentCVCell.lblContentFooter.text = pageItem?.identity
        
        return contentCVCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DesignManager.loadViewControllerFromContentStoryBoard(identifier: "ShowContentsVC") as! ShowContentsVC
        vc.strTitle = "CAMERA"
        vc.contents = self.contents
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
    
        return CGSize(width: self.view.frame.size.width/4 - 10, height: self.view.frame.size.width/2.6 - 10)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
