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
    
    var content : Int? {
        didSet {
            
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
        return content ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let singlePageCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "SinglePageCVCell", for: indexPath) as! SinglePageCVCell
        
        let img : UIImageView = singlePageCVCell.viewWithTag(10) as! UIImageView
        img.backgroundColor = #colorLiteral(red: 0.5568627715, green: 0.3529411852, blue: 0.9686274529, alpha: 1)

        return singlePageCVCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.multiPageCollectionView.frame.size.width, height: self.multiPageCollectionView.frame.size.height)
    }
    
    
}
