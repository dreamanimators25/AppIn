//
//  MultiPageCell.swift
//  AppIn
//
//  Created by sameer khan on 01/11/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AVFoundation
import SwiftyJSON

class MultiPageCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var multiPageCollectionView: UICollectionView!
        
    var delegate: MultiPageDelegate?
    
    var currentPage: Int = 0 {
        didSet {
            delegate?.currentPage(currentPage)
        }
    }
    
    var currentSubPage: Int = 0 {
        didSet {
            delegate?.currentSubPage(currentSubPage)
        }
    }
          
    /*
    var content:Content? {
        didSet {
            
            if (content != nil) {
                
                currentPage = 0
                
                self.multiPageCollectionView.register(UINib(nibName: "ContentImageCVCell", bundle: nil), forCellWithReuseIdentifier: "ContentImageCVCell")
                self.multiPageCollectionView.register(UINib(nibName: "ContentTextCVCell", bundle: nil), forCellWithReuseIdentifier: "ContentTextCVCell")
                self.multiPageCollectionView.register(UINib(nibName: "ContentVideoCVCell", bundle: nil), forCellWithReuseIdentifier: "ContentVideoCVCell")
                self.multiPageCollectionView.register(UINib(nibName: "ContentSoundCVCell", bundle: nil), forCellWithReuseIdentifier: "ContentSoundCVCell")
                self.multiPageCollectionView.register(UINib(nibName: "ContentYoutubeCVCell", bundle: nil), forCellWithReuseIdentifier: "ContentYoutubeCVCell")
                self.multiPageCollectionView.register(UINib(nibName: "ContentVimeoCVCell", bundle: nil), forCellWithReuseIdentifier: "ContentVimeoCVCell")

                if multiPageCollectionView.dataSource == nil {
                    multiPageCollectionView.delegate = self
                    multiPageCollectionView.dataSource = self
                }
                
                multiPageCollectionView.reloadData()
                multiPageCollectionView.performBatchUpdates({
                    print("Loaded done")
                }) { (result) in
                    print(result)
                    
                    if let raw = selectedRaw {
                        
                        self.multiPageCollectionView.scrollToItem(at: IndexPath.init(row: raw, section: 0), at: [.centeredHorizontally,.centeredVertically], animated: false)
                        
                        self.handlePageButtons(raw)
                        
                        selectedRaw = nil
                    }
                }
                            
                if let raw = selectedRaw {
                    self.handlePageButtons(raw)
                }else {
                    self.handlePageButtons(0)
                }
                
            }
            
        }
    }*/
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        linkOpenInWebView = { link in
            DispatchQueue.main.async {
                self.delegate?.openLinkInAppInWebView(link: link)
            }
        }
        
    }
    
    //var content : Int = 0 {
    var content : AllFeedChannels? {
        didSet {
            
            //self.multiPageCollectionView.register(UINib(nibName: "SinglePageCell", bundle: nil), forCellWithReuseIdentifier: "SinglePageCell")
            
            if multiPageCollectionView.dataSource == nil {
                multiPageCollectionView.delegate = self
                multiPageCollectionView.dataSource = self
            }
            
            multiPageCollectionView.reloadData()
            
            if AppDelegate.sharedDelegate().selNotiPageID != -1 {
                
                self.multiPageCollectionView.scrollToItem(at: IndexPath.init(row: AppDelegate.sharedDelegate().multiNotiPageID, section: 0), at: [.centeredHorizontally,.centeredVertically], animated: true)
                
                AppDelegate.sharedDelegate().selNotiPageID = -1
            }
                
            
        }
    }
    
    
    //MARK: UICollectionView DataSource & Delegates
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content?.pages?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
       
        autoreleasepool {
                                    
            let SinglePageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SinglePageCell", for: indexPath) as! SinglePageCell
            
            //let page = self.content?.pages?[indexPath.row]
            let page = self.content?.pages?[indexPath.item]
            
            SinglePageCell.goThereBtn.tag = indexPath.row
            SinglePageCell.content = page
            
            SinglePageCell.channelNameLbl.text = self.content?.name
            
            if let url = URL(string: self.content?.logo ?? "") {
                SinglePageCell.channelImageView.af_setImage(withURL: url)
            }
            
            SinglePageCell.accessCode = self.content?.shortCode ?? ""
            SinglePageCell.QrCode = self.content?.qrCode ?? ""
            SinglePageCell.pageID = self.content?.internalIdentifier ?? ""
            
            return SinglePageCell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
    
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
        return CGSize(width: self.multiPageCollectionView.bounds.width, height: self.multiPageCollectionView.bounds.height)
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let page = self.content?.pages?[indexPath.item]
        self.callViewContentWebService(contID: self.content?.internalIdentifier ?? "",pageid: page?.pageId ?? "")
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
//        if let cell = cell as? SinglePageCell {
//            cell.pauseMedia()
//        }
                        
        if let cell = cell as? MultiPageCell {
            cell.reset()
        }
    }
    
    //MARK: Custom Methods
    
    func reset() {
        
        if let content = content, content.pages?.count ?? 0 > 0 {
            multiPageCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
        pauseCells()
    }
    
    func pauseCells() {
        
        if let cells = multiPageCollectionView.visibleCells as? [ContentImageCVCell] {
            for cell in cells {
                cell.pauseMedia()
                
                if let pause = cell.pauseImageMp3 {
                    pause()
                }
            }
        }
        
        if let cells = multiPageCollectionView.visibleCells as? [ContentTextCVCell] {
            for cell in cells {
                cell.pauseMedia()
                
                if let pause = cell.pauseTextMp3 {
                    pause()
                }
            }
        }
        
        if let cells = multiPageCollectionView.visibleCells as? [ContentVideoCVCell] {
            for cell in cells {
                cell.pauseMedia()
                
                if let pause = cell.pauseVideoMp3 {
                    pause()
                }
            }
        }
        
        if let cells = multiPageCollectionView.visibleCells as? [ContentSoundCVCell] {
            for cell in cells {
                cell.pauseMedia()
                
                if let pause = cell.pauseSoundMp3 {
                    pause()
                }
            }
        }
        
        if let cells = multiPageCollectionView.visibleCells as? [ContentYoutubeCVCell] {
            for cell in cells {
                cell.pauseMedia()
                
                if let pause = cell.pauseYoutubeMp3 {
                    pause()
                }
            }
        }
        
        if let cells = multiPageCollectionView.visibleCells as? [ContentVimeoCVCell] {
            for cell in cells {
                cell.pauseMedia()
                
                if let pause = cell.pauseVimeoMp3 {
                    pause()
                }
            }
        }
        
    }
    
    func handlePageButtons(_ page: Int) {
        
        /*
        if currentPage != page {
            //let cell = multiPageCollectionView.dequeueReusableCell(withReuseIdentifier: "PageCell", for: IndexPath(row: currentPage, section: 0)) as! SinglePage
            //cell.pauseMedia()
            
            if let cell = multiPageCollectionView.dequeueReusableCell(withReuseIdentifier: "ContentImageCVCell", for: IndexPath(row: currentPage, section: 0)) as? ContentImageCVCell {
                cell.pauseMedia()
            }
            if let cell = multiPageCollectionView.dequeueReusableCell(withReuseIdentifier: "ContentTextCVCell", for: IndexPath(row: currentPage, section: 0)) as? ContentTextCVCell {
                cell.pauseMedia()
            }
            if let cell = multiPageCollectionView.dequeueReusableCell(withReuseIdentifier: "ContentVideoCVCell", for: IndexPath(row: currentPage, section: 0)) as? ContentVideoCVCell {
                cell.pauseMedia()
            }
            if let cell = multiPageCollectionView.dequeueReusableCell(withReuseIdentifier: "ContentSoundCVCell", for: IndexPath(row: currentPage, section: 0)) as? ContentSoundCVCell {
                cell.pauseMedia()
            }
            if let cell = multiPageCollectionView.dequeueReusableCell(withReuseIdentifier: "ContentYoutubeCVCell", for: IndexPath(row: currentPage, section: 0)) as? ContentYoutubeCVCell {
                cell.pauseMedia()
            }
            if let cell = multiPageCollectionView.dequeueReusableCell(withReuseIdentifier: "ContentVimeoCVCell", for: IndexPath(row: currentPage, section: 0)) as? ContentVimeoCVCell {
                cell.pauseMedia()
            }
        }
        
        //let isIdentity = content?.pages?[page].identity
        let isIdentity = content?.pages?[page].content
        //if let idin = isIdentity, let action = content?.pages?[page].consumeAction {
        if let idin = isIdentity, let action = content?.pages?[page].contentType {
            //print("connect = \(idin)")
            //print("connect1 = \(action)")
         
            //To handle case of MultiLink & InAppLink
            
            switch action {
            case 0:
                print("0 - Information")
                // no action button
                
                OperationQueue.main.addOperation {
                    self.goThereBtn.isHidden = true
                }
                
            case 1:
                print("1 - Consumable")
                // no action button
                
                OperationQueue.main.addOperation {
                    self.goThereBtn.isHidden = false
                    self.goThereBtn.setTitle("Use Offer", for: .normal)
                }
                
            case 2:
                print("2 - link")
                
                OperationQueue.main.addOperation {
                    self.goThereBtn.isHidden = false
                    self.goThereBtn.setTitle("Go There", for: .normal)
                }
                
            case 3:
                print("3 - Code")
                
                OperationQueue.main.addOperation {
                    self.goThereBtn.isHidden = false
                    self.goThereBtn.setTitle("Get Code", for: .normal)
                }
                
            case 4:
                print("4 - Affiliate")
                
                OperationQueue.main.addOperation {
                    self.goThereBtn.isHidden = false
                    self.goThereBtn.setTitle("Connect to channel", for: .normal)
                }
                
            case 5:
                print("5 - Document")
                    
                OperationQueue.main.addOperation {
                    self.goThereBtn.isHidden = false
                    self.goThereBtn.setTitle("Read", for: .normal)
                }
                
            case 6:
                print("6 - phone")
                
                OperationQueue.main.addOperation {
                    self.goThereBtn.isHidden = false
                    self.goThereBtn.setTitle("Call", for: .normal)
                }
                
            case 7:
                print("7 - email")
                
                OperationQueue.main.addOperation {
                    self.goThereBtn.isHidden = false
                    self.goThereBtn.setTitle("Email", for: .normal)
                }
                
            case 8:
                print("8 - Excel")
                
                OperationQueue.main.addOperation {
                    self.goThereBtn.isHidden = false
                    self.goThereBtn.setTitle("View Excel", for: .normal)
                }
                
            case 9:
                print("9 - MultiLink")
                
                OperationQueue.main.addOperation {
                    self.goThereBtn.isHidden = true
                    
                    //self.addMultiLinkOnView(page: (self.content?.pages[page])!)
                }
                
            case 10:
                print("10 - InAppLink")
                
                OperationQueue.main.addOperation {
                    self.goThereBtn.isHidden = true
                    
                    //self.addInAppLinkOnView()
                }
                
            default:
                break
            }
            
           
            //New Functionality For GoThereButton
            if let consumeActionComp = content?.pages?[page].consumeActionComponent {
                
                if let backBox = consumeActionComp.backGroundBox {
                    if backBox == "true" {
                        
                        if let bxCol = consumeActionComp.boxColor {
                            OperationQueue.main.addOperation {
                                self.goThereBtn.backgroundColor = UIColor.init(hexString: bxCol)
                            }
                        }else {
                            OperationQueue.main.addOperation {
                                self.goThereBtn.backgroundColor = UIColor.clear
                            }
                        }
                        
                    }else {
                        OperationQueue.main.addOperation {
                            self.goThereBtn.backgroundColor = UIColor.clear
                        }
                    }
                }
                
                if let rounBox = consumeActionComp.roundedBox {
                    if rounBox == "true" {
                        OperationQueue.main.addOperation {
                            self.goThereBtn.layer.cornerRadius = 10.0
                        }
                    }else {
                        OperationQueue.main.addOperation {
                            self.goThereBtn.layer.cornerRadius = 0.0
                        }
                    }
                }else {
                    OperationQueue.main.addOperation {
                        self.goThereBtn.layer.cornerRadius = 0.0
                    }
                }
                
                if let opact = consumeActionComp.opacity {
                    OperationQueue.main.addOperation {
                        if let n = NumberFormatter().number(from: opact) {
                            let opacty = CGFloat(truncating: n)
                            
                            self.goThereBtn.backgroundColor = self.goThereBtn.backgroundColor?.withAlphaComponent(opacty)
                        }
                    }
                }
                
                if let txt = consumeActionComp.text {
                    OperationQueue.main.addOperation {
                        self.goThereBtn.setTitle(txt, for: .normal)
                    }
                }
                
                if let col = consumeActionComp.color {
                    OperationQueue.main.addOperation {
                        self.goThereBtn.setTitleColor(UIColor.init(hexString: col), for: .normal)
                    }
                }
                
                if let fntSize = consumeActionComp.fontSize {
                    OperationQueue.main.addOperation {
                        if let n = NumberFormatter().number(from: fntSize) {
                            let f = CGFloat(truncating: n)
                            
                            self.goThereBtn.titleLabel?.font = UIFont.systemFont(ofSize: f)
                        }
                    }
                }

            }
            
        } else {
            
            OperationQueue.main.addOperation {
                self.goThereBtn.isHidden = true
            }
            
        }
        
        MultiPageCVCell.currPage = page
        currentPage = page
        */
    }
    
    //MARK: Web Service
    func callViewContentWebService(contID : String,pageid : String) {
                
        let userData = UserDefaults.getUserData()
        
        var params = [String : String]()
        params = ["contentId" : contID,
                  "user_id" : userData?.UserId ?? "",
                  "pageId" : pageid]
        
        print("params = \(params)")
        
        Alamofire.request(kViewContentURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
            
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
