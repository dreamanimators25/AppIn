//
//  Extensions.swift
//  AppIn
//
//  Created by sameer khan on 30/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import SafariServices
import WebKit

class AppExtensions: NSObject {

}

//MARK: UIViewController
extension UIViewController {
    
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
    
    func presentSafariVC(strURL:String) {
        let url = NSURL.init(string: strURL )! as URL
        let safariVC = SFSafariViewController(url: url)
        self.present(safariVC, animated: true, completion: nil)
    }
    
    func addWKWebView(viewForWeb:UIView) -> WKWebView {
        let webConfiguration = WKWebViewConfiguration()
        let webView = WKWebView(frame: viewForWeb.frame, configuration: webConfiguration)
        webView.frame.origin = CGPoint.init(x: 0, y: 0)
        webView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        webView.frame.size = viewForWeb.frame.size
        viewForWeb.addSubview(webView)
        return webView
    }
    
}

//MARK: UIViewController
extension UIView {

    func takeScreenshot(captureView: UIView) -> UIImage? {
        
        //Create the UIImage
        UIGraphicsBeginImageContext(captureView.frame.size)
        captureView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        if (image != nil)
        {
            return image!
        }
        
        return UIImage()
        
    }
}

extension UserDefaults {
    
    //MARK:- Save Data
    
    static func saveUserData(modal : RegisterData) {
        
        do {
            let encodedData = try? NSKeyedArchiver.archivedData(withRootObject: modal.dictionaryRepresentation(), requiringSecureCoding: true)
            UserDefaults.standard.set(encodedData, forKey: "UserData")
            UserDefaults.standard.synchronize()
        }
                
        //let encodedData = NSKeyedArchiver.archivedData(withRootObject: modal.dictionaryRepresentation())
        //let encodedData = NSKeyedArchiver.archivedData(withRootObject: modal.dictionaryRepresentation(), requiringSecureCoding: true)
        //let encodedData = NSKeyedArchiver.archivedData(withRootObject: modal.dictionaryRepresentation(), requiringSecureCoding: true)
        
    }
        
    //MARK:- Get Data
    static func getUserData() -> RegisterData? {
        if let data = UserDefaults.standard.data(forKey: "UserData"),
            let myLoginData = NSKeyedUnarchiver.unarchiveObject(with: data) as? [String: Any] {
                let loginData = RegisterData.init(object: myLoginData)
                UserDefaults.standard.synchronize()
            return loginData
        } else {
            UserDefaults.standard.synchronize()
            return nil
        }
    }
    
    //Remove Login Data
    static func removeLoginData() {
        UserDefaults.standard.removeObject(forKey: "UserData")
        
        UserDefaults.standard.synchronize()
    }
    
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControl.State) {
        self.clipsToBounds = true  // add this to maintain corner radius
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
            let colorImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            self.setBackgroundImage(colorImage, for: forState)
        }
    }
}
