//
//  SettingsVC.swift
//  AppIn
//
//  Created by sameer khan on 21/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var settingTableView: UITableView!
    
    let arrAccount = ["ACCOUNT","Edit profile","Change password","My channels"]
    let arrMore = ["MORE","Allow +21 content","GDPR","Privacy policy","Delete account","Logout"]
    let arrIcon = ["editProfile","changePassword","myChannel"]
    
    let arrUrl = ["http://www.jokk.app/gdprsv","http://www.jokk.app/privacysv","http://www.jokk.app/agreementsv"]
    let arrTitle = ["GDPR","Privacy policy","User agreement"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: Custom Methods
    fileprivate func logoutUser() {
        
        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
            
            appDelegate.navigateToLoginScreen()
            
            CustomUserDefault.removeUserId()
            CustomUserDefault.removeLoginData()
            CustomUserDefault.removeUserName()
            CustomUserDefault.removeUserPassword()
            CustomUserDefault.removeTokenTime()
            
        }
    }
    
    //MARK: IBAction
    @IBAction func allow21ContentBtnClicked(_ sender: UIButton) {
        
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
                    rowLbl.text = self.arrMore[indexPath.row]
                    
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
                        vc.strContent = "Opting out will delete your profile and make all data generated in the system anonymized in agreement with the appin privacy policy and user agreement."
                        vc.btnTitle = "Yes, delete my account"
                        
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
