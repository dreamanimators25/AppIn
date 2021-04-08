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
    
    func setStatusBarColor() {
        
        if #available(iOS 13.0, *) {
            let app = UIApplication.shared
            let statusBarHeight: CGFloat = app.statusBarFrame.size.height
            
            let statusbarView = UIView()
            statusbarView.backgroundColor = AppThemeColor
            view.addSubview(statusbarView)
          
            statusbarView.translatesAutoresizingMaskIntoConstraints = false
            statusbarView.heightAnchor
                .constraint(equalToConstant: statusBarHeight).isActive = true
            statusbarView.widthAnchor
                .constraint(equalTo: view.widthAnchor, multiplier: 1.0).isActive = true
            statusbarView.topAnchor
                .constraint(equalTo: view.topAnchor).isActive = true
            statusbarView.centerXAnchor
                .constraint(equalTo: view.centerXAnchor).isActive = true
          
        } else {
            let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView
            statusBar?.backgroundColor = AppThemeColor
        }
    }
    
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
        webConfiguration.preferences.setValue(true, forKey: "allowFileAccessFromFileURLs")
        
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

extension Date {

func getElapsedInterval() -> String {

    let interval = Calendar.current.dateComponents([.year, .month, .day], from: self, to: Date())

    if let year = interval.year, year > 0 {
        return year == 1 ? "\(year)" + " " + "year ago" :
            "\(year)" + " " + "years ago"
    } else if let month = interval.month, month > 0 {
        return month == 1 ? "\(month)" + " " + "month ago" :
            "\(month)" + " " + "months ago"
    } else if let day = interval.day, day > 0 {
        return day == 1 ? "\(day)" + " " + "day ago" :
            "\(day)" + " " + "days ago"
    } else {
        return "a moment ago"

    }

}
}

var vSpinner : UIView?

extension UIViewController {
    func showSpinner(onView : UIView) {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let ai = UIActivityIndicatorView.init(style: .whiteLarge)
        ai.startAnimating()
        ai.center = spinnerView.center
        
        DispatchQueue.main.async {
            spinnerView.addSubview(ai)
            onView.addSubview(spinnerView)
        }
        
        vSpinner = spinnerView
    }
    
    func removeSpinner() {
        DispatchQueue.main.async {
            vSpinner?.removeFromSuperview()
            vSpinner = nil
        }
    }
}
