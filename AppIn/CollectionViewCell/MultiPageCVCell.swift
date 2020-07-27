//
//  MultiPageCVCell.swift
//  AppIn
//
//  Created by sameer khan on 28/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class MultiPageCVCell: UICollectionViewCell,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var multiPageCollectionView: UICollectionView!
    @IBOutlet weak var goThereBtn: UIButton!
    
    var currentPage: Int = 0 {
        didSet {
            //delegate?.currentPage(currentPage)
        }
    }
                
    var content:Content? {
        didSet {
            
            if (content != nil) {
                
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
                
                self.handlePageButtons(0)
            }
            
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
        
    //MARK: UICollectionView DataSource & Delegates
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content?.pages.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        autoreleasepool {
            
            let page = self.content?.pages[indexPath.row]
            let comp = page?.components
            
            let component0 = comp?.first
            let component1 = comp?[1]
            
            
            switch component1?.type {
                
            case .Image:
                let imageCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentImageCVCell", for: indexPath) as! ContentImageCVCell
                
                imageCVCell.component = component1
                
                if let backGround = page?.backgrounds {
                    imageCVCell.background = backGround
                }
                
                if let strSticker = content?.pages[indexPath.row].frameUrl {
                    imageCVCell.stickerURL = strSticker
                }
                
                return imageCVCell
                
            case .Text:
                let textCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentTextCVCell", for: indexPath) as! ContentTextCVCell
                
                textCVCell.component0 = component0
                textCVCell.component1 = component1
                
                if let backGround = page?.backgrounds {
                    textCVCell.background = backGround
                }
                
                if let strSticker = content?.pages[indexPath.row].frameUrl {
                    textCVCell.stickerURL = strSticker
                }
                
                return textCVCell
            case .Video:
                let videoCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentVideoCVCell", for: indexPath) as! ContentVideoCVCell
                
                videoCVCell.component = component1
                
                if let backGround = page?.backgrounds {
                    videoCVCell.background = backGround
                }
                
                if let strSticker = content?.pages[indexPath.row].frameUrl {
                    videoCVCell.stickerURL = strSticker
                }
                
                return videoCVCell
            case .Sound:
                let soundCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentSoundCVCell", for: indexPath) as! ContentSoundCVCell
                
                soundCVCell.component = component1
                
                if let backGround = page?.backgrounds {
                    soundCVCell.background = backGround
                }
                
                if let strSticker = content?.pages[indexPath.row].frameUrl {
                    soundCVCell.stickerURL = strSticker
                }
                
                return soundCVCell
            case .Embed:
                
                if component1?.embedType == "youtube" {
                    
                    let youtubeCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentYoutubeCVCell", for: indexPath) as! ContentYoutubeCVCell

                    youtubeCVCell.component = component1

                    if let backGround = page?.backgrounds {
                        youtubeCVCell.background = backGround
                    }

                    if let strSticker = content?.pages[indexPath.row].frameUrl {
                        youtubeCVCell.stickerURL = strSticker
                    }

                    return youtubeCVCell
                                        
                }else if component1?.embedType == "vimeo" {
                    
                    let vimeoCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentVimeoCVCell", for: indexPath) as! ContentVimeoCVCell
                    
                    vimeoCVCell.component = component1
                    
                    if let backGround = page?.backgrounds {
                        vimeoCVCell.background = backGround
                    }
                    
                    if let strSticker = content?.pages[indexPath.row].frameUrl {
                        vimeoCVCell.stickerURL = strSticker
                    }
                    
                    return vimeoCVCell
                }
                
            case .none:
                print("image")
            }
            
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
                
        if let cell = cell as? ContentSoundCVCell {
            cell.pauseMedia()
        }
        
        if let cell = cell as? ContentVideoCVCell {
            cell.pauseMedia()
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
    
    //MARK: IBActions
    @IBAction func goThereButtonClicked(_ sender: UIButton) {
        /*
        print("testTap = \(currentPage)")
                
        if let idin = content?.pages[currentPage].identity, let action = content?.pages[currentPage].consumeAction {
            
            print("--- IDIN --- \(idin) ----- ACTION ----- \(action)")
            
            switch action {
                
            case 1:
                
                //print("id = \(ContentSetupViewController.ambassadorId)")
                
                if let id = content?.pages[currentPage].id {
                    UserManager.sharedInstance.useCoupon("\(ContentSetupViewController.ambassadorId!)", pageId: "\(id)") { (count, unlim, error) in
                        //print("test = \(self.content?.pages[self.currentPage].unlim)")
                        let isUnlim = self.content?.pages[self.currentPage].unlim
                        let mess = isUnlim! ? nil : "Number of Uses left: \(count)"
                        
                        if isUnlim! || count > 0 {
                            self.delegate?.showGift("Are you sure you want to use this content?", mess: mess, res: { ok in
                                UserManager.sharedInstance.tryCoupon("\(ContentSetupViewController.ambassadorId!)", pageId: "\(id)", completion: { (count, unlim, error) in
                                    
                                })
                            })
                        } else {
                            self.delegate?.showMessage("No more uses!", "")
                        }
                    }
                }
            case 3:
                
                DispatchQueue.main.async {
                    self.delegate?.showMessage("This is your code", idin)
                }
                
            case 5:
                
                DispatchQueue.main.async {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(URL(string : idin)!, options: [:], completionHandler: { (status) in })
                    } else {
                        UIApplication.shared.openURL(URL(string : idin)!)
                    }
                    
                    
                    let vc = DesignManager.loadViewControllerFromWebStoryBoard(identifier: "WebViewVC") as! WebViewVC
                    vc.isComeFrom = "APPIN"
                    vc.loadableUrlStr = idin
                    self.navigationController.pushViewController(vc, animated: true)
                    
                }
                
            case 4:
                AmbassadorshipManager.sharedInstance.requestAmbassadorhipWithCode(idin) { (ambassadorship, error, code) in
                    var message = ""
                    print("code = \(code)")
                    
                    if error != nil {
                        message = "Server error"
                    } else if ambassadorship == nil {
                        message = "You are already an ambassador for this brand"
                        //self.presentUseAlert("You are already an ambassador for this brand", "")
                        
                        return
                    } else if code == 200 || code == 201 {
                        let name = ambassadorship?.brand.name == nil ? "" : ambassadorship!.brand.name
                        message = "You have successfully connected to \(name)"
                    } else {
                        message = "An error has occurred"
                        return
                    }
                    //self.delegate?.showDialog(message)
                    DispatchQueue.main.async {
                        self.delegate?.showContentViewController(ambassadorship!)
                    }
                    
                }
            case 2:
                
                DispatchQueue.main.async {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(URL(string : idin)!, options: [:], completionHandler: { (status) in })
                    } else {
                        UIApplication.shared.openURL(URL(string : idin)!)
                    }
                }
                
            case 6:
                
                DispatchQueue.main.async {
                    guard let number = URL(string: "tel://\(idin)") else { return }
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(number, options: [:], completionHandler: { (status) in })
                    } else {
                        UIApplication.shared.openURL(number)
                    }
                }
                
            case 7:
                
                DispatchQueue.main.async {
                    self.delegatePaser?.showNewLink(link: idin)
                }
               
            case 8:
                
                Downloader.load(url: URL.init(string: idin)!, to: (content?.pages[currentPage].id)!) { (msg) in
                    
                    DispatchQueue.main.async {
                        
                        self.delegate?.showAlertForIndexOnCell("", message: msg, alertButtonTitles: ["OK"], alertButtonStyles: [.default], vc: UIViewController(), completion: { (index) in
                            
                            DispatchQueue.main.async {
                                guard let url = URL(string: idin) else { return }
                                
                                if #available(iOS 10.0, *) {
                                    UIApplication.shared.open(url, options: [:], completionHandler: { (status) in })
                                } else {
                                    UIApplication.shared.openURL(url)
                                }
                            }
                            
                        })
                    }
                }
                
            case 9:
                print("9")
                
            case 10:
                print("10")
                
            default:
                break
            }
            
        }
        */
    }
    
    //MARK: Custom Methods
    func reset() {
        if let content = content, content.pages.count > 0 {
            multiPageCollectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .top, animated: false)
        }
        pauseCells()
    }
    
    func pauseCells() {
        
        if let cells = multiPageCollectionView.visibleCells as? [ContentSoundCVCell] {
            for cell in cells {
                cell.pauseMedia()
            }
        }
        
        if let cells = multiPageCollectionView.visibleCells as? [ContentVideoCVCell] {
            for cell in cells {
                cell.pauseMedia()
            }
        }
        
    }
    
    func handlePageButtons(_ page: Int) {
        
        if currentPage != page {
            //let cell = multiPageCollectionView.dequeueReusableCell(withReuseIdentifier: "PageCell", for: IndexPath(row: currentPage, section: 0)) as! SinglePage
            //cell.pauseMedia()
        }
        
        let isIdentity = content?.pages[page].identity
        if let idin = isIdentity, let action = content?.pages[page].consumeAction {
            print("connect = \(idin)")
            print("connect1 = \(action)")
         
            
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
                    self.goThereBtn.isHidden = true
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
            if let consumeActionComp = content?.pages[page].consumeActionComponent {
                
                if let col = consumeActionComp.color {
                    
                    OperationQueue.main.addOperation {
                        self.goThereBtn.setTitleColor(UIColor.init(hexString: col), for: .normal)
                    }
                }
                
                if let rounBox = consumeActionComp.roundedBox {
                    if rounBox == "true" {
                        OperationQueue.main.addOperation {
                            self.goThereBtn.layer.cornerRadius = 10.0
                        }
                    }
                }
                
                if let backBox = consumeActionComp.backGroundBox {
                    if backBox == "true" {
                        OperationQueue.main.addOperation {
                            
                        }
                    }else {
                        OperationQueue.main.addOperation {
                            self.goThereBtn.backgroundColor = UIColor.clear
                        }
                    }
                }
                
                if let txt = consumeActionComp.text {
                    OperationQueue.main.addOperation {
                        /////self.goThereBtn.titleLabel?.text = txt
                        self.goThereBtn.setTitle(txt, for: .normal)
                    }
                }
                
                if let bxCol = consumeActionComp.boxColor {
                    OperationQueue.main.addOperation {
                        self.goThereBtn.backgroundColor = UIColor.init(hexString: bxCol)
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
        
    }
    
}

class Downloader {
    class func load(url: URL, to localFileName: Int, completion: @escaping (_ msg:String) -> ()) {
        let sessionConfig = URLSessionConfiguration.default
        let session = URLSession(configuration: sessionConfig)
        let request = try! URLRequest(url: url, method: .get)
        
        let task = session.downloadTask(with: request) { (tempLocalUrl, response, error) in
            if let _ = tempLocalUrl, error == nil {
                
                // Success
                if let statusCode = (response as? HTTPURLResponse)?.statusCode {
                    print("Success: \(statusCode)")
                }
                
                let fileName = "\(localFileName).xls"
                
                let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
                let documentDirectoryPath:String = path[0]
                let fileManager = FileManager()
                                
                var destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath)
                
                do {
                    //try fileManager.createDirectory(at: destinationURLForFile, withIntermediateDirectories: true, attributes: nil)
                    destinationURLForFile.appendPathComponent(String(describing: fileName))
                    
                    if fileManager.fileExists(atPath: destinationURLForFile.path) {
                        completion("File Already Exist!")
                    }else {
                        
                        try fileManager.moveItem(at: tempLocalUrl ?? URL.init(string: "")!, to: destinationURLForFile)
                        
                        completion("File Download & Save!")
                        
                    }
                    
                }catch(let error){
                    print(error)
                    completion("File Download but Unable Save!")
                }
                
            } else {
                print("Failure: %@", error?.localizedDescription ?? "")
                completion("File Download Failed!")
            }
        }
        task.resume()
    }
    
}
