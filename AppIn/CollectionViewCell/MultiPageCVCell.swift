//
//  MultiPageCVCell.swift
//  AppIn
//
//  Created by sameer khan on 28/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

protocol MultiPageDelegate {
    func currentSubPage(_ page: Int)
    func currentPage(_ page: Int)
    func shareContent(_ id: Int)
    func shareContentOutbound(_ id: Int)
    func presentUseAlert(_ title: String, _ message: String)
    func showAlertOnCell(_ title: String, _ message: String)
    func showAlertForIndexOnCell(_ title: String, message: String, alertButtonTitles: [String], alertButtonStyles: [UIAlertAction.Style], vc: UIViewController, completion: @escaping (Int)->Void) -> Void
    func shareFacebook(_ imageView: UIImageView, isBack: Bool, page: Int)
    func shareInstagram(_ imageView: UIImageView)
    func shareTwitter(_ imageView: UIImageView, isBack: Bool, page: Int)
    func shareFacebookLink(_ link: String)
    func shareTwitterLink(_ link: String)
    func showDialog(_ message: String)
    func showContentViewController(_ amb: Ambassadorship)
    func showMessage(_ title: String, _ message: String)
    func showGift(_ title: String, mess: String?, res: @escaping (_ ok: Bool) -> ())
    
    func openLinkInAppInWebView(link: String)
    func openEmailLink(link: String)
}

class MultiPageCVCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var multiPageCollectionView: UICollectionView!
    @IBOutlet weak var goThereBtn: UIButton!
    
    var delegate: MultiPageDelegate?
    
    
    //MultiLink & InAppLink
    var arrContentID = [String]()
    var arrPageID = [String]()
    var click = true
    var inAppLinkBaseView = UIView()
    var multiLinkBaseView = UIStackView()
    var base1 = UIView()
    var base2 = UIView()
    var base3 = UIView()
    var link1 = String()
    var link2 = String()
    var link3 = String()
    
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
                multiPageCollectionView.performBatchUpdates({
                    print("Loaded done")
                }) { (result) in
                    print(result)
                    
                    if let raw = selectedRaw {
                        
                        self.multiPageCollectionView.scrollToItem(at: IndexPath.init(row: raw, section: 0), at: [.centeredHorizontally,.centeredVertically], animated: false)
                        
                        self.handlePageButtons(raw)
                    }
                }
                            
                if let raw = selectedRaw {
                    self.handlePageButtons(raw)
                }else {
                    self.handlePageButtons(0)
                }
                
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
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        self.inAppLinkBaseView.removeFromSuperview()
        self.contentView.superview?.willRemoveSubview(inAppLinkBaseView)
        
        self.multiLinkBaseView.removeFromSuperview()
        self.contentView.superview?.willRemoveSubview(multiLinkBaseView)
        
        self.base1.removeFromSuperview()
        self.contentView.superview?.willRemoveSubview(base1)
        self.base2.removeFromSuperview()
        self.contentView.superview?.willRemoveSubview(base2)
        self.base3.removeFromSuperview()
        self.contentView.superview?.willRemoveSubview(base3)
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
        
        print("testTap = \(currentPage)")
        
        if let idin = content?.pages[currentPage].identity, let action = content?.pages[currentPage].consumeAction {
            
            print("--- IDIN --- \(idin) ----- ACTION ----- \(action)")
            
            switch action {
                
            case 1:
                
                //print("id = \(ContentSetupViewController.ambassadorId)")
                
                if let id = content?.pages[currentPage].id {
                    UserManager.sharedInstance.useCoupon("\(ContentVC.ambassadorId!)", pageId: "\(id)") { (count, unlim, error) in
                        //print("test = \(self.content?.pages[self.currentPage].unlim)")
                        let isUnlim = self.content?.pages[self.currentPage].unlim
                        let mess = isUnlim! ? nil : "Number of Uses left: \(count)"
                        
                        if isUnlim! || count > 0 {
                            self.delegate?.showGift("Are you sure you want to use this content?", mess: mess, res: { ok in
                                UserManager.sharedInstance.tryCoupon("\(ContentVC.ambassadorId!)", pageId: "\(id)", completion: { (count, unlim, error) in
                                    
                                })
                            })
                        } else {
                            self.delegate?.showMessage("No more uses!", "")
                        }
                    }
                }
                
            case 2:

                DispatchQueue.main.async {
                    self.delegate?.openLinkInAppInWebView(link: idin)
                }
                
            case 3:
                
                DispatchQueue.main.async {
                    self.delegate?.showMessage("This is your code", idin)
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
                
            case 5:
                
                DispatchQueue.main.async {
                    self.delegate?.openLinkInAppInWebView(link: idin)
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
                    self.delegate?.openEmailLink(link: idin)
                }
                
            case 8:
                
                Downloader.load(url: URL.init(string: idin)!, to: (content?.pages[currentPage].id)!) { (msg) in
                    
                    DispatchQueue.main.async {
                        
                        self.delegate?.showAlertForIndexOnCell("", message: msg, alertButtonTitles: ["OK"], alertButtonStyles: [.default], vc: UIViewController(), completion: { (index) in
                            
                            DispatchQueue.main.async {
                                self.delegate?.openLinkInAppInWebView(link: idin)
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
            
            if action == 10 {
                let strArray = idin.components(separatedBy: ",")
                for (index,item) in strArray.enumerated() {
                    if index % 2 == 0 {
                        if item != "" {
                            self.arrContentID.append(item)
                        }
                    }else {
                        if item != "" {
                            self.arrPageID.append(item)
                        }
                    }
                }
            }
         
            //To handle case of MultiLink & InAppLink
            self.inAppLinkBaseView.removeFromSuperview()
            self.contentView.superview?.willRemoveSubview(inAppLinkBaseView)
            
            self.multiLinkBaseView.removeFromSuperview()
            self.contentView.superview?.willRemoveSubview(multiLinkBaseView)
            
            self.base1.removeFromSuperview()
            self.contentView.superview?.willRemoveSubview(base1)
            self.base2.removeFromSuperview()
            self.contentView.superview?.willRemoveSubview(base2)
            self.base3.removeFromSuperview()
            self.contentView.superview?.willRemoveSubview(base3)
            
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
                    
                    self.addMultiLinkOnView(page: (self.content?.pages[page])!)
                }
                
            case 10:
                print("10 - InAppLink")
                
                OperationQueue.main.addOperation {
                    self.goThereBtn.isHidden = true
                    
                    self.addInAppLinkOnView()
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
    
    func addMultiLinkOnView(page : ContentPage) {
        
        self.multiLinkBaseView.removeFromSuperview()
        self.contentView.superview?.willRemoveSubview(multiLinkBaseView)
        self.base1.removeFromSuperview()
        self.contentView.superview?.willRemoveSubview(base1)
        self.base2.removeFromSuperview()
        self.contentView.superview?.willRemoveSubview(base2)
        self.base3.removeFromSuperview()
        self.contentView.superview?.willRemoveSubview(base3)
        
        
        
        multiLinkBaseView = UIStackView.init(frame: CGRect.init(x: 10, y: (self.contentView.frame.height * 20)/100, width: self.contentView.frame.size.width - 20, height: ((self.contentView.frame.width/4)*3.2)))
        
        multiLinkBaseView.axis = .vertical
        multiLinkBaseView.distribution = .fillEqually
        multiLinkBaseView.alignment = .fill
        multiLinkBaseView.spacing = 15.0
        
        
        base1 = UIView.init(frame: CGRect.init(x: 20, y: 10, width: (self.contentView.frame.width - 40), height: (self.contentView.frame.width/4)))
        let img1 = UIImageView.init(frame: CGRect.init(x: 20, y: 15, width: (base1.frame.width/3 - 50), height: (base1.frame.width/3 - 50)))
        let lbl1 = UILabel.init(frame: CGRect.init(x: img1.frame.origin.x + img1.frame.size.width + 10, y: base1.frame.size.height/4 - 10, width: base1.frame.size.width/2 + 80, height: img1.frame.size.height))
        lbl1.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbl1.numberOfLines = 0
        
        
        lbl1.font = lbl1.font.withSize(20)
        if let txt = page.components[3].meta?.text {
            lbl1.text = txt
        }
        
        if let col = page.components[3].meta?.color {
            lbl1.textColor = col
        }
        if let size = page.components[3].meta?.size {
            lbl1.font = lbl1.font.withSize(size)
        }
        if let font = page.components[3].meta?.font {
            lbl1.font = font
        }
        if let alignment = page.components[3].meta?.textAlignment {
            lbl1.textAlignment = alignment
        }
        if let link = page.components[2].meta?.text {
            if link.hasPrefix("http://") || link.hasPrefix("https://") {
                link1 = link
            }else {
                link1 = "http://\(link)"
            }
        }
        
        
        let btn1 = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: base1.frame.size.width, height: base1.frame.size.height))
        btn1.tag = 1
        btn1.addTarget(self, action: #selector(MultiPageCVCell.btnClickedMultiLink(_:)), for: .touchUpInside)
        btn1.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        
        
        base2 = UIView.init(frame: CGRect.init(x: 20, y: base1.frame.origin.y + base1.frame.size.height + 15, width: (self.contentView.frame.width - 40), height: (self.contentView.frame.width/4)))
        
        let img2 = UIImageView.init(frame: CGRect.init(x: 20, y: 15, width: (base2.frame.width/3 - 50), height: (base2.frame.width/3 - 50)))
        let lbl2 = UILabel.init(frame: CGRect.init(x: img2.frame.origin.x + img2.frame.size.width + 10, y: base2.frame.size.height/4 - 10, width: base2.frame.size.width/2 + 80, height: img2.frame.size.height))
        lbl2.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbl2.numberOfLines = 0
        
        
        lbl2.font = lbl2.font.withSize(20)
        if let txt = page.components[5].meta?.text {
            lbl2.text = txt
        }
        if let col = page.components[5].meta?.color {
            lbl2.textColor = col
        }
        if let size = page.components[5].meta?.size {
            lbl2.font = lbl2.font.withSize(size)
        }
        if let font = page.components[5].meta?.font {
            lbl2.font = font
        }
        if let alignment = page.components[5].meta?.textAlignment {
            lbl2.textAlignment = alignment
        }
        if let link = page.components[4].meta?.text {
            if link.hasPrefix("http://") || link.hasPrefix("https://") {
                link2 = link
            }else {
                link2 = "http://\(link)"
            }
        }
        
        let btn2 = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: base2.frame.size.width, height: base2.frame.size.height))
        btn2.tag = 2
        btn2.addTarget(self, action: #selector(MultiPageCVCell.btnClickedMultiLink(_:)), for: .touchUpInside)
        btn2.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        
        
        base3 = UIView.init(frame: CGRect.init(x: 20, y: base2.frame.origin.y + base2.frame.size.height + 15, width: (self.contentView.frame.width - 40), height: (self.contentView.frame.width/4)))
        
        let img3 = UIImageView.init(frame: CGRect.init(x: 20, y: 15, width: (base3.frame.width/3 - 50), height: (base3.frame.width/3 - 50)))
        let lbl3 = UILabel.init(frame: CGRect.init(x: img3.frame.origin.x + img3.frame.size.width + 10, y: base3.frame.size.height/4 - 10, width: base3.frame.size.width/2 + 80, height: img3.frame.size.height))
        lbl3.lineBreakMode = NSLineBreakMode.byWordWrapping
        lbl3.numberOfLines = 0
        
        
        lbl3.font = lbl3.font.withSize(20)
        if let txt = page.components[7].meta?.text {
            lbl3.text = txt
        }
       
        if let col = page.components[7].meta?.color {
            lbl3.textColor = col
        }
        if let size = page.components[7].meta?.size {
            lbl3.font = lbl3.font.withSize(size)
        }
        if let font = page.components[7].meta?.font {
            lbl3.font = font
        }
        if let alignment = page.components[7].meta?.textAlignment {
            lbl3.textAlignment = alignment
        }
        if let link = page.components[6].meta?.text {
            if link.hasPrefix("http://") || link.hasPrefix("https://") {
                link3 = link
            }else {
                link3 = "http://\(link)"
            }
        }
        
        let btn3 = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: base3.frame.size.width, height: base3.frame.size.height))
        btn3.tag = 3
        btn3.addTarget(self, action: #selector(MultiPageCVCell.btnClickedMultiLink(_:)), for: .touchUpInside)
        btn3.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 0)
        
        
        base1.addSubview(img1)
        base1.addSubview(lbl1)
        base1.addSubview(btn1)
        base1.backgroundColor = #colorLiteral(red: 0.4117647059, green: 0.4156862745, blue: 0.4274509804, alpha: 1)
        self.multiLinkBaseView.addArrangedSubview(base1)
        
        base2.addSubview(img2)
        base2.addSubview(lbl2)
        base2.addSubview(btn2)
        base2.backgroundColor = #colorLiteral(red: 0.4117647059, green: 0.4156862745, blue: 0.4274509804, alpha: 1)
        self.multiLinkBaseView.addArrangedSubview(base2)
        
        base3.addSubview(img3)
        base3.addSubview(lbl3)
        base3.addSubview(btn3)
        base3.backgroundColor = #colorLiteral(red: 0.4117647059, green: 0.4156862745, blue: 0.4274509804, alpha: 1)
        self.multiLinkBaseView.addArrangedSubview(base3)
        
        self.addSubview(multiLinkBaseView)
        
        
        //let arr = [page.backgrounds]
        let arr = page.multiLinkBackgrounds
        
        for (_,item) in arr.enumerated() {
            
            if item.order == 1 {
                
                if (item.type).rawValue == "image" {
                    if let url1 = item.file_url {
                        img1.af_setImage(withURL: URL.init(string: url1)!)
                        
                        
                        img1.isHidden = false
                        lbl1.isHidden = false
                        btn1.isHidden = false
                        base1.isHidden = false
                    }else {
                        img1.isHidden = true
                        lbl1.isHidden = true
                        btn1.isHidden = true
                        base1.isHidden = true
                    }
                }else {
                    if let col1 = item.meta?["box_color"] as? String {
                        img1.backgroundColor = UIColor(hexString: col1)
                        
                        
                        img1.isHidden = false
                        lbl1.isHidden = false
                        btn1.isHidden = false
                        base1.isHidden = false
                    }else {
                        img1.isHidden = true
                        lbl1.isHidden = true
                        btn1.isHidden = true
                        base1.isHidden = true
                    }
                }
                
            }
            
            if item.order == 2 {
                
                if (item.type).rawValue == "image" {
                    if let url2 = item.file_url {
                        img2.af_setImage(withURL: URL.init(string: url2)!)
                        
                        
                        img2.isHidden = false
                        lbl2.isHidden = false
                        btn2.isHidden = false
                        base2.isHidden = false
                    }else {
                        img2.isHidden = true
                        lbl2.isHidden = true
                        btn2.isHidden = true
                        base2.isHidden = true
                    }
                }else {
                    if let col2 = item.meta?["box_color"] as? String {
                        img2.backgroundColor = UIColor(hexString: col2)
                        
                        
                        img2.isHidden = false
                        lbl2.isHidden = false
                        btn2.isHidden = false
                        base2.isHidden = false
                    }else {
                        img2.isHidden = true
                        lbl2.isHidden = true
                        btn2.isHidden = true
                        base2.isHidden = true
                    }
                }
                
            }
            
            if item.order == 3 {
                
                if (item.type).rawValue == "image" {
                    if let url3 = item.file_url {
                        img3.af_setImage(withURL: URL.init(string: url3)!)
                        
                        
                        img3.isHidden = false
                        lbl3.isHidden = false
                        btn3.isHidden = false
                        base3.isHidden = false
                    }else {
                        img3.isHidden = true
                        lbl3.isHidden = true
                        btn3.isHidden = true
                        base3.isHidden = true
                    }
                }else {
                    if let col3 = item.meta?["box_color"] as? String {
                        img3.backgroundColor = UIColor(hexString: col3)
                        
                        
                        img3.isHidden = false
                        lbl3.isHidden = false
                        btn3.isHidden = false
                        base3.isHidden = false
                    }else {
                        img3.isHidden = true
                        lbl3.isHidden = true
                        btn3.isHidden = true
                        base3.isHidden = true
                    }
                }
                
            }
        }
        
        var firstLine = true
        var secondLine = true
        var thirdLine = true
        
        
        //To Manage Views according to text exist
        if let txt = page.components[3].meta?.text {
            //lbl1.text = txt
            
            if txt != "" {
                img1.isHidden = false
                lbl1.isHidden = false
                btn1.isHidden = false
                base1.isHidden = false
            }else {
                firstLine = false
                
                img1.isHidden = true
                lbl1.isHidden = true
                btn1.isHidden = true
                base1.isHidden = true
            }
            
        }else {
            
            firstLine = false
            
            img1.isHidden = true
            lbl1.isHidden = true
            btn1.isHidden = true
            base1.isHidden = true
            
        }
        
        if let txt = page.components[5].meta?.text {
            
            if txt != "" {
                img2.isHidden = false
                lbl2.isHidden = false
                btn2.isHidden = false
                base2.isHidden = false
            }else {
                secondLine = false
                
                img2.isHidden = true
                lbl2.isHidden = true
                btn2.isHidden = true
                base2.isHidden = true
            }
            
        }else {
            
            secondLine = false
            
            img2.isHidden = true
            lbl2.isHidden = true
            btn2.isHidden = true
            base2.isHidden = true
            
        }
        
        if let txt = page.components[7].meta?.text {
            
            if txt != "" {
                img3.isHidden = false
                lbl3.isHidden = false
                btn3.isHidden = false
                base3.isHidden = false
            }else {
                thirdLine = false
                
                img3.isHidden = true
                lbl3.isHidden = true
                btn3.isHidden = true
                base3.isHidden = true
            }
            
        }else {
            thirdLine = false
            
            img3.isHidden = true
            lbl3.isHidden = true
            btn3.isHidden = true
            base3.isHidden = true
        }
        
        if firstLine && secondLine && thirdLine {
            self.multiLinkBaseView.frame.size.height = ((self.contentView.frame.width/4)*3.2)
        }else if firstLine && secondLine {
            self.multiLinkBaseView.frame.size.height = ((self.contentView.frame.width/4)*2.2)
        }else if firstLine && thirdLine {
            self.multiLinkBaseView.frame.size.height = ((self.contentView.frame.width/4)*2.2)
        }else if secondLine && thirdLine {
            self.multiLinkBaseView.frame.size.height = ((self.contentView.frame.width/4)*2.2)
        }else if firstLine || secondLine || thirdLine {
            self.multiLinkBaseView.frame.size.height = ((self.contentView.frame.width/4)*1.2)
        }else {
            self.multiLinkBaseView.frame.size.height = 0
        }
        
    }
    
    @objc func btnClickedMultiLink(_ sender : UIButton) {
        
        switch sender.tag {
        case 1:
            DispatchQueue.main.async {
                self.delegate?.openLinkInAppInWebView(link: self.link1)
            }
        case 2:
            DispatchQueue.main.async {
                self.delegate?.openLinkInAppInWebView(link: self.link2)
            }
        default:
            DispatchQueue.main.async {
                self.delegate?.openLinkInAppInWebView(link: self.link3)
            }
        }
    
    }
    
    func addInAppLinkOnView() {
        
        //To handle case of MultiLink & InAppLink
        self.inAppLinkBaseView.removeFromSuperview()
        self.contentView.superview?.willRemoveSubview(inAppLinkBaseView)
        
        
        
        
        inAppLinkBaseView = UIView.init(frame: CGRect.init(x: 10, y: 10, width: self.contentView.frame.size.width - 20, height: self.contentView.frame.size.height - 20))
        
        let btn1 = UIButton.init(frame: CGRect.init(x: 20, y: (self.contentView.frame.height * 17)/100, width: self.contentView.frame.size.width - 40, height: (self.contentView.frame.height * 12)/100))
        btn1.tag = 0
        btn1.addTarget(self, action: #selector(MultiPageCVCell.btnClickedInAppLink(_:)), for: .touchUpInside)
        btn1.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        btn1.backgroundColor = #colorLiteral(red: 0.1581287384, green: 0.6885935664, blue: 0.237049073, alpha: 1)
                
        let btn2 = UIButton.init(frame: CGRect.init(x: 20, y: btn1.frame.origin.y + btn1.frame.size.height + 20, width: self.contentView.frame.size.width - 40, height: (self.contentView.frame.height * 12)/100))
        btn2.tag = 1
        btn2.addTarget(self, action: #selector(MultiPageCVCell.btnClickedInAppLink(_:)), for: .touchUpInside)
        btn2.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        btn2.backgroundColor = #colorLiteral(red: 0.2588235438, green: 0.7568627596, blue: 0.9686274529, alpha: 1)
        
        let btn3 = UIButton.init(frame: CGRect.init(x: 20, y: btn2.frame.origin.y + btn2.frame.size.height + 20, width: self.contentView.frame.size.width - 40, height: (self.contentView.frame.height * 12)/100))
        btn3.tag = 2
        btn3.addTarget(self, action: #selector(MultiPageCVCell.btnClickedInAppLink(_:)), for: .touchUpInside)
        btn3.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        btn3.backgroundColor = #colorLiteral(red: 0.2196078449, green: 0.007843137719, blue: 0.8549019694, alpha: 1)
        
        let btn4 = UIButton.init(frame: CGRect.init(x: 20, y: btn3.frame.origin.y + btn3.frame.size.height + 20, width: self.contentView.frame.size.width - 40, height: (self.contentView.frame.height * 12)/100))
        btn4.tag = 3
        btn4.addTarget(self, action: #selector(MultiPageCVCell.btnClickedInAppLink(_:)), for: .touchUpInside)
        btn4.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        btn4.backgroundColor = #colorLiteral(red: 0.9098039269, green: 0.4784313738, blue: 0.6431372762, alpha: 1)
        
        let btn5 = UIButton.init(frame: CGRect.init(x: 20, y: btn4.frame.origin.y + btn4.frame.size.height + 20, width: self.contentView.frame.size.width - 40, height: (self.contentView.frame.height * 12)/100))
        btn5.tag = 4
        btn5.addTarget(self, action: #selector(MultiPageCVCell.btnClickedInAppLink(_:)), for: .touchUpInside)
        btn5.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)
        btn5.backgroundColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        
        inAppLinkBaseView.addSubview(btn1)
        inAppLinkBaseView.addSubview(btn2)
        inAppLinkBaseView.addSubview(btn3)
        inAppLinkBaseView.addSubview(btn4)
        inAppLinkBaseView.addSubview(btn5)

        //self.contentView.superview?.addSubview(baseView)
        self.addSubview(inAppLinkBaseView)
        
    }
    
    @objc func btnClickedInAppLink(_ sender : UIButton) {
        
        guard arrContentID.count > sender.tag else {
            return
        }
        
        let contId = arrContentID[sender.tag]
        let pageId = arrPageID[sender.tag]
        
        let indexOfContentID = actualContents.firstIndex(where: { $0.id == Int(contId) })
        print(indexOfContentID ?? 0)
        
        let indexOfPageID = self.content?.pages.firstIndex(where: { $0.id == Int(pageId) })
        print(indexOfPageID ?? 0)
        
        if let load = loadCollectionView {
            load(IndexPath.init(row: indexOfContentID ?? 0, section: indexOfPageID ?? 0))
        }
        
    }

    func scrollToSelectedContent(_ raw : Int, _ sec : Int) {
        
        guard arrContentID.count > sec else {
            return
        }
        
        let contId = arrContentID[sec]
        let pageId = arrPageID[raw]
        
        let indexOfContentID = actualContents.firstIndex(where: { $0.id == Int(contId) })
        print(indexOfContentID ?? 0)
        
        let indexOfPageID = self.content?.pages.firstIndex(where: { $0.id == Int(pageId) })
        print(indexOfPageID ?? 0)
        
        if let load = loadCollectionView {
            load(IndexPath.init(row: indexOfContentID ?? 0, section: indexOfPageID ?? 0))
        }
        
    }
    
    
}

extension MultiPageCVCell : UIScrollViewDelegate {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        
    }
   
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        calculateCurrentPageNumber()
    }
    
    func scrollViewDidEndScrollingAnimation(_ scrollView: UIScrollView) {
        calculateCurrentPageNumber()
    }
    
    func calculateCurrentPageNumber() {
        OperationQueue.main.addOperation {
            self.goThereBtn.isHidden = true
        }

        let page = multiPageCollectionView.currentVerticalPage()
        currentSubPage += multiPageCollectionView.currentVerticalPage()
        
        handlePageButtons(page)

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
