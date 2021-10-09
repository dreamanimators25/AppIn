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
import WebKit

class LoginVC: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    @IBOutlet weak var logoImgView: UIImageView!
    @IBOutlet weak var txtFEmail: UITextField!
    @IBOutlet weak var txtFPassword: UITextField!
    
    @IBOutlet weak var lblEmailError: UILabel!
    @IBOutlet weak var lblPasswordError: UILabel!
    
    @IBOutlet weak var overlay: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var passwordView: UIView!
    
    @IBOutlet weak var baseWebView: UIView!
    @IBOutlet weak var webviewHeightConstraint: NSLayoutConstraint!
    var webView: WKWebView!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.logoImgView.layer.cornerRadius = 10.0
        self.setStatusBarColor()
        
        self.LoadWebView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    //MARK: Custom Methods
    func LoadWebView() {
        webView = self.addWKWebView(viewForWeb: self.baseWebView)
        webView.uiDelegate = self
        webView.navigationDelegate = self
        
        let html = "<html>By using the app you certify that you have read and understood and approve our <a href='https://appin.se/termssv'>General Terms,</a> <a href='https://appin.se/privacysv'>Privacy Policy</a>, <a href='https://appin.se/agreementsv'>App Agreement.</a></html>"
                
        
        let headerString = "<head><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></head>"
        
        
        let htmlString = """
            <style>
            @font-face
            {
                font-family: 'CircularStd';
                font-weight: normal;
                src: url(CircularStd-Regular.ttf);
            }
            </style>
                        <span style="font-family: 'CircularStd'; font-weight: normal; font-size: 14; color: black">\(headerString + html)</span>
            """
                
            webView.loadHTMLString(htmlString, baseURL: Bundle.main.bundleURL)
        
    }
    
    func addWKWebView(viewForWeb:UITextView) -> WKWebView {
        let preferences = WKPreferences()
        preferences.javaScriptEnabled = true
    
        
        let webConfiguration = WKWebViewConfiguration()
        webConfiguration.preferences = preferences
        
        //let webView = WKWebView(frame: viewForWeb.frame, configuration: webConfiguration)
        let webView = WKWebView(frame: CGRect.init(x: 10.0, y: 10.0, width: self.baseWebView.bounds.width - 20.0, height: self.baseWebView.bounds.height - 20.0), configuration: webConfiguration)
        
        //webView.frame.origin = CGPoint.init(x: 0, y: 0)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        ///webView.frame.size = viewForWeb.frame.size
        //webView.center = viewForWeb.center
        viewForWeb.addSubview(webView)
        return webView
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        guard case .linkActivated = navigationAction.navigationType,
              let url = navigationAction.request.url
        else {
            decisionHandler(.allow)
            return
        }
        decisionHandler(.cancel)
        
        if navigationAction.request.url?.lastPathComponent == "termssv" {
            
            DispatchQueue.main.async {
                let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "WebViewVC") as! WebViewVC
                vc.isComeFrom = "Terms & Conditions"
                vc.loadableUrlStr = url.absoluteString
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }else if navigationAction.request.url?.lastPathComponent == "privacysv" {
            
            DispatchQueue.main.async {
                let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "WebViewVC") as! WebViewVC
                vc.isComeFrom = "Privacy Policy"
                vc.loadableUrlStr = url.absoluteString
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }else if navigationAction.request.url?.lastPathComponent == "agreementsv" {
            
            DispatchQueue.main.async {
                let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "WebViewVC") as! WebViewVC
                vc.isComeFrom = "App Agreement"
                vc.loadableUrlStr = url.absoluteString
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        }else {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // openURL(_:) is deprecated in iOS 10+.
                UIApplication.shared.openURL(url)
            }
        }
        
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        webView.evaluateJavaScript("document.documentElement.scrollHeight", completionHandler: { (height, error) in
            self.webviewHeightConstraint?.constant = height as! CGFloat
        })
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
                                    
                                if responsModal.data?.emailVerified == "0" {
                                    
                                    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                                    let verifyVC = mainStoryboard.instantiateViewController(withIdentifier: "VerifyEmailVC") as! VerifyEmailVC
                                    self.navigationController?.pushViewController(verifyVC, animated: true)
                                    
                                }else {
                                    
                                    let mainStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                                    let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                                    self.navigationController?.pushViewController(loginVC, animated: true)
                                    
                                }
                                    
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
