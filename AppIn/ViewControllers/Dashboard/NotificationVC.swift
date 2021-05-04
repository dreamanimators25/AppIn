//
//  NotificationVC.swift
//  AppIn
//
//  Created by sameer khan on 18/10/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class NotificationVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var notificationTableView: UITableView!
    @IBOutlet weak var ErrorView: UIView!
    var isShowLoader = true
    
    //let arrNotification = ["New information was added - Regulation 2020","New channel was added - Environment","New PDF was added - Human Resource 2020","HR channel was updated"]
    var arrNotification : [GetAllNotificationData]? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarColor()

        //self.callNotificationWebService()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.callNotificationWebService()
        
        if let tabItems = tabBarController?.tabBar.items {
            // In this case we want to modify the badge number of the third tab:
            let tabItem = tabItems[2]
            tabItem.badgeValue = nil
        }
        
    }
    
    //MARK: UITableView DataSource & Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrNotification?.count == 0 {
            self.ErrorView.isHidden = false
            self.notificationTableView.isHidden = true
        }else {
            self.ErrorView.isHidden = true
            self.notificationTableView.isHidden = false
        }
        
        return arrNotification?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let notificationCell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath)
        
        let readDotLbl : UILabel = notificationCell.viewWithTag(5) as! UILabel
        let notiImgView : UIImageView = notificationCell.viewWithTag(10) as! UIImageView
        let titelLbl : UILabel = notificationCell.viewWithTag(20) as! UILabel
        let subTitelLbl : UILabel = notificationCell.viewWithTag(30) as! UILabel
        
        let data = arrNotification?[indexPath.row]
        
        //titelLbl.text = data?.title
        /*
        if let data = data?.title?.data(using: String.Encoding.isoLatin1) {
            if let fixed = NSString(data: data, encoding: String.Encoding.utf8.rawValue) {
                print(fixed) // Stavsnäs
                titelLbl.text = fixed as String
            }
        }
        */
        
        let str = data?.title?.decodingHTMLEntities()
        titelLbl.text = str
                
        
        //subTitelLbl.text = data?.type
        let dt = self.getDateFromString(data?.addedDate ?? "")
        subTitelLbl.text = (data?.channelName ?? "") + "  " + dt.getElapsedInterval()
        
        if let url = URL.init(string: data?.icon ?? "") {
            notiImgView.af_setImage(withURL: url)
        }
        
        if data?.isRead == "1" {
            readDotLbl.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        }else {
            readDotLbl.backgroundColor = #colorLiteral(red: 0.2, green: 0.2, blue: 0.6784313725, alpha: 1)
        }
        
        /*
        if indexPath.row % 2 == 0 {
            notiImgView.image = #imageLiteral(resourceName: "uber")
        }else {
            notiImgView.image = #imageLiteral(resourceName: "headSas")
        }
        */
        
        return notificationCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let selNotiID = self.arrNotification?[indexPath.row].internalIdentifier else
        {
            return
        }
        
        self.callUpdateNotificationWebService(notiID: selNotiID)
        
        if let loadNoti = loadNotification {
            
            AppDelegate.sharedDelegate().selNotiChannelID = Int("\(self.arrNotification?[indexPath.row].channelId ?? "")") ?? 0
            AppDelegate.sharedDelegate().selNotiPageID = Int("\(self.arrNotification?[indexPath.row].value ?? "")") ?? 0
        
            if let tabBarController = self.navigationController?.tabBarController {
                tabBarController.selectedIndex = 1
            }
            
            loadNoti()
            
        }else {
            
            AppDelegate.sharedDelegate().selNotiChannelID = Int("\(self.arrNotification?[indexPath.row].channelId ?? "")") ?? 0
            AppDelegate.sharedDelegate().selNotiPageID = Int("\(self.arrNotification?[indexPath.row].value ?? "")") ?? 0
        
            if let tabBarController = self.navigationController?.tabBarController {
                tabBarController.selectedIndex = 1
            }
            
        }
        
    }
    
    //MARK: Web Service
    func callNotificationWebService() {
        
        let userData = UserDefaults.getUserData()
        
        var params = [String : String]()
        params = ["user_id" : userData?.UserId ?? ""]
        //params = ["user_id" : "16"]
        
        print("params = \(params)")
        if isShowLoader {
            self.isShowLoader = true
            self.showSpinner(onView: self.view)
        }else {
            self.isShowLoader = true
        }
        
        
        Alamofire.request(kGetAllNotificationURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
            
            self.removeSpinner()
            print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    print(json)
                    
                    let responsModal = GetAllNotifications.init(json: json)
                    
                    if responsModal.status == "success" {
                                                
                        self.arrNotification = responsModal.data
                        self.notificationTableView.reloadData()
                        
                        self.ErrorView.isHidden = true
                        self.notificationTableView.isHidden = false
                                                    
                    }else{
                        //Alert.showAlert(strTitle: "", strMessage: "", Onview: self)
                        
                        self.ErrorView.isHidden = false
                        self.notificationTableView.isHidden = true
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
    
    func callUpdateNotificationWebService(notiID : String) {
        
        let userData = UserDefaults.getUserData()
        
        var params = [String : String]()
        
        params = ["user_id" : userData?.UserId ?? "",
                  "isRead" : "1",
                  "notification_id" : notiID,
                  "isDeleted" : "0"]
        
        print("params = \(params)")
        //self.showSpinner(onView: self.view)
        
        Alamofire.request(kUpdateNotificationURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
            
            //self.removeSpinner()
            print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    print(json)
                    
                    let responsModal = RegisterBaseClass.init(json: json)
                    
                    DispatchQueue.main.async {
                        if responsModal.status == "success" {
                            
                            self.isShowLoader = false
                            self.callNotificationWebService()
                                                        
                            /*
                            let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "BottomViewVC") as! BottomViewVC
                            vc.img = #imageLiteral(resourceName: "successTick")
                            vc.lbl = responsModal.msg ?? "Success"
                            vc.btn = ""
                            vc.modalPresentationStyle = .overCurrentContext
                            //vc.modalTransitionStyle = .crossDissolve
                            self.present(vc, animated: true, completion: nil)
                            */
                            
                        }else{
                            
                            /*
                            let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "BottomViewVC") as! BottomViewVC
                            vc.img = #imageLiteral(resourceName: "errorClose")
                            vc.lbl = responsModal.msg ?? "Error"
                            vc.btn = ""
                            vc.modalPresentationStyle = .overCurrentContext
                            //vc.modalTransitionStyle = .crossDissolve
                            self.present(vc, animated: true, completion: nil)
                            */
                            
                        }
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
    
    func getDateFromString(_ str : String) -> Date {
    
        // 1) Create a DateFormatter() object.
        let format = DateFormatter()
        // 2) Set the current timezone to .current, or America/Chicago.
        //format.timeZone = .current
        // 3) Set the format of the altered date.
        format.dateFormat = "yyyy-MM-dd HH:mm:ss"
        // 4) Set the current date, altered by timezone.
        let date = format.date(from: str) ?? Date()
        
        return date
    }

}
