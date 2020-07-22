//
//  HomeVC.swift
//  AppIn
//
//  Created by sameer khan on 21/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import Crashlytics

var enableTabBarItems : ((_ cod : String) -> (Void))?

class HomeVC: UIViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var latestContentCollectionView: UICollectionView!
    @IBOutlet weak var myChannelCollectionView: UICollectionView!
    
    fileprivate let user = UserManager.sharedInstance.user
    fileprivate var ambassadorships: [Ambassadorship] = []

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.getAmbassadorshipsForUser()
        
        enableTabBarItems = { code in
            if let items = self.tabBarController?.tabBar.items {
                items.forEach { $0.isEnabled = true }
                
                guard code != "" else {
                    return
                }
                self.addChannel(Code: code)
            }
        }
        
    }
    
    //MARK: Custom Methods
    private func getAmbassadorshipsForUser() {
        AmbassadorshipManager.sharedInstance.getAmbassadorshipsForUser(user!.id, page: 1, pageSize: 20) { [weak self] (ambassadorships, error) in
            
            guard let self = self else { return }
            
            if let ambassadorships = ambassadorships {
                
                self.ambassadorships = ambassadorships
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.myChannelCollectionView.reloadData()
                    self.latestContentCollectionView.reloadData()
                }
                
                guard !ambassadorships.isEmpty else { return }
    
                
            } else if let error = error {
                Crashlytics.sharedInstance().recordError(error)
            }
        }
    }
    
    private func addChannel(Code:String) {
        
        AmbassadorshipManager.sharedInstance.requestAmbassadorhipWithCode(Code) { (ambassadorship, error, code) in
            
            guard error == nil else {
                self.showAlertWithTitle(NSLocalizedString("Something went wrong.", comment: ""), message: nil, completion: {
                    
                })
                return
            }
            
            if let ambassadorship = ambassadorship {
                
                self.ambassadorships.append(ambassadorship)
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    self.myChannelCollectionView.reloadData()
                    self.latestContentCollectionView.reloadData()
                }
                      
            } else {
                self.showAlertWithTitle(NSLocalizedString("CONNECTION_CODE_DOES_NOT_EXISTS", comment: ""), message: nil, completion: {
                    
                })
            }
            
        }
    }
    
    //MARK: IBAction
    @IBAction func searchBtnClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func addBtnClicked(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            let vc = DesignManager.loadViewControllerFromWebStoryBoard(identifier: "AddChannelPopUpVC") as! AddChannelPopUpVC
            vc.modalPresentationStyle = .overCurrentContext
            vc.modalTransitionStyle = .crossDissolve
            
            self.present(vc, animated: true) {
                if let items = self.tabBarController?.tabBar.items {
                    items.forEach { $0.isEnabled = false }
                }
            }
            
        }
        
    }
    
    //MARK: UICollectionView DataSource & Delegates
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.latestContentCollectionView {
            return ambassadorships.count
        }else {
            return ambassadorships.count
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == self.latestContentCollectionView {
            let contentCell = collectionView.dequeueReusableCell(withReuseIdentifier: "contentCell", for: indexPath) as! LatestContentCVCell
            
            let item = ambassadorships[indexPath.row]
            
            if let url = URL(string: item.brand.logotypeUrl) {
                contentCell.contentImageView.af_setImage(withURL: url)
                contentCell.contentImageView.backgroundColor = Color.backgroundColorFadedDark()
            } else {
                contentCell.contentImageView.backgroundColor = Color.backgroundColorFadedDark()
            }
                        
            return contentCell
        }else {
            let channelCell = collectionView.dequeueReusableCell(withReuseIdentifier: "channelCell", for: indexPath) as! MyChannelCVCell
            
            let item = ambassadorships[indexPath.row]
            
            if let url = URL(string: item.brand.logotypeUrl) {
                channelCell.channelImageView.af_setImage(withURL: url)
                channelCell.channelImageView.backgroundColor = Color.backgroundColorFadedDark()
            } else {
                channelCell.channelImageView.backgroundColor = Color.backgroundColorFadedDark()
            }
            
            channelCell.channelNameLbl.text = item.brand.name
            
            return channelCell
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard collectionView == self.myChannelCollectionView else {
            return
        }
        
        let vc = DesignManager.loadViewControllerFromContentStoryBoard(identifier: "ContentVC") as! ContentVC
        let item = ambassadorships[indexPath.row]
        vc.strTitle = item.brand.name
        vc.ambassadorship = ambassadorships[indexPath.row]
        vc.user = user
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == self.latestContentCollectionView {
            return CGSize.init(width: 60.0, height: 60.0)
        }else {
            return CGSize(width: self.myChannelCollectionView.frame.size.width/3 - 10, height: self.myChannelCollectionView.frame.size.width/2.1 - 10)
        }
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
