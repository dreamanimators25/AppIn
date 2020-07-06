//
//  ChannelVC.swift
//  AppIn
//
//  Created by sameer khan on 28/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class ContentVC: UIViewController, UITableViewDataSource, UITableViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var contentTableView: UITableView!
    @IBOutlet weak var lblChannelTitle: UILabel!
    
    var strTitle : String?

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
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: UITableView DataSource & Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let contentTVCell = tableView.dequeueReusableCell(withIdentifier: "ContentTVCell", for: indexPath) as! ContentTVCell
        
        contentTVCell.lblContentTitle.text = "Sameer"
                
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
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let contentCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "ContentCVCell", for: indexPath) as! ContentCVCell
        
        //contentCVCell.lblContentHeader.text = "Sameer"
        
        indexPath.row % 2 == 1 ? (contentCVCell.lblContentFooter.text = "Sameer") : (contentCVCell.lblContentFooter.text = "Sameer khan")
        
        indexPath.row % 2 == 1 ? (contentCVCell.contentImageView.backgroundColor = AppThemeColor) : (contentCVCell.contentImageView.backgroundColor = UIColor.green)
        
        return contentCVCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = DesignManager.loadViewControllerFromContentStoryBoard(identifier: "ShowContentsVC") as! ShowContentsVC
        vc.strTitle = "CAMERA"
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
