//
//  ForgotPasswordVC.swift
//  AppIn
//
//  Created by sameer khan on 23/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet weak var txtFEmail: UITextField!
    @IBOutlet weak var btnSubmit: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.SetCornerRadius()
    }
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnClicked(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        if txtFEmail.text!.isEmpty {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter E-mail Address", Onview: self)
        }
        else if(!Alert.isValidEmail(testStr: txtFEmail.text!)) {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter Valid E-mail Address", Onview: self)
        }
        else {
            
            UserManager.sharedInstance.restorePasswordWithEmail(self.txtFEmail.text!) { (res, error, info) in
                if error != nil {
                    self.showErr(str: "Server error")
                } else if let info = info {
                    self.showErr(str: info)
                } else {
                    self.showErr(str: "An email has been sent")
                    self.txtFEmail.text = ""
                }
            }
            
        }
        
    }
    
    //MARK: Custom Methods
    func SetCornerRadius() {
        self.btnSubmit.layer.cornerRadius = btnCornerRadius
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
