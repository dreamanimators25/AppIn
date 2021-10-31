//
//  VerifyEmailVC.swift
//  AppIn
//
//  Created by Sameer Khan on 29/04/21.
//  Copyright © 2021 Sameer khan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import OTPFieldView

class VerifyEmailVC: UIViewController, UITextFieldDelegate {
    
    @IBOutlet var otpTextFieldView: OTPFieldView!
    @IBOutlet var lblTimer: UILabel!
    
    var enteredOTP = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setStatusBarColor()
        self.setOtpView()
    }
    
    //MARK: Custom Methods
    func setOtpView() {
        
        self.otpTextFieldView.fieldsCount = 6
        self.otpTextFieldView.fieldBorderWidth = 2
        self.otpTextFieldView.defaultBorderColor = .black
        self.otpTextFieldView.filledBorderColor = AppThemeColor
        self.otpTextFieldView.cursorColor = AppThemeColor
        self.otpTextFieldView.displayType = .underlinedBottom
        self.otpTextFieldView.fieldSize = 40
        self.otpTextFieldView.separatorSpace = 8
        self.otpTextFieldView.shouldAllowIntermediateEditing = true
        self.otpTextFieldView.delegate = self
        self.otpTextFieldView.initializeUI()
        
    }
    
    func Validation() -> Bool {
        
        if self.enteredOTP == "" {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter Valid 6 Digit OTP", Onview: self)
            
            return false
        }
        else if self.enteredOTP.count < 6 {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter Valid 6 Digit OTP", Onview: self)
            
            return false
        }
        else {
            return true
        }
        
    }
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnClicked(_ sender: UIButton) {
        
        guard self.Validation() else {
            return
        }
        
        self.view.endEditing(true)
        
        let userData = UserDefaults.getUserData()
        
        var params = [String : String]()
        params = ["user_id" : userData?.UserId ?? "",
                  "email_otp" : self.enteredOTP]
        
        print("params = \(params)")
        self.showSpinner(onView: self.view)
        
        Alamofire.request(kVerifyEmail, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
            
            self.removeSpinner()
            print(responseData)
            
            switch responseData.result {
            
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    print(json)
                    
                    let responsModal = RegisterBaseClass.init(json: json)
                    
                    if responsModal.status == "success" {
                        
                        let mainStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                        let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                        self.navigationController?.pushViewController(loginVC, animated: true)
                    }
                    else {
                        
                        let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "BottomViewVC") as! BottomViewVC
                        vc.img = #imageLiteral(resourceName: "errorClose")
                        vc.lbl = responsModal.msg ?? ""
                        vc.btn = ""
                        vc.modalPresentationStyle = .overCurrentContext
                        self.present(vc, animated: true, completion: nil)
                        
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
    
    @IBAction func resendBtnClicked(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        let userData = UserDefaults.getUserData()
        
        var params = [String : String]()
        params = ["user_id" : userData?.UserId ?? ""]
        
        print("params = \(params)")
        self.showSpinner(onView: self.view)
        
        Alamofire.request(kResendEmail, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
            
            self.removeSpinner()
            print(responseData)
            
            switch responseData.result {
            
            case .success:
                
                if let data = responseData.result.value {
                    
                    let json = JSON(data)
                    print(json)
                    
                    let responsModal = RegisterBaseClass.init(json: json)
                    
                    if responsModal.status == "success" {
                        
                        let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "BottomViewVC") as! BottomViewVC
                        vc.img = #imageLiteral(resourceName: "successTick")
                        vc.lbl = responsModal.msg ?? ""
                        vc.btn = ""
                        vc.modalPresentationStyle = .overCurrentContext
                        self.present(vc, animated: true, completion: nil)
                    }
                    else {
                        
                        let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "BottomViewVC") as! BottomViewVC
                        vc.img = #imageLiteral(resourceName: "errorClose")
                        vc.lbl = responsModal.msg ?? ""
                        vc.btn = ""
                        vc.modalPresentationStyle = .overCurrentContext
                        self.present(vc, animated: true, completion: nil)
                        
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

extension VerifyEmailVC : OTPFieldViewDelegate {
    
    func hasEnteredAllOTP(hasEnteredAll: Bool) -> Bool {
        if hasEnteredAll {
            
            return true
        }else {
            
            self.enteredOTP = ""
            return false
            
        }
        
    }
    
    func shouldBecomeFirstResponderForOTP(otpTextFieldIndex index: Int) -> Bool {
        return true
    }
    
    func enteredOTP(otp: String) {
        self.enteredOTP = otp
    }
    
}
