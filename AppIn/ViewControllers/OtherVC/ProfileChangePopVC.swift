//
//  ProfileChangePopVC.swift
//  AppIn
//
//  Created by sameer khan on 29/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class ProfileChangePopVC: UIViewController {
    
    @IBOutlet weak var txtFNewItem: UITextField!
    @IBOutlet weak var lblTitle: UILabel!
    
    var setEnteredText : ((_ Value:String) -> (Void))?
    var isComeFor = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if isComeFor == "Email" {
            self.lblTitle.text = "Enter E-Mail"
            self.txtFNewItem.placeholder = "Please Enter E-Mail"
        }else {
            self.lblTitle.text = "Enter Name"
            self.txtFNewItem.placeholder = "Please Enter Name"
        }

    }
    
    //MARK: IBAction
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        
        if isComeFor == "Email" {
            
            if txtFNewItem.text!.isEmpty {
                Alert.showAlert(strTitle: "", strMessage: "Please Enter E-mail Address", Onview: self)
            }
            else if(!Alert.isValidEmail(testStr: txtFNewItem.text!)) {
                Alert.showAlert(strTitle: "", strMessage: "Please Enter Valid E-mail Address", Onview: self)
            }
            else {
                self.view.endEditing(true)
                
                self.dismiss(animated: true) {
                    (self.setEnteredText!(self.txtFNewItem.text ?? ""))
                }
            }
            
        }else {
            
            if txtFNewItem.text!.isEmpty {
                Alert.showAlert(strTitle: "", strMessage: "Please Enter Name", Onview: self)
            }else {
                self.view.endEditing(true)
                
                self.dismiss(animated: true) {
                    (self.setEnteredText!(self.txtFNewItem.text ?? ""))
                }
            }
            
        }
        
    }
    
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
