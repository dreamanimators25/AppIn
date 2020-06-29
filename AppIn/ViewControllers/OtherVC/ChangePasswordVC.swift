//
//  ChangePasswordVC.swift
//  AppIn
//
//  Created by sameer khan on 23/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class ChangePasswordVC: UIViewController {
    
    @IBOutlet weak var txtFOldPassword: UITextField!
    @IBOutlet weak var txtFNewPassword: UITextField!
    @IBOutlet weak var txtFConfirmPassword: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

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
    
    @IBAction func submitBtnClicked(_ sender: UIButton) {
        
        if txtFOldPassword.text!.isEmpty {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter Old Password", Onview: self)
        }else if txtFNewPassword.text!.isEmpty {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter New Password", Onview: self)
        }
        else if txtFConfirmPassword.text!.isEmpty {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter Confirm Password", Onview: self)
        }
        else if txtFNewPassword.text != txtFConfirmPassword.text {
            Alert.showAlert(strTitle: "", strMessage: "Password Doesn't Match!", Onview: self)
        }
        else {
            print("Call Change Password Api")
        }
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
