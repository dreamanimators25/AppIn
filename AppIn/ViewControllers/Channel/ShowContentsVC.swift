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
    
    var strTitle : String?

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
        
        // image to share
        let image = #imageLiteral(resourceName: "logo_white")
        
        // set up activity view controller
        let imageToShare = [ image ]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view // so that iPads won't crash
        
        // exclude some activity types from the list (optional)
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook, UIActivity.ActivityType.postToVimeo, UIActivity.ActivityType.mail, UIActivity.ActivityType.postToTwitter ]
        
        // present the view controller
        self.present(activityViewController, animated: true, completion: nil)
        
    }
    
    //MARK: UICollectionView DataSource & Delegates
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let multiPageCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MultiPageCVCell", for: indexPath) as! MultiPageCVCell
    
        indexPath.row % 2 == 1 ? (multiPageCVCell.multiPageCollectionView.backgroundColor = #colorLiteral(red: 0.1581287384, green: 0.6885935664, blue: 0.237049073, alpha: 1)) : (multiPageCVCell.multiPageCollectionView.backgroundColor = #colorLiteral(red: 0.2392156869, green: 0.6745098233, blue: 0.9686274529, alpha: 1))
        
        indexPath.row % 2 == 1 ? (multiPageCVCell.content = 3) : (multiPageCVCell.content = 5)
        
        return multiPageCVCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentCollectionView.frame.size.width, height: self.contentCollectionView.frame.size.height)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
