//
//  SinglePageCell.swift
//  AppIn
//
//  Created by sameer khan on 01/11/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AVFoundation
import DropDown
import SwiftyJSON

class SinglePageCell: UICollectionViewCell {
    
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var goThereBtn: UIButton!
    
    let cellDropDown = DropDown()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        cellDropDown.anchorView = self.moreBtn
        cellDropDown.dataSource = ["Invite to channel","Share","About"]
        cellDropDown.cellConfiguration = { (index, item) in return "\(item)" }
       
    }
    
    //MARK: IBActions on Cells
    @IBAction func moreBtnClicked(_ sender: UIButton) {
        cellDropDown.selectionAction = { (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            if let selectedIndex = CVDropDownIndex {
                selectedIndex(index)
            }
        }

        cellDropDown.width = 130
        cellDropDown.bottomOffset = CGPoint(x: 0, y:(cellDropDown.anchorView?.plainView.bounds.height)!)
        cellDropDown.show()
    }
    
    @IBAction func goThereBtnClicked(_ sender: UIButton) {
    
        if let selectedIndex = CVgoThereIndex {
            selectedIndex(sender.tag)
        }
    }
    
    @IBAction func shareBtnClicked(_ sender: UIButton) {
        self.callShareContentWebService()
    }
    
    //MARK: Web Service
    func callShareContentWebService() {
                
        var params = [String : String]()
        params = ["pageId" : "0"]
        
        print("params = \(params)")
        
        Alamofire.request(kShareContentURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
                        
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    print(json)
                    
                    let responsModal = RegisterBaseClass.init(json: json)
                    
                    if responsModal.status == "success" {
                                                    
                    }else{
                        //Alert.showAlert(strTitle: "", strMessage: responsModal.msg ?? "", Onview: self)
                    }
                    
                }
                
            case .failure(let error):
                
                if error.localizedDescription.contains("Internet connection appears to be offline"){
                    //Alert.showAlert(strTitle: "Error!!", strMessage: "Internet connection appears to be offline", Onview: self)
                }else{
                    //Alert.showAlert(strTitle: "Error!!", strMessage: "Somthing went wrong", Onview: self)
                }
            }
            
        }
        
    }
    
}
