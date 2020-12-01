//
//  ProfileVC.swift
//  AppIn
//
//  Created by sameer khan on 21/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import HCVimeoVideoExtractor
import AVFoundation
import AVKit

var CVDropDownIndex : ((_ ind : Int) -> (Void))?
var CVgoThereIndex : ((_ ind : Int) -> (Void))?

class FeedVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var contentCollectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        CVDropDownIndex = { index in
            switch index {
            case 0:
                let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "InviteVC") as! InviteVC
                self.navigationController?.pushViewController(vc, animated: true)
                                
                break
            case 1:
                let vc = DesignManager.loadViewControllerFromContentStoryBoard(identifier: "InformationVC") as! InformationVC
                self.navigationController?.pushViewController(vc, animated: true)
                
                break
            default:
                let vc = DesignManager.loadViewControllerFromContentStoryBoard(identifier: "AboutSasVC") as! AboutSasVC
                self.navigationController?.pushViewController(vc, animated: true)
                
                break
            }
        }
        
        
        CVgoThereIndex = { index in
            
            switch index {
            case 0:
                self.showVimeoPlayer("https://player.vimeo.com/281116099")
                                
                break
            case 1:
                let vc = DesignManager.loadViewControllerFromContentStoryBoard(identifier: "InformationVC") as! InformationVC
                self.navigationController?.pushViewController(vc, animated: true)
                
                break
            default:
                DispatchQueue.main.async {
                    guard let number = URL(string: "tel://\(9982689220)") else { return }
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(number, options: [:], completionHandler: { (status) in })
                    } else {
                        UIApplication.shared.openURL(number)
                    }
                }
                
                break
            }
            
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: UICollectionView DataSource & Delegates
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let multiPageCell = collectionView.dequeueReusableCell(withReuseIdentifier: "MultiPageCell", for: indexPath) as! MultiPageCell
        
        return multiPageCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        if let cell = cell as? MultiPageCell {
            cell.content = 3
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
                
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.contentCollectionView.frame.size.width, height: self.contentCollectionView.frame.size.height)
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    func showVimeoPlayer(_ link: String) {
        
        let linkUrl = URL.init(string: link)
        
        HCVimeoVideoExtractor.fetchVideoURLFrom(url: linkUrl!, completion: { ( video:HCVimeoVideo?, error:Error?) -> Void in
            
            if let err = error {
                print("Error = \(err.localizedDescription)")
                return
            }
            
            guard let vid = video else {
                print("Invalid video object")
                return
            }
                        
            var vidUrl : HCVimeoVideoQuality!
            for item in vid.videoURL {
                vidUrl = item.key
            }
                        
            if let videoURL = vid.videoURL[vidUrl] {
                
                let player = AVPlayer(url: videoURL)
                let playerController = AVPlayerViewController()
                playerController.player = player
                self.present(playerController, animated: true) {
                    player.play()
                }
                
            }
        })
    }

}


