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
                self.multiPageCollectionView.register(UINib(nibName: "ContentEmbedCVCell", bundle: nil), forCellWithReuseIdentifier: "ContentEmbedCVCell")

                if multiPageCollectionView.dataSource == nil {
                    multiPageCollectionView.delegate = self
                    multiPageCollectionView.dataSource = self
                }
                
                multiPageCollectionView.reloadData()
                
                self.handlePageButtons(0)
            }
            
        }
    }
        
    //MARK: UICollectionView DataSource & Delegates
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content?.pages.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let page = self.content?.pages[indexPath.row]
        let comp = page?.components
        
        
        let component0 = comp?.first
        let meta0 = component0?.meta
        //print(meta0?.text ?? "no first")
        
        let component1 = comp?[1]
        let meta1 = component1?.meta
        //print(meta1?.text ?? "no last")
        
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
            
            if let backGround = page?.backgrounds {
                textCVCell.background = backGround
            }
            
            if let strSticker = content?.pages[indexPath.row].frameUrl {
                textCVCell.stickerURL = strSticker
            }
            
            //HEADER TEXT
            textCVCell.headerTextLbl?.text = meta0?.text ?? ""
            textCVCell.headerTextLbl?.font = meta0?.font
            textCVCell.headerTextLbl?.textColor = meta0?.color
            textCVCell.headerTextLbl?.textAlignment = meta0?.textAlignment ?? NSTextAlignment.center
                        
            if let alpa = meta0?.background_opacity, alpa != 0.0, meta0?.bgColor != .clear {
                textCVCell.headerTextLbl?.backgroundColor = meta0?.bgColor.withAlphaComponent(alpa)
            }else {
                textCVCell.headerTextLbl?.backgroundColor = meta0?.bgColor
            }
            
            //CONTENT TEXT
            textCVCell.contentTextLbl?.text = meta1?.text ?? ""
            textCVCell.contentTextLbl?.font = meta1?.font
            textCVCell.contentTextLbl?.textColor = meta1?.color
            textCVCell.contentTextLbl?.textAlignment = meta1?.textAlignment ?? NSTextAlignment.center
            
            if let alpa = meta1?.background_opacity, alpa != 0.0, meta1?.bgColor != .clear {
                textCVCell.contentTextLbl?.backgroundColor = meta1?.bgColor.withAlphaComponent(alpa)
            }else {
                textCVCell.contentTextLbl?.backgroundColor = meta1?.bgColor
            }
            
            return textCVCell
        case .Video:
            let videoCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentVideoCVCell", for: indexPath) as! ContentVideoCVCell
            videoCVCell.backgroundColor = .purple
            
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
                print("youtube")
                
                let embedCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentEmbedCVCell", for: indexPath) as! ContentEmbedCVCell
                embedCVCell.backgroundColor = .yellow
                
                return embedCVCell
                
            }else if component1?.embedType == "vimeo" {
                print("vimeo")
                
                let embedCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentEmbedCVCell", for: indexPath) as! ContentEmbedCVCell
                embedCVCell.backgroundColor = .red
                
                return embedCVCell
            }
            
        case .none:
            print("image")
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
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
                //cell.pauseMedia()
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
