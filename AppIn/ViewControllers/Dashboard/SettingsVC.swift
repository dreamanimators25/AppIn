//
//  SettingsVC.swift
//  AppIn
//
//  Created by sameer khan on 21/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SettingsVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var over21Data : RegisterData? = nil
    @IBOutlet weak var settingTableView: UITableView!
    
    let arrAccount = ["ACCOUNT","Edit profile","Change password","My channels"]
    let arrMore = ["MORE","Allow +21 content","GDPR","Privacy policy","Delete account","Logout"]
    let arrIcon = ["editProfile","changePassword","myChannel"]
    
    let arrUrl = ["http://www.jokk.app/gdprsv","http://www.jokk.app/privacysv","http://www.jokk.app/agreementsv"]
    let arrTitle = ["GDPR","Privacy policy","User agreement"]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setStatusBarColor()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.callOver21WebService()
    }
    
    //MARK: Custom Methods
    fileprivate func logoutUser() {
        
        //if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            
            //appDelegate.navigateToLoginScreen()
        
            self.tabBarController?.tabBar.isHidden = true
            
            CustomUserDefault.removeUserId()
            CustomUserDefault.removeLoginData()
            CustomUserDefault.removeUserName()
            CustomUserDefault.removeUserPassword()
            CustomUserDefault.removeTokenTime()
            
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "IntroSplashVC") as! IntroSplashVC
            self.navigationController?.pushViewController(loginVC, animated: true)
            
        //}
    }
    
    //MARK: Web Service
    func callOver21WebService() {
        
        let userData = UserDefaults.getUserData()
        
        var params = [String : String]()
        params = ["user_id" : userData?.UserId ?? ""]
        
        print("params = \(params)")
        self.showSpinner(onView: self.view)
        
        Alamofire.request(kGetUserURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
                        
            self.removeSpinner()
            print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    //print(json)
                    
                    let responsModal = RegisterBaseClass.init(json: json)
                    
                    if responsModal.status == "success" {
                        
                        if let profileData = responsModal.data {
                            
                            self.over21Data = profileData
                            self.settingTableView.reloadData()
                        }
                                                    
                    }else{
                        Alert.showAlert(strTitle: "", strMessage: responsModal.msg ?? "", Onview: self)
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
    
    //MARK: IBAction
    @IBAction func allow21ContentBtnClicked(_ sender: UIButton) {
        
        let userData = UserDefaults.getUserData()
        var params = [String : Any]()
        
        var over = 0
        if sender.isSelected {
            over = 0
        }else {
            over = 1
        }
        
        params = ["over21" :  over,
                  "user_id" : userData?.UserId ?? ""]
        
        print("params = \(params)")
        self.showSpinner(onView: self.view)
        
        Alamofire.request(kUpdateOver21, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
                        
            self.removeSpinner()
            print(responseData)
            
            switch responseData.result {
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    print(json)
                    
                    let responsModal = RegisterBaseClass.init(json: json)
                    
                    if responsModal.status == "success" {
                                                    
                        self.over21Data?.over21 = String(over)
                        self.settingTableView.reloadData()
                                                    
                    }else{
                        Alert.showAlert(strTitle: "", strMessage: responsModal.msg ?? "", Onview: self)
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
    
    //MARK: UITableView DataSource & Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return arrAccount.count
        }else {
            return arrMore.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                let settingHeaderCell = tableView.dequeueReusableCell(withIdentifier: "settingHeaderCell", for: indexPath)
                let rowLbl : UILabel = settingHeaderCell.viewWithTag(10) as! UILabel
                rowLbl.text = self.arrAccount[indexPath.row]
                
                return settingHeaderCell
            }else {
                let settingAcCell = tableView.dequeueReusableCell(withIdentifier: "settingAcCell", for: indexPath)
                let iconImgView: UIImageView = settingAcCell.viewWithTag(10) as! UIImageView
                iconImgView.image = UIImage.init(named: self.arrIcon[indexPath.row - 1])
                let titleLbl : UILabel = settingAcCell.viewWithTag(20) as! UILabel
                titleLbl.text = self.arrAccount[indexPath.row]
                
                return settingAcCell
            }
            
        }else {
            
            switch indexPath.row {
                case 0:
                    let settingHeaderCell = tableView.dequeueReusableCell(withIdentifier: "settingHeaderCell", for: indexPath)
                    let rowLbl : UILabel = settingHeaderCell.viewWithTag(10) as! UILabel
                    rowLbl.text = self.arrMore[indexPath.row]
                    
                    return settingHeaderCell
                case 1:
                    let settingSwitchCell = tableView.dequeueReusableCell(withIdentifier: "settingSwitchCell", for: indexPath)
                    let rowLbl : UILabel = settingSwitchCell.viewWithTag(10) as! UILabel
                    let switchBtn : UIButton = settingSwitchCell.viewWithTag(20) as! UIButton
                    rowLbl.text = self.arrMore[indexPath.row]
                    
                    if self.over21Data?.over21 == "1" {
                        switchBtn.isSelected = true
                    }else{
                        switchBtn.isSelected = false
                    }
                    
                    return settingSwitchCell
                case 2,3:
                    let settingMoreCell = tableView.dequeueReusableCell(withIdentifier: "settingMoreCell", for: indexPath)
                    let rowLbl : UILabel = settingMoreCell.viewWithTag(10) as! UILabel
                    rowLbl.text = self.arrMore[indexPath.row]
                    let irrowImgView: UIImageView = settingMoreCell.viewWithTag(20) as! UIImageView
                    irrowImgView.isHidden = false
                    
                    return settingMoreCell
                default:
                    let settingMoreCell = tableView.dequeueReusableCell(withIdentifier: "settingMoreCell", for: indexPath)
                    let rowLbl : UILabel = settingMoreCell.viewWithTag(10) as! UILabel
                    rowLbl.text = self.arrMore[indexPath.row]
                    let irrowImgView: UIImageView = settingMoreCell.viewWithTag(20) as! UIImageView
                    irrowImgView.isHidden = true
                    
                    return settingMoreCell
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0 {
            
            switch indexPath.row {
            case 1:
                let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "EditProfileVC") as! EditProfileVC
                vc.isOver21 = self.over21Data?.over21 ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
                
                break
            case 2:
                let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "ChangePasswordVC") as! ChangePasswordVC
                self.navigationController?.pushViewController(vc, animated: true)
                
                break
            case 3:
                let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "MyChannelsVC") as! MyChannelsVC
                self.navigationController?.pushViewController(vc, animated: true)
                
                break
            default:
                
                break
            }
            
        }else {
            
            switch indexPath.row {
                
            case 2,3:
                let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "WebViewVC") as! WebViewVC
                vc.isComeFrom = self.arrTitle[indexPath.row - 2]
                vc.loadableUrlStr = self.arrUrl[indexPath.row - 2]
                self.navigationController?.pushViewController(vc, animated: true)
                
                break
                
            case 4:
                DispatchQueue.main.async {
                    
                    DispatchQueue.main.async {
                        let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "DeleteAcPopUpVC") as! DeleteAcPopUpVC
                        
                        vc.modalPresentationStyle = .overCurrentContext
                        //vc.modalTransitionStyle = .crossDissolve
                        
                        vc.strTitle = "Delete account"
                        //vc.strContent = "Opting out will delete your profile and make all data generated in the system anonymized in agreement with the appin privacy policy and user agreement."
                        //vc.btnTitle = "Yes, delete my account"
                        vc.strContent = "ARE YOU REALLY SURE"
                        vc.btnTitle = "Yes"
                        
                        vc.yesDelete = {
                            
                            DispatchQueue.main.async {
                                let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "DeleteAcFinalPopUpVC") as! DeleteAcFinalPopUpVC
                                
                                vc.modalPresentationStyle = .overCurrentContext
                                //vc.modalTransitionStyle = .crossDissolve
                                
                                vc.strTitleFinal = "Delete account"
                                //vc.strContent = "Opting out will delete your profile and make all data generated in the system anonymized in agreement with the appin privacy policy and user agreement."
                                //vc.btnTitle = "Yes, delete my account"
                                vc.strContentFinal = "ONE LAST TIME ARE YOU REALLY SURE"
                                vc.btnTitleFinal = "Yes, delete my account"
                                
                                self.present(vc, animated: true) {
                                    
                                }
                            }
                            
                        }
                        
                        self.present(vc, animated: true) {
                            
                        }
                    }
                    
                }
                
                break
            case 5:
                
                Alert.showAlertWithTowButton("", message: "Do you want to logout?", alertButtonTitles: ["NO","YES"], alertButtonStyles: [.destructive,.default], vc: self) { (index) in
                    if index == 1 {
                        
                        DispatchQueue.main.async {
                            self.logoutUser()
                        }
                    }
                }
                
                break
            default:
                
                break
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
