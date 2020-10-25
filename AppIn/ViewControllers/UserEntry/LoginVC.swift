//
//  LoginVC.swift
//  AppIn
//
//  Created by sameer khan on 14/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import FirebaseInstanceID

class LoginVC: UIViewController {
    
    @IBOutlet weak var txtFEmail: UITextField!
    @IBOutlet weak var txtFPassword: UITextField!
    
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblPasswordError: UILabel!
    
    @IBOutlet weak var overlay: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setStatusBarColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // MARK: Keyboard Notification methods
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            self.lblEmailError.isHidden = true
            self.lblPasswordError.isHidden = true
            
            self.emailView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.passwordView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
    }
    
    //MARK: IBAction
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        if Validation() {
            
            self.overlay.isHidden = false
            
            UserManager.sharedInstance.authenticateWithUsername(self.txtFEmail.text!, password: self.txtFPassword.text!) { (user, error, text) in
                
                self.overlay.isHidden = true
                
                if text != nil {
                    self.showErr(str: text!)
                } else if error != nil {
                    self.showErr(str: "Server error")
                } else {
                    AppDelegate.userId = user?.id
                    
                    CustomUserDefault.saveUserData(modal: user ?? User())
                    CustomUserDefault.saveUserName(name: self.txtFEmail.text!)
                    CustomUserDefault.saveUserPassword(password: self.txtFPassword.text!)

                    self.handleSuccessfullyAuthenticatedWithUser()
                }
                
            }
            
        }
    }
    
    @IBAction func forgotBtnClicked(_ sender: UIButton) {
        let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "ForgotPasswordVC") as! ForgotPasswordVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func signUpBtnClicked(_ sender: UIButton) {
        let vc = DesignManager.loadViewControllerFromMainStoryBoard(identifier: "CreateAccountVC") as! CreateAccountVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Custom Methods
    func handleSuccessfullyAuthenticatedWithUser() {
        print("The login was successful, so navigating to the application.")
        
        self.updatePushToken()
        
        DispatchQueue.main.async(execute: {
            if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                appDelegate.navigateToDashboardScreen()
            }
        })
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
        
    func setStatusBarColor() {
        
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = AppThemeColor
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
          
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = AppThemeColor
        }
    }
    
    func Validation() -> Bool {
        
        self.view.endEditing(true)
        
        if txtFEmail.text!.isEmpty {
            //Alert.showAlert(strTitle: "", strMessage: "Please Enter E-mail Address", Onview: self)
            
            self.emailView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblEmailError.text = "Please Enter E-mail Address"
            self.lblEmailError.isHidden = false
            return false
        }
        else if(!Alert.isValidEmail(testStr: txtFEmail.text!)) {
            //Alert.showAlert(strTitle: "", strMessage: "Please Enter Valid E-mail Address", Onview: self)
            
            self.emailView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblEmailError.text = "Please Enter Valid E-mail Address"
            self.lblEmailError.isHidden = false
            return false
        }
        else if txtFPassword.text!.isEmpty {
            //Alert.showAlert(strTitle: "", strMessage: "Please Enter Password", Onview: self)
            
            self.passwordView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblPasswordError.text = "Please Enter Password"
            self.lblPasswordError.isHidden = false
            return false
        }
        
        return true
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
