//
//  MyChannelsVC.swift
//  AppIn
//
//  Created by sameer khan on 24/10/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

var TVDropDownIndex : ((_ ind : Int) -> (Void))?
var TVNotificationIndex : ((_ ind : Int) -> (Void))?

class MyChannelsVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var myChannelTableView: UITableView!
    
    //var arrSec1 = ["SAS","Development","McDonalds"]
    //var arrSec2 = ["Uber","Development"]
    //var arrSec3 = ["Air bnb","Marketing"]

    var arrMyChannel: [AllBrandData]?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.callMyChannelWebService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
                        
        TVDropDownIndex = { index in
            switch index {
            case 0:
                let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "InviteVC") as! InviteVC
                self.navigationController?.pushViewController(vc, animated: true)
                
                break
            case 1:
                let vc = DesignManager.loadViewControllerFromContentStoryBoard(identifier: "AboutSasVC") as! AboutSasVC
                self.navigationController?.pushViewController(vc, animated: true)
                
                break
            case 2:
                self.callRemoveChannelWebService()
                
                break
            default:
                self.callShareContentWebService()
                
                break
            }
        }
        
        TVNotificationIndex = { index in
            self.callUpdateChannelNotificationWebService(channelId: index)
        }
        
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
        return self.arrMyChannel?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (self.arrMyChannel?[section].channel?.count ?? 0)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let MyChannelTVCell = tableView.dequeueReusableCell(withIdentifier: "MyChannelTVCell", for: indexPath) as! MyChannelTVCell
        
        let brandData = self.arrMyChannel?[indexPath.section]
        let channel = brandData?.channel
        let channelData = channel?[indexPath.row]
        
        MyChannelTVCell.channelNameLbl.text = channelData?.name
        
        return MyChannelTVCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //MARK: Web Service
    func callMyChannelWebService() {
        
        let userData = UserDefaults.getUserData()
        
        var params = [String : String]()
        params = ["user_id" : userData?.UserId ?? ""]
        
        print("params = \(params)")
        
        Alamofire.request(kGetMyChannelsURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
                        
            print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    print(json)
                    
                    let responsModal = AllBrandBaseClass.init(json: json)
                    
                    if responsModal.status == "success" {
                                                    
                        self.arrMyChannel = responsModal.data
                        self.myChannelTableView.reloadData()
                        
                    }else{
                        //Alert.showAlert(strTitle: "", strMessage: responsModal.msg ?? "", Onview: self)
                    }
                    
                }
                
            case .failure(let error):
                
                if error.localizedDescription.contains("Internet connection appears to be offline"){
                    Alert.showAlert(strTitle: "Error!!", strMessage: "Internet connection appears to be offline", Onview: self)
                }else{
                    Alert.showAlert(strTitle: "Error!!", strMessage: "Somthing went wrong", Onview: self)
                }
            }
            
        }
        
    }
    
    func callUpdateChannelNotificationWebService(channelId : Int) {
        
        let userData = UserDefaults.getUserData()
        
        var params = [String : Any]()
        
        params = ["user_id" : userData?.UserId ?? "",
                  "channel_id" : channelId,
                  "sendPush" : "1"]
        
        print("params = \(params)")
        
        Alamofire.request(kUpdateChannelNotificationURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
                        
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    print(json)
                    
                    let responsModal = GetAllNotifications.init(json: json)
                    
                    if responsModal.status == "success" {
                                     
                    }else{
                        Alert.showAlert(strTitle: "", strMessage: "", Onview: self)
                    }
                    
                }
                
            case .failure(let error):
                
                if error.localizedDescription.contains("Internet connection appears to be offline"){
                    Alert.showAlert(strTitle: "Error!!", strMessage: "Internet connection appears to be offline", Onview: self)
                }else{
                    Alert.showAlert(strTitle: "Error!!", strMessage: "Somthing went wrong", Onview: self)
                }
            }
            
        }
        
    }
    
    func callRemoveChannelWebService() {
        
        let userData = UserDefaults.getUserData()
        
        var params = [String : String]()
        params = ["user_id" : userData?.UserId ?? "",
                  "channel_id" : "",
                  "isDeleted" : ""]
        
        print("params = \(params)")
        
        Alamofire.request(kRemoveChannelURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
                        
            print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    print(json)
                    
                    let responsModal = RegisterBaseClass.init(json: json)
                    
                    if responsModal.status == "success" {
                                                    
                    }else{
                        Alert.showAlert(strTitle: "", strMessage: responsModal.msg ?? "", Onview: self)
                    }
                    
                }
                
            case .failure(let error):
                
                if error.localizedDescription.contains("Internet connection appears to be offline"){
                    Alert.showAlert(strTitle: "Error!!", strMessage: "Internet connection appears to be offline", Onview: self)
                }else{
                    Alert.showAlert(strTitle: "Error!!", strMessage: "Somthing went wrong", Onview: self)
                }
            }
            
        }
        
    }
    
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
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
