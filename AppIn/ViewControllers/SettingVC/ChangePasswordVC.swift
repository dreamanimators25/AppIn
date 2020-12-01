//
//  ChangePasswordVC.swift
//  AppIn
//
//  Created by sameer khan on 23/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ChangePasswordVC: UIViewController {
    
    @IBOutlet weak var txtFCurrentPassword: UITextField!
    @IBOutlet weak var txtFNewPassword: UITextField!
    @IBOutlet weak var txtFRepeatPassword: UITextField!
    
    @IBOutlet weak var lblCurrentPwError: UILabel!
    @IBOutlet weak var lblNewPwError: UILabel!
    @IBOutlet weak var lblRepeatPwError: UILabel!
    @IBOutlet weak var currentPwView: UIView!
    @IBOutlet weak var newPwView: UIView!
    @IBOutlet weak var repeatPwView: UIView!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(ChangePasswordVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    // MARK: Keyboard Notification methods
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            
            self.lblCurrentPwError.isHidden = true
            self.lblNewPwError.isHidden = true
            self.lblRepeatPwError.isHidden = true
           
            self.currentPwView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.newPwView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.repeatPwView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
    }
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        if txtFCurrentPassword.text!.isEmpty {
            //Alert.showAlert(strTitle: "", strMessage: "Please Enter Old Password", Onview: self)
            
            self.currentPwView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblCurrentPwError.text = "Please Enter Current Password"
            self.lblCurrentPwError.isHidden = false
        }else if txtFNewPassword.text!.isEmpty {
            //Alert.showAlert(strTitle: "", strMessage: "Please Enter New Password", Onview: self)
            
            self.newPwView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblNewPwError.text = "Please Enter New Password"
            self.lblNewPwError.isHidden = false
        }
        else if txtFRepeatPassword.text!.isEmpty {
            //Alert.showAlert(strTitle: "", strMessage: "Please Enter Confirm Password", Onview: self)
            
            self.repeatPwView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblRepeatPwError.text = "Please Enter Confirm Password"
            self.lblRepeatPwError.isHidden = false
        }
        else if txtFNewPassword.text != txtFRepeatPassword.text {
            //Alert.showAlert(strTitle: "", strMessage: "Password Doesn't Match!", Onview: self)
            
            self.repeatPwView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblRepeatPwError.text = "Password Doesn't Match!"
            self.lblRepeatPwError.isHidden = false
        }
        else {
            
            var params = [String : String]()
            params = ["user_id" : self.txtFNewPassword.text!,
                      "oldPassword" : self.txtFNewPassword.text!,
                      "newPassword1" : self.txtFNewPassword.text!,
                      "newPassword2" : self.txtFNewPassword.text!
                      ]
            
            print("params = \(params)")
            
            Alamofire.request(kChangePasswordURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
                            
                self.txtFCurrentPassword.text = ""
                self.txtFNewPassword.text = ""
                self.txtFRepeatPassword.text = ""
                
                switch responseData.result {
                case .success:
                    if let data = responseData.result.value {
                        let json = JSON(data)
                        print(json)
                                
                        let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "BottomViewVC") as! BottomViewVC
                        vc.img = #imageLiteral(resourceName: "successTick")
                        vc.lbl = "Success message"
                        vc.btn = ""
                        vc.modalPresentationStyle = .overCurrentContext
                        //vc.modalTransitionStyle = .crossDissolve
                        self.present(vc, animated: true, completion: nil)
                        
                    }
                case .failure(let error):
                    
                    if error.localizedDescription.contains("Internet connection appears to be offline"){
                        Alert.showAlert(strTitle: "Error!!", strMessage: "Internet connection appears to be offline", Onview: self)
                    }else{
                        let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "BottomViewVC") as! BottomViewVC
                        vc.img = #imageLiteral(resourceName: "errorInfo")
                        vc.lbl = "Error"
                        vc.btn = ""
                        vc.modalPresentationStyle = .overCurrentContext
                        //vc.modalTransitionStyle = .crossDissolve
                        self.present(vc, animated: true, completion: nil)
                    }
                }
                
            }
            
            /*
            UserManager.sharedInstance.changePsw(txtFCurrentPassword.text!, txtFNewPassword.text!, onSuccess: {
                
                self.txtFCurrentPassword.text = ""
                self.txtFNewPassword.text = ""
                self.txtFRepeatPassword.text = ""
                
                //Alert.showAlert(strTitle: "", strMessage: "Password has been successfully changed", Onview: self)
                
                let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "BottomViewVC") as! BottomViewVC
                vc.img = #imageLiteral(resourceName: "successTick")
                vc.lbl = "Success message"
                vc.btn = ""
                
                vc.modalPresentationStyle = .overCurrentContext
                //vc.modalTransitionStyle = .crossDissolve
                
                self.present(vc, animated: true, completion: nil)
                
            }, onError: {
                //Alert.showAlert(strTitle: "Error", strMessage: "Wrong old password", Onview: self)
                
                let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "BottomViewVC") as! BottomViewVC
                vc.img = #imageLiteral(resourceName: "errorInfo")
                vc.lbl = "Error"
                vc.btn = ""
                
                vc.modalPresentationStyle = .overCurrentContext
                //vc.modalTransitionStyle = .crossDissolve
                
                self.present(vc, animated: true, completion: nil)
            })
            */
            
        }
        
    }
    
    //MARK: Custom Methods


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
