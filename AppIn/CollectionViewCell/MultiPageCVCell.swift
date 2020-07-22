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
        
    var content:Content? {
        didSet {
            
            if (content != nil) {
                
                self.multiPageCollectionView.register(UINib(nibName: "ContentTextCVCell", bundle: nil), forCellWithReuseIdentifier: "ContentTextCVCell")

                
                self.multiPageCollectionView.register(ContentImageCVCell.self, forCellWithReuseIdentifier: "ContentImageCVCell")
                self.multiPageCollectionView.register(ContentTextCVCell.self, forCellWithReuseIdentifier: "ContentTextCVCell")
                self.multiPageCollectionView.register(ContentVideoCVCell.self, forCellWithReuseIdentifier: "ContentVideoCVCell")
                self.multiPageCollectionView.register(ContentSoundCVCell.self, forCellWithReuseIdentifier: "ContentSoundCVCell")
                self.multiPageCollectionView.register(ContentEmbedCVCell.self, forCellWithReuseIdentifier: "ContentEmbedCVCell")
                                
                if multiPageCollectionView.dataSource == nil {
                    multiPageCollectionView.delegate = self
                    multiPageCollectionView.dataSource = self
                }
                
                multiPageCollectionView.reloadData()
            }
            print("Initial current subpage says: \(multiPageCollectionView.currentVerticalPage())")
        }
    }
    
    var content1 : Int? {
        didSet {
            
            self.multiPageCollectionView.register(ContentImageCVCell.self, forCellWithReuseIdentifier: "ContentImageCVCell")
            self.multiPageCollectionView.register(ContentTextCVCell.self, forCellWithReuseIdentifier: "ContentTextCVCell")
            self.multiPageCollectionView.register(ContentVideoCVCell.self, forCellWithReuseIdentifier: "ContentVideoCVCell")
            self.multiPageCollectionView.register(ContentSoundCVCell.self, forCellWithReuseIdentifier: "ContentSoundCVCell")
            self.multiPageCollectionView.register(ContentEmbedCVCell.self, forCellWithReuseIdentifier: "ContentEmbedCVCell")
            
            if multiPageCollectionView.dataSource == nil {
                multiPageCollectionView.delegate = self
                multiPageCollectionView.dataSource = self
            }
            
            multiPageCollectionView.reloadData()
        }
    }
        
        
    //MARK: UICollectionView DataSource & Delegates
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return content?.pages.count ?? 0
    }
    
    func filterComponent(_ components : [ContentPageComponent]?) -> String {
        
        guard let components = components else {
            return ""
        }
        
        for i in 0..<2 {
            //let component = components[i]
            let component = components.last
            
            switch component?.type {
            case .Image:
                print("embed = createImage(component)")
                return "image"
            case .Text:
                print("embed = createText(component, cIndex: i)")
                return "text"
            case .Video:
                print("embed = createVideo(component)")
                return "video"
            case .Sound:
                print("embed = createSound(component)")
                return "sound"
            case .Embed:
                
                if component?.embedType == "youtube" {
                    print("embed = createEmbed(component)")
                    return "youtube"
                }else if component?.embedType == "vimeo" {
                    print("embed = self.createEmbedVimeo(component)")
                    return "vimeo"
                }
                
            case .none:
                return ""
            }
        }
        
        return ""
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let page = self.content?.pages[indexPath.row]
        let comp = page?.components
        
        //let tp = self.filterComponent(comp)
        //print(tp)
        
        //for i in 0..<2 {
        //let component = t?[i]
        
        let component0 = comp?.first
        let meta0 = component0?.meta
        print(meta0?.text ?? "no first")
            
        let component1 = comp?[1]
        let meta1 = component1?.meta
        print(meta1?.text ?? "no last")
        
            switch component1?.type {
                
            case .Image:
                let imageCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentImageCVCell", for: indexPath) as! ContentImageCVCell
                imageCVCell.backgroundColor = .black
                
                return imageCVCell

            case .Text:
                let textCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentTextCVCell", for: indexPath) as! ContentTextCVCell
                textCVCell.backgroundColor = .brown
                
                textCVCell.headerTextView?.text = meta0?.text ?? ""
                textCVCell.contentTextView?.text = meta1?.text ?? ""
                
                return textCVCell
            case .Video:
                let videoCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentVideoCVCell", for: indexPath) as! ContentVideoCVCell
                videoCVCell.backgroundColor = .purple
                
                return videoCVCell
            case .Sound:
                let soundCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentSoundCVCell", for: indexPath) as! ContentSoundCVCell
                soundCVCell.backgroundColor = .gray
                
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
                    embedCVCell.backgroundColor = .yellow
                    
                    return embedCVCell
                }
                
            case .none:
                print("image")
            }
        //}
        
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
    
}
