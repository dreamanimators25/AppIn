//
//  CreateAccountVC.swift
//  AppIn
//
//  Created by sameer khan on 14/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import FirebaseInstanceID
import Alamofire
import SwiftyJSON
import DropDown

class CreateAccountVC: UIViewController {
    
    @IBOutlet weak var checkBoxBtn: UIButton!
    
    @IBOutlet weak var txtFieldName: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldConfirmPassword: UITextField!
    @IBOutlet weak var txtFieldAgeFeel: UITextField!
    
    @IBOutlet weak var txtFieldCountry: UITextField!
    @IBOutlet weak var txtFieldGender: UITextField!
    @IBOutlet weak var txtFieldProfileBio: UITextField!
    @IBOutlet weak var txtFieldBirthDate: UITextField!
    
    @IBOutlet weak var lblNameError: UILabel!
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblPasswordError: UILabel!
    @IBOutlet weak var lblConfirmPasswordError: UILabel!
    @IBOutlet weak var lblAgeFeelError: UILabel!
    
    @IBOutlet weak var lblCountryError: UILabel!
    @IBOutlet weak var lblGenderError: UILabel!
    @IBOutlet weak var lblProfileBioError: UILabel!
    @IBOutlet weak var lblBirthDateError: UILabel!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var confirmPasswordView: UIView!
    @IBOutlet weak var ageFeelView: UIView!
    
    @IBOutlet weak var countryView: UIView!
    @IBOutlet weak var genderView: UIView!
    @IBOutlet weak var profileBioView: UIView!
    @IBOutlet weak var birthDateView: UIView!
    
    @IBOutlet weak var overlay: UIView!
    
    let ageFeelDropDown = DropDown()
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarColor()

        self.txtFieldAgeFeel.addTarget(self, action: #selector(tapGenderField), for: .allEditingEvents)
        self.txtFieldProfileBio.addTarget(self, action: #selector(tapBioField), for: .allEditingEvents)
        self.txtFieldBirthDate.addTarget(self, action: #selector(tapDateField), for: .allEditingEvents)
        
        // Initialization code
        ageFeelDropDown.anchorView = self.txtFieldAgeFeel
        ageFeelDropDown.dataSource = ["Youth", "Young Adult", "Middle Aged", "Senior"]
        ageFeelDropDown.cellConfiguration = { (index, item) in return "\(item)" }
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
            self.lblPasswordError.isHidden = true
            self.lblConfirmPasswordError.isHidden = true
            
            self.nameView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.emailView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.passwordView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            self.confirmPasswordView.layer.borderColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5)
            
        }
    }
    
