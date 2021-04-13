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

var TVDropDownIndex : ((_ section : Int, _ index : Int, _ sender : UIButton) -> (Void))?
var TVNotificationIndex : ((_ section : Int, _ sender : UIButton) -> (Void))?

class MyChannelsVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var myChannelTableView: UITableView!
    var isShowLoader = true
    
    var arrMyChannel: [AllBrandData]?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarColor()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.callMyChannelWebService()
        
        self.tabBarController?.tabBar.isHidden = true
                        
        TVDropDownIndex = { (section, ind, sender) in
            
            /*
            guard let cell = sender.superview?.superview as? MyChannelTVCell else {
                return
            }
            let indexPath = itemTable.indexPath(for: cell)
            */
            
            let buttonPosition = sender.convert(CGPoint.zero, to: self.myChannelTableView)
            let indexPath = self.myChannelTableView.indexPathForRow(at:buttonPosition)
            print(indexPath?.row ?? 0)
            
            switch ind {
            case 0:
                let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "InviteVC") as! InviteVC
                vc.strAccessCode = self.arrMyChannel?[section].channel?[indexPath?.row ?? 0].shortCode ?? ""
                vc.strQrCode = self.arrMyChannel?[section].channel?[indexPath?.row ?? 0].qrCode ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                
                break
            case 1:
                let vc = DesignManager.loadViewControllerFromContentStoryBoard(identifier: "AboutVC") as! AboutVC
                vc.isComeFrom = "Channel"
                vc.isID = self.arrMyChannel?[section].channel?[indexPath?.row ?? 0].internalIdentifier ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                
                break
            case 2:
                self.callRemoveChannelWebService(channelId: Int(self.arrMyChannel?[section].channel?[indexPath?.row ?? 0].internalIdentifier ?? "-1") ?? -1)
                
                break
            default:
                self.callShareContentWebService()
                
                //self.arrMyChannel?[0].channel?[tagInd].internalIdentifier ?? ""
                //self.arrMyChannel?[0].channel?[tagInd]
                
                break
            }
        }
        
        TVNotificationIndex = { (section, sender) in
            
            let buttonPosition = sender.convert(CGPoint.zero, to: self.myChannelTableView)
            let indexPath = self.myChannelTableView.indexPathForRow(at:buttonPosition)
            print(indexPath?.row ?? 0)
            
            var senderStatus = ""
            if sender.isSelected {
                senderStatus = "0"
            }else {
                senderStatus = "1"
            }
            
            self.callUpdateChannelNotificationWebService(channelId: Int(self.arrMyChannel?[section].channel?[indexPath?.row ?? 0].internalIdentifier ?? "-1") ?? -1, isPush: senderStatus)
            
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
        
        if let url = URL.init(string: channelData?.logo ?? "") {
            MyChannelTVCell.channelImgView.af_setImage(withURL: url)
        }
        
        if channelData?.sendPush == "1" {
            MyChannelTVCell.notificationBtn.isSelected = true
        }else {
            MyChannelTVCell.notificationBtn.isSelected = false
        }
        
        MyChannelTVCell.channelNameLbl.text = channelData?.name
        MyChannelTVCell.moreBtn.tag = indexPath.section
        MyChannelTVCell.notificationBtn.tag = indexPath.section
        
        
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
        
        //print("params = \(params)")
        if isShowLoader {
            self.isShowLoader = true
            self.showSpinner(onView: self.view)
        }
        
        Alamofire.request(kGetMyChannelsURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
            
            self.removeSpinner()
            
            //print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    
                    let responsModal = AllBrandBaseClass.init(json: json)
                    
                    if responsModal.status == "success" {
                                                    
                        self.arrMyChannel = responsModal.data
                        self.myChannelTableView.reloadData()
                        
                    }else{
                        Alert.showAlert(strTitle: "Error", strMessage: "", Onview: self)
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
    
    func callUpdateChannelNotificationWebService(channelId : Int, isPush : String) {
        
        let userData = UserDefaults.getUserData()
        
        var params = [String : Any]()
        
        params = ["user_id" : userData?.UserId ?? "",
                  "channel_id" : channelId,
                  "sendPush" : isPush]
        
        //print("params = \(params)")
        
        self.showSpinner(onView: self.view)
        
        Alamofire.request(kUpdateChannelNotificationURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
            
            self.removeSpinner()
            //print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    
                    let responsModal = GetAllNotifications.init(json: json)
                    
                    if responsModal.status == "success" {
                                     
                    }else{
                        Alert.showAlert(strTitle: "Error", strMessage: "", Onview: self)
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
    
    func callRemoveChannelWebService(channelId : Int) {
        
        let userData = UserDefaults.getUserData()
        
        var params = [String : Any]()
        params = ["user_id" : userData?.UserId ?? "",
                  "channel_id" : channelId,
                  "isDeleted" : "1"]
        
        //print("params = \(params)")
        
        self.showSpinner(onView: self.view)
        
        Alamofire.request(kRemoveChannelURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
                     
            //DispatchQueue.main.async {
                //self.removeSpinner()
            //}
                        
            //print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    
                    let responsModal = RegisterBaseClass.init(json: json)
                    
                    if responsModal.status == "success" {
                        self.isShowLoader = false
                        self.callMyChannelWebService()
                    }else{
                        Alert.showAlert(strTitle: "", strMessage: responsModal.msg ?? "Error", Onview: self)
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
    
    func callShareContentWebService() {
        
        let userData = UserDefaults.getUserData()
                
        var params = [String : String]()
        params = ["user_id" : userData?.UserId ?? ""]
        
        /*
        params = ["contentId" : self.content?.channelId ?? 0,
                  "user_id" : userData?.UserId ?? "",
                  "pageId" : self.content?.pageId ?? ""]
        */
        
        //print("params = \(params)")
        self.showSpinner(onView: self.view)
        
        Alamofire.request(kShareContentURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
            
            self.removeSpinner()
            //print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    print(json)
                    
                }
                
            case .failure(let error):
                
                if error.localizedDescription.contains("Internet connection appears to be offline"){
                    //Alert.showAlert(strTitle: "Error!!", strMessage: "Internet connection appears to be offline", Onview: self)
                }else{
                    //Alert.showAlert(strTitle: "Error!!", strMessage: "something went wrong", Onview: self)
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
