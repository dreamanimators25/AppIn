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
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    @IBOutlet weak var checkBoxBtn: UIButton!
    
    @IBOutlet weak var txtFieldFirstName: UITextField!
    @IBOutlet weak var txtFieldLastName: UITextField!
    @IBOutlet weak var txtFieldCompanyName: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldPasswordAgain: UITextField!
    
    @IBOutlet weak var mainViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.SetCornerRadius()
        
        DispatchQueue.main.async {
            self.mainViewHeightConstraint.constant = 305
            self.secondViewHeightConstraint.constant = 0
            
            self.txtFieldEmail.isUserInteractionEnabled = false
            self.txtFieldPassword.isUserInteractionEnabled = false
            self.txtFieldPasswordAgain.isUserInteractionEnabled = false
        }
        
    }
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        
        if nextBtn.titleLabel?.text == "Next" {
            _ = self.navigationController?.popViewController(animated: true)
        }else {
            DispatchQueue.main.async {
                self.mainViewHeightConstraint.constant = 305
                self.firstViewHeightConstraint.constant = 225
                self.secondViewHeightConstraint.constant = 0
                self.nextBtn.setTitle("Next", for: .normal)
                
                self.txtFieldFirstName.isUserInteractionEnabled = true
                self.txtFieldLastName.isUserInteractionEnabled = true
                self.txtFieldCompanyName.isUserInteractionEnabled = true
                self.txtFieldEmail.isUserInteractionEnabled = false
                self.txtFieldPassword.isUserInteractionEnabled = false
                self.txtFieldPasswordAgain.isUserInteractionEnabled = false
            }
        }
        
    }

    //MARK: IBAction
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Next" {
            
            guard self.firstValidation() else {
                return
            }
            
            DispatchQueue.main.async {
                self.mainViewHeightConstraint.constant = 505
                self.firstViewHeightConstraint.constant = 0
                self.secondViewHeightConstraint.constant = 425
                sender.setTitle("DONE", for: .normal)
                
                self.txtFieldEmail.becomeFirstResponder()
                
                self.txtFieldFirstName.isUserInteractionEnabled = false
                self.txtFieldLastName.isUserInteractionEnabled = false
                self.txtFieldCompanyName.isUserInteractionEnabled = false
                self.txtFieldEmail.isUserInteractionEnabled = true
                self.txtFieldPassword.isUserInteractionEnabled = true
                self.txtFieldPasswordAgain.isUserInteractionEnabled = true
            }
        }else {
            
            guard self.secondValidation() else {
                return
            }
                        
            var params = [String : String]()
            params = ["first_name" : self.txtFieldFirstName.text!,
                      "last_name" : self.txtFieldLastName.text!,
                      "company_name" : self.txtFieldCompanyName.text!,
                      "email" : self.txtFieldEmail.text!,
                      "password" : self.txtFieldPassword.text!,
                      "gender" : "unspecified"]
            
            print("parass = \(params)")
            
            UserManager.sharedInstance.registerWithUsername(params) { [weak self] (user, error, exist) in
                
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
    
    @IBAction func checkBoxBtnClicked(_ sender: UIButton) {
        
        if sender.isSelected {
            self.checkBoxBtn.isSelected = !self.checkBoxBtn.isSelected
            self.checkBoxBtn.setImage(#imageLiteral(resourceName: "checkBox_unselect"), for: .normal)
        }else {
            self.checkBoxBtn.isSelected = !self.checkBoxBtn.isSelected
            self.checkBoxBtn.setImage(#imageLiteral(resourceName: "checkBox_select"), for: .normal)
        }
        
    }
    
    //MARK: Custom Methods
    func SetCornerRadius() {
        self.backBtn.layer.cornerRadius = btnCornerRadius
        self.nextBtn.layer.cornerRadius = btnCornerRadius
    }
    
    func firstValidation() -> Bool {
        
        if txtFieldFirstName.text!.isEmpty {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter First Name", Onview: self)
            return false
        }
        else if txtFieldLastName.text!.isEmpty {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter Last Name", Onview: self)
            return false
        }
        else if txtFieldCompanyName.text!.isEmpty {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter Company Name", Onview: self)
            return false
        }
        
        return true
    }
    
    func secondValidation() -> Bool {
        
        if txtFieldEmail.text!.isEmpty {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter E-mail Address", Onview: self)
            return false
        }
        else if(!Alert.isValidEmail(testStr: txtFieldEmail.text!)) {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter Valid E-mail Address", Onview: self)
            return false
        }
        else if txtFieldPassword.text!.isEmpty {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter Password", Onview: self)
            return false
        }
        else if txtFieldPasswordAgain.text!.isEmpty {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter Confirm Password", Onview: self)
            return false
        }
        else if txtFieldPassword.text != txtFieldPasswordAgain.text {
            Alert.showAlert(strTitle: "", strMessage: "Password Doesn't Match!", Onview: self)
            return false
        }else if !self.checkBoxBtn.isSelected {
            Alert.showAlert(strTitle: "", strMessage: "You Need To Agree With The License To Continue", Onview: self)
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