    @objc func tapDateField() {
        
        DispatchQueue.main.async {
            self.view.endEditing(true)
            
            let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "DatePopUpVC") as! DatePopUpVC
            
            vc.setDate = { strDate in
                self.txtFieldBirthDate.text = strDate
            }
            
            vc.modalPresentationStyle = .overCurrentContext
            //vc.modalTransitionStyle = .crossDissolve
            
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    @objc func tapGenderField() {
        
        self.view.endEditing(true)
        
        ageFeelDropDown.selectionAction = { (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.txtFieldAgeFeel.text = item
        }

        ageFeelDropDown.width = self.txtFieldAgeFeel.bounds.width
        ageFeelDropDown.bottomOffset = CGPoint(x: 0, y:(ageFeelDropDown.anchorView?.plainView.bounds.height)!)
        ageFeelDropDown.show()
    
    }
    
    @objc func tapBioField() {
    
        DispatchQueue.main.async {
            self.view.endEditing(true)
            
            let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "EditBiographyVC") as! EditBiographyVC
            
            vc.setBio = { strBio in
                self.txtFieldProfileBio.text = strBio
            }
            
            vc.modalPresentationStyle = .overCurrentContext
            //vc.modalTransitionStyle = .crossDissolve
            
            self.present(vc, animated: true, completion: nil)
        }
        
    }

    //MARK: IBAction
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        let vc = DesignManager.loadViewControllerFromMainStoryBoard(identifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func tncBtnClicked(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "WebViewVC") as! WebViewVC
            vc.isComeFrom = "Terms & Conditions"
            vc.loadableUrlStr = "https://appin.se/privacysv"
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
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
        
        //let currentDate = Date()
        // 1) Create a DateFormatter() object.
        //let format = DateFormatter()
        // 2) Set the current timezone to .current, or America/Chicago.
        //format.timeZone = .current
        // 3) Set the format of the altered date.
        //format.dateFormat = "yyyy-mm-dd"
        // 4) Set the current date, altered by timezone.
        //let dateString = format.string(from: currentDate)
        
        //let locale = NSLocale.current.languageCode
        //let pre = Locale.preferredLanguages[0]
        
        //var countryName = ""
        //if let countryCode = (Locale.current as NSLocale).object(forKey: .countryCode) as? String {
            //print(countryCode)
            //countryName = countryCode
        //}
                
        var params = [String : Any]()
        params = ["name" : self.txtFieldName.text!,
                  "username" : self.txtFieldName.text!,
                  "email" : self.txtFieldEmail.text!,
                  "password" : self.txtFieldPassword.text!,
                  "ageFeel" : self.txtFieldAgeFeel.text!,
                  //"contactNo" : self.txtFieldContactNo.text!,
                  //"address" : self.txtFieldAddress.text!,
                  //"country" : self.txtFieldCountry.text ?? countryName,
                  //"gender" : self.txtFieldGender.text!,
                  //"profileBio" : self.txtFieldProfileBio.text!,
                  //"birthDate" : self.txtFieldBirthDate.text!,
                  //"deviceId" : UIDevice.current.identifierForVendor!.uuidString,
                  //"deviceMeta" : UIDevice.modelName,
                  //"os" : UIDevice.current.systemVersion,
                  //"timeZone" : dateString,
                  //"language" : pre
                  ]
        
        print("params = \(params)")
        print("\(kRegisterURL)")
        
        self.showSpinner(onView: self.view)
        
        Alamofire.request(kRegisterURL, method: .post, parameters: params, encoding: URLEncoding.httpBody, headers: [:]).responseJSON { (responseData) in
            
            self.removeSpinner()
            
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
    
    @IBAction func userAgreementBtnClicked(_ sender: UIButton) {
        let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "WebViewVC") as! WebViewVC
        vc.isComeFrom = "APPIN - User Agreement"
        vc.loadableUrlStr = "http://www.jokk.app/agreementsv"
        //vc.loadableUrlStr = "http://haldidhana.com/chinabasin.html"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func privacyPolicyBtnClicked(_ sender: UIButton) {
        let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "WebViewVC") as! WebViewVC
        vc.isComeFrom = "APPIN - Privacy Policy"
        vc.loadableUrlStr = "http://www.jokk.app/privacysv"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func GDPRAgreementBtnClicked(_ sender: UIButton) {
        let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "WebViewVC") as! WebViewVC
        vc.isComeFrom = "APPIN - GDPR"
        vc.loadableUrlStr = "http://www.jokk.app/gdprsv"
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    //MARK: Custom Methods
    func Validation() -> Bool {
        
        self.view.endEditing(true)
        
        if txtFieldName.text!.isEmpty {
            
            DispatchQueue.main.async {
                self.nameView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
                self.lblNameError.text = "Please Enter Name"
                self.lblNameError.isHidden = false
            }
            
            return false
        }
        else if txtFieldEmail.text!.isEmpty {
            
            DispatchQueue.main.async {
                self.emailView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
                self.lblEmailError.text = "Please Enter E-mail Address"
                self.lblEmailError.isHidden = false
            }
            
            return false
        }
        else if(!Alert.isValidEmail(testStr: txtFieldEmail.text!)) {
            
            DispatchQueue.main.async {
                self.emailView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
                self.lblEmailError.text = "Please Enter Valid E-mail Address"
                self.lblEmailError.isHidden = false
            }
            
            return false
        }
        else if txtFieldPassword.text!.isEmpty {
            
            DispatchQueue.main.async {
                self.passwordView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
                self.lblPasswordError.text = "Please Enter Password"
                self.lblPasswordError.isHidden = false
            }
            
            return false
        }
        else if txtFieldConfirmPassword.text!.isEmpty {
            
            DispatchQueue.main.async {
                self.confirmPasswordView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
                self.lblConfirmPasswordError.text = "Please Enter Confirm Password"
                self.lblConfirmPasswordError.isHidden = false
            }
            
            return false
        }
        else if txtFieldPassword.text != txtFieldConfirmPassword.text {
            
            DispatchQueue.main.async {
                self.confirmPasswordView.layer.borderColor = #colorLiteral(red: 0.9215686275, green: 0.3411764706, blue: 0.3411764706, alpha: 1)
                self.lblConfirmPasswordError.text = "Password Doesn't Match"
                self.lblConfirmPasswordError.isHidden = false
            }
            
            return false
        }
        else if !self.checkBoxBtn.isSelected {
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
