//
//  CreateAccountVC.swift
//  AppIn
//
//  Created by sameer khan on 14/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import FirebaseInstanceID

class CreateAccountVC: UIViewController {
    
    @IBOutlet weak var checkBoxBtn: UIButton!
    
    @IBOutlet weak var lblNameError: UILabel!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblVerifyEmailError: UILabel!
    
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldVerifyEmail: UITextField!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var verifyEmailView: UIView!
    @IBOutlet weak var overlay: UIView!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(CreateAccountVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // MARK: Keyboard Notification methods
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            
            self.lblNameError.isHidden = true
            self.lblEmailError.isHidden = true
            self.lblVerifyEmailError.isHidden = true
            
            self.nameView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.emailView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.verifyEmailView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            
        }
    }

    //MARK: IBAction
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        let vc = DesignManager.loadViewControllerFromMainStoryBoard(identifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tncBtnClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func checkBoxBtnClicked(_ sender: UIButton) {
        
        if sender.isSelected {
            self.checkBoxBtn.isSelected = !self.checkBoxBtn.isSelected
            self.checkBoxBtn.setImage(#imageLiteral(resourceName: "checkBox_unselect"), for: .normal)
        }else {
            self.checkBoxBtn.isSelected = !self.checkBoxBtn.isSelected
            self.checkBoxBtn.setImage(#imageLiteral(resourceName: "checkBox_select"), for: .normal)
        }
    }
    
    @IBAction func registerBtnClicked(_ sender: UIButton) {
        
        guard self.Validation() else {
            return
        }
        
        self.overlay.isHidden = false
                
        var params = [String : String]()
        params = ["first_name" : self.txtFieldName.text!,
                  //"last_name" : self.txtFieldLastName.text!,
                  //"company_name" : self.txtFieldCompanyName.text!,
                  "email" : self.txtFieldEmail.text!,
                  //"password" : self.txtFieldPassword.text!,
                  "gender" : "unspecified"]
        
        print("params = \(params)")
        
        UserManager.sharedInstance.registerWithUsername(params) { [weak self] (user, error, exist) in
            
            self?.overlay.isHidden = true
            
            guard let self = self else { return }
            
            if error != nil {
                self.showErr(str: "Server error")
            } else if exist {
                self.showErr(str: "Email address already in use")
            } else {
                if user == nil {
                    self.showErr(str: "Server error")
                } else {
                    AppDelegate.userId = user?.id
                    
                    self.updatePushToken()
                    
                    DispatchQueue.main.async(execute: {
                        if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                            appDelegate.navigateToDashboardScreen()
                        }
                    })
                    
                }
            }
            
        }
        
    }
    
    @IBAction func userAgreementBtnClicked(_ sender: UIButton) {
        let vc = DesignManager.loadViewControllerFromWebStoryBoard(identifier: "WebViewVC") as! WebViewVC
        vc.isComeFrom = "APPIN - User Agreement"
        vc.loadableUrlStr = "http://www.jokk.app/agreementsv"
        //vc.loadableUrlStr = "http://haldidhana.com/chinabasin.html"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func privacyPolicyBtnClicked(_ sender: UIButton) {
        let vc = DesignManager.loadViewControllerFromWebStoryBoard(identifier: "WebViewVC") as! WebViewVC
        vc.isComeFrom = "APPIN - Privacy Policy"
        vc.loadableUrlStr = "http://www.jokk.app/privacysv"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func GDPRAgreementBtnClicked(_ sender: UIButton) {
        let vc = DesignManager.loadViewControllerFromWebStoryBoard(identifier: "WebViewVC") as! WebViewVC
        vc.isComeFrom = "APPIN - GDPR"
        vc.loadableUrlStr = "http://www.jokk.app/gdprsv"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Custom Methods
    func Validation() -> Bool {
        
        self.view.endEditing(true)
        
        if txtFieldName.text!.isEmpty {
            //Alert.showAlert(strTitle: "", strMessage: "Please Enter Name", Onview: self)
            
            self.nameView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblNameError.text = "Please Enter Name"
            self.lblNameError.isHidden = false
            return false
        }
        else if txtFieldEmail.text!.isEmpty {
            //Alert.showAlert(strTitle: "", strMessage: "Please Enter E-mail Address", Onview: self)
            
            self.emailView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblEmailError.text = "Please Enter E-mail Address"
            self.lblEmailError.isHidden = false
            return false
        }
        else if(!Alert.isValidEmail(testStr: txtFieldEmail.text!)) {
            //Alert.showAlert(strTitle: "", strMessage: "Please Enter Valid E-mail Address", Onview: self)
            
            self.emailView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblEmailError.text = "Please Enter Valid E-mail Address"
            self.lblEmailError.isHidden = false
            return false
        }
        else if txtFieldVerifyEmail.text!.isEmpty {
            //Alert.showAlert(strTitle: "", strMessage: "Please Verify E-mail Address", Onview: self)
            
            self.verifyEmailView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblVerifyEmailError.text = "Please Verify E-mail Address"
            self.lblVerifyEmailError.isHidden = false
            return false
        }
        else if txtFieldEmail.text != txtFieldVerifyEmail.text {
            //Alert.showAlert(strTitle: "", strMessage: "E-mail Address Doesn't Match!", Onview: self)
            
            self.verifyEmailView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblVerifyEmailError.text = "E-mail Address Doesn't Match!"
            self.lblVerifyEmailError.isHidden = false
            return false
        }else if !self.checkBoxBtn.isSelected {
            Alert.showAlert(strTitle: "", strMessage: "You Need To Agree With The Terms & Conditions", Onview: self)
            
            //self.lblNameError.text = "You Need To Agree With The Terms & Conditions"
            //self.lblNameError.isHidden = false
            return false
        }
        
        return true
    }
    
    //MARK: - Updating Push Notification Token -
    
    fileprivate func updatePushToken() {
        InstanceID.instanceID().instanceID(handler: { (result, error) in
            
            AppDelegate.token = result?.token
            
            if let id = UserManager.sharedInstance.user?.id, let token = AppDelegate.token {
                let router = UserRouter(endpoint: .updatePushToken(token: token, userId: "\(id)"))
                UserManager.sharedInstance.performRequest(withRouter: router) { (data) in
                    print("👍", String(describing: type(of: self)),":", #function, " ", data)
                }
            }
        })
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
