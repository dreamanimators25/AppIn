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

class MultiPageCell: UICollectionViewCell, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
   @IBOutlet weak var multiPageCollectionView: UICollectionView!
                
    var content : Int = 0 {
        didSet {
            
            //self.multiPageCollectionView.register(UINib(nibName: "SinglePageCell", bundle: nil), forCellWithReuseIdentifier: "SinglePageCell")
            
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
        return content
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let SinglePageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SinglePageCell", for: indexPath) as! SinglePageCell
        
        return SinglePageCell
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
