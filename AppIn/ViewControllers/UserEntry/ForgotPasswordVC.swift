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

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnClicked(_ sender: UIButton) {
        
        if txtFEmail.text!.isEmpty {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter E-mail Address", Onview: self)
        }
        else if(!Alert.isValidEmail(testStr: txtFEmail.text!)) {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter Valid E-mail Address", Onview: self)
        }
        else {
            print("Call Forgot Password Api")
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
