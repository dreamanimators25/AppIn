//
//  AboutSasVC.swift
//  AppIn
//
//  Created by sameer khan on 31/10/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class AboutSasVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var aboutCollectionView: UICollectionView!
    @IBOutlet weak var aboutPageControl: UIPageControl!
    
    var isComeFrom : String = ""
    var isID : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarColor()

        if let id = self.isID {
            self.callGetChannelInfoWebService(id: id)
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
    
    //MARK: UICollectionView DataSource & Delegates
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let aboutCVCell = collectionView.dequeueReusableCell(withReuseIdentifier: "aboutCVCell", for: indexPath)
        
        return aboutCVCell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        self.aboutPageControl.currentPage = indexPath.item
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplaying cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
       
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.aboutCollectionView.bounds.width, height: self.aboutCollectionView.bounds.height)
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
    
    func callGetChannelInfoWebService(id : String) {
        
        var params = [String : String]()
        params = ["id" : id]
        
        print("params = \(params)")
        
        var strUrl = ""
        if isComeFrom == "Channel" {
            strUrl = kGetChannelInfoURL
        }else {
            strUrl = kGetBrandInfoURL
        }
        
        Alamofire.request(strUrl, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
                        
            //print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    print(json)
                    
                    let responsModal = AboutBaseData.init(json: json)

                    if responsModal.status == "success" {
                        
                        

                    }else{
                        Alert.showAlert(strTitle: "", strMessage: "Error", Onview: self)
                    }
                    
                }
                
            case .failure(let error):
                
                if error.localizedDescription.contains("Internet connection appears to be offline"){
                    Alert.showAlert(strTitle: "Error!!", strMessage: "Internet connection appears to be offline", Onview: self)
                }else{
                    Alert.showAlert(strTitle: "Error!!", strMessage: "something went wrong", Onview: self)
                }
            }
            
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
