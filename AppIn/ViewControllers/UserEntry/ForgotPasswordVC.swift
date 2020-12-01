//
//  ForgotPasswordVC.swift
//  AppIn
//
//  Created by sameer khan on 23/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ForgotPasswordVC: UIViewController {
    
    @IBOutlet weak var txtFEmail: UITextField!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var emailView: UIView!

    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    // MARK: Keyboard Notification methods
    @objc func keyboardWillShow(notification: NSNotification) {
        if ((notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue) != nil {
            self.lblEmailError.isHidden = true
            
            self.emailView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
        }
    }
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func submitBtnClicked(_ sender: UIButton) {
        
        self.view.endEditing(true)
        
        if Validation() {
        
            var params = [String : String]()
            params = ["username" : self.txtFEmail.text!
                      ]
            
            print("params = \(params)")
            
            Alamofire.request(kForgetPasswordURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: nil).responseJSON { (responseData) in
                            
                switch responseData.result {
                case .success:
                    if let data = responseData.result.value {
                        let json = JSON(data)
                        print(json)
                                
                        self.txtFEmail.text = ""
                    }
                case .failure(let error):
                    
                    if error.localizedDescription.contains("Internet connection appears to be offline"){
                        Alert.showAlert(strTitle: "Error!!", strMessage: "Internet connection appears to be offline", Onview: self)
                    }else{
                        Alert.showAlert(strTitle: "Error!!", strMessage: "Somthing went wrong", Onview: self)
                    }
                }
                
            }
            
        }
     
    }
    
    //MARK: Custom Methods
    func Validation() -> Bool {
        
        self.view.endEditing(true)
        
        if txtFEmail.text!.isEmpty {
            self.emailView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblEmailError.text = "Please Enter E-mail Address"
            self.lblEmailError.isHidden = false
            return false
        }
        else if(!Alert.isValidEmail(testStr: txtFEmail.text!)) {
            self.emailView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
            self.lblEmailError.text = "Please Enter Valid E-mail Address"
            self.lblEmailError.isHidden = false
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
