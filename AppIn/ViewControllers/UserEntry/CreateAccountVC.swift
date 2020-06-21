//
//  CreateAccountVC.swift
//  AppIn
//
//  Created by sameer khan on 14/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

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

        self.backBtn.layer.cornerRadius = btnCornerRadius
        self.nextBtn.layer.cornerRadius = btnCornerRadius
        
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
            
            print("SignUp Api Call")
            
            apdel.navigateToDashboardScreen()
            
        }
        
    }
    
    @IBAction func userAgreementBtnClicked(_ sender: UIButton) {
        let vc = DesignManager.loadViewControllerFromWebStoryBoard(identifier: "WebViewVC") as! WebViewVC
        vc.isComeFrom = "APPIN - User Agreement"
        vc.loadableUrlStr = "http://www.jokk.app/agreementsv"
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
    func firstValidation() -> Bool
    {
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
    
    func secondValidation() -> Bool
    {
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

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
