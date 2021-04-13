//
//  LoginVC.swift
//  AppIn
//
//  Created by sameer khan on 14/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import FirebaseInstanceID
import Alamofire
import SwiftyJSON

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
            
            let currentDate = Date()
            // 1) Create a DateFormatter() object.
            let format = DateFormatter()
            // 2) Set the current timezone to .current, or America/Chicago.
            format.timeZone = .current
            // 3) Set the format of the altered date.
            format.dateFormat = "yyyy-mm-dd"
            // 4) Set the current date, altered by timezone.
            let dateString = format.string(from: currentDate)
            
            //let locale = NSLocale.current.languageCode
            let lang = Locale.preferredLanguages[0]
            
            var countryName = ""
            if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
                print(countryCode)
                countryName = countryCode
            }
                    
            var params = [String : Any]()
            
            params = ["email" : self.txtFEmail.text!,
                      "password" : self.txtFPassword.text!,
                      "country" : countryName,
                      "deviceMeta" : UIDevice.modelName,
                      "os" : UIDevice.current.systemVersion,
                      "deviceID" : UIDevice.current.identifierForVendor!.uuidString,
                      "timezone" : dateString,
                      "language" : lang
                      ]
            
            print("params = \(params)")
            //self.showSpinner(onView: self.view)
            
            Alamofire.request(kLoginURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
                
                //self.removeSpinner()
                
                print(responseData)
                self.overlay.isHidden = true
                
                switch responseData.result {
                case .success:
                    
                    if let data = responseData.result.value {
                        let json = JSON(data)
                        print(json)
                        
                        let responsModal = RegisterBaseClass.init(json: json)
                        
                        if responsModal.status == "success" {
                            UserDefaults.saveUserData(modal: responsModal.data!)
                            
                            DispatchQueue.main.async(execute: {
                                //if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                                    //appDelegate.navigateToDashboardScreen()
                                    
                                    let mainStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                                    let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                                    self.navigationController?.pushViewController(loginVC, animated: true)
                                    
                                //}
                            })
                            
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
    }
    
    @IBAction func forgotBtnClicked(_ sender: UIButton) {
        let vc = DesignManager.loadViewControllerFromMainStoryBoard(identifier: "ForgotPasswordVC") as! ForgotPasswordVC
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
    
    func Validation() -> Bool {
        
        self.view.endEditing(true)
        
        if txtFEmail.text!.isEmpty {
            
            DispatchQueue.main.async {
                self.emailView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
                self.lblEmailError.text = "Please Enter E-mail Address"
                self.lblEmailError.isHidden = false
            }
            
            return false
        }
        else if(!Alert.isValidEmail(testStr: txtFEmail.text!)) {

            DispatchQueue.main.async {
                self.emailView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
                self.lblEmailError.text = "Please Enter Valid E-mail Address"
                self.lblEmailError.isHidden = false
            }
            
            return false
        }
        else if txtFPassword.text!.isEmpty {
           
            DispatchQueue.main.async {
                self.passwordView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
                self.lblPasswordError.text = "Please Enter Password"
                self.lblPasswordError.isHidden = false
            }
            
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
