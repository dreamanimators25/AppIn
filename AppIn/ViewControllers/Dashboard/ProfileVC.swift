//
//  ProfileVC.swift
//  AppIn
//
//  Created by sameer khan on 21/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class ProfileVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var profileTableView: UITableView!
    
    let arrRows = ["CHANGE PASSWORD","DELETE ACCOUNT","LOG OUT"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: IBAction
    @IBAction func editBtnClicked(_ sender: UIButton) {
        let vc = DesignManager.loadViewControllerFromWebStoryBoard(identifier: "EditProfileVC") as! EditProfileVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: UITableView DataSource & Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row == 0 {
            
            let profileHeadCell = tableView.dequeueReusableCell(withIdentifier: "profileHeadCell", for: indexPath)
            
            return profileHeadCell
            
        }else {
            
            let profileMoreCell = tableView.dequeueReusableCell(withIdentifier: "profileMoreCell", for: indexPath)
            let rowLbl : UILabel = profileMoreCell.viewWithTag(10) as! UILabel
            rowLbl.text = self.arrRows[indexPath.row - 1]
            
            return profileMoreCell
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        guard indexPath.row != 2 else {
            return 0
        }
       
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch indexPath.row {
        case 0:
            print("Profile")
        case 1:
            let vc = DesignManager.loadViewControllerFromWebStoryBoard(identifier: "ChangePasswordVC") as! ChangePasswordVC
            self.navigationController?.pushViewController(vc, animated: true)
            
            break
        case 2:
            DispatchQueue.main.async {
                Alert.showAlertWithTowButton("", message: "Do you really want to opt out?", alertButtonTitles: ["NO","YES"], alertButtonStyles: [.default,.default], vc: self) { (index) in
                    if index == 1 {
                        
                        DispatchQueue.main.async {
                            Alert.showAlertWithTowButton("", message: "Opting out will delete your profile and make all data generated in the system anonymized in agreement with the appin privacy policy and user agreement.", alertButtonTitles: ["NO","YES"], alertButtonStyles: [.default,.default], vc: self) { (index) in
                                if index == 1 {
                                    print("Call Api")
                                }
                            }
                        }
                        
                    }
                }
            }
        default:
            Alert.showAlertWithTowButton("", message: "Do you want to logout?", alertButtonTitles: ["NO","YES"], alertButtonStyles: [.destructive,.default], vc: self) { (index) in
                if index == 1 {
                    
                    DispatchQueue.main.async {
                        self.logoutUser()
                    }
                }
            }
        }
        
    }
    
    //MARK: Custom Methods
    fileprivate func logoutUser() {
        UserManager.sharedInstance.logoutUserWithCompletion {
            
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                
                appDelegate.navigateToLoginScreen()
                OAuth2Handler.sharedInstance.clearAccessToken()
                
                CustomUserDefault.removeUserId()
                CustomUserDefault.removeLoginData()
                CustomUserDefault.removeUserName()
                CustomUserDefault.removeUserPassword()
                CustomUserDefault.removeTokenTime()
                
                print(OAuth2Handler.hasAccessToken)
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
