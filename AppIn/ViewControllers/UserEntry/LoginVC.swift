//
//  LoginVC.swift
//  AppIn
//
//  Created by sameer khan on 14/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var txtFEmail: UITextField!
    @IBOutlet weak var txtFPassword: UITextField!
    
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    @IBOutlet weak var createAccountBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.SetCornerRadius()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }
    
    //MARK: IBAction
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        if Validation() {
            print("Login Api Call")
            
            apdel.navigateToDashboardScreen()
        }
    }
    
    @IBAction func forgotBtnClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func createBtnClicked(_ sender: UIButton) {
        let vc = DesignManager.loadViewControllerFromMainStoryBoard(identifier: "CreateAccountVC") as! CreateAccountVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Custom Methods
    func SetCornerRadius() {
        self.logInBtn.layer.cornerRadius = btnCornerRadius
        self.forgotPasswordBtn.layer.cornerRadius = btnCornerRadius
        self.createAccountBtn.layer.cornerRadius = btnCornerRadius
    }
    
    func Validation() -> Bool
    {
        if txtFEmail.text!.isEmpty {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter E-mail Address", Onview: self)
            return false
        }
        else if(!Alert.isValidEmail(testStr: txtFEmail.text!)) {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter Valid E-mail Address", Onview: self)
            return false
        }
        else if txtFPassword.text!.isEmpty {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter Password", Onview: self)
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
