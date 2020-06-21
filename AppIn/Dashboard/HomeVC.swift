//
//  HomeVC.swift
//  AppIn
//
//  Created by sameer khan on 21/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class HomeVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var latestContentCollectionView: UICollectionView!
    @IBOutlet weak var myChannelCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: IBAction
    @IBAction func searchBtnClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func addBtnClicked(_ sender: UIButton) {
        
    }
    
    //MARK: UICollectionView DataSource & Delegates
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.latestContentCollectionView {
            return 10
        }else {
            return 20
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.latestContentCollectionView {
            let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "contentCell", for: indexPath) as! LatestContentCVCell
            
            return contentCell
        }else {
            let channelCell = collectionView.dequeueReusableCell(withReuseIdentifier: "channelCell", for: indexPath) as! MyChannelCVCell
            
            return channelCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print(indexPath.row)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.latestContentCollectionView {
            return CGSize.init(width: 100.0, height: 100.0)
        }else {
            return CGSize(width: self.myChannelCollectionView.frame.size.width/3 - 10, height: self.myChannelCollectionView.frame.size.width/2.2 - 10)
        }
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
