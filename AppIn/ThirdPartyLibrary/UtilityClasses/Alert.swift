//
//  Alert.swift
//  AppIn
//
//  Created by sameer khan on 16/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import SafariServices
import WebKit

class Alert: NSObject {
    
    // function to set show alert
    class func showAlert(strTitle: String, strMessage : String , Onview : UIViewController)
    {
        if Onview.navigationController != nil {
            
            DispatchQueue.main.async {
                
                let alertController = UIAlertController(title: strTitle, message: strMessage, preferredStyle: UIAlertController.Style.alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
                
                alertController.view.tintColor = AppThemeColor
                Onview.present(alertController, animated: true, completion: nil)
            }
        }else {
            DispatchQueue.main.async {
                
                let alertController = UIAlertController(title: strTitle, message: strMessage, preferredStyle: UIAlertController.Style.alert)
                
                alertController.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default,handler: nil))
                
                alertController.view.tintColor = AppThemeColor
                Onview.present(alertController, animated: true, completion: nil)
            }
        }
    }
    
    class func showAlertWithTowButton(_ title: String, message: String, alertButtonTitles: [String], alertButtonStyles: [UIAlertAction.Style], vc: UIViewController, completion: @escaping (Int)->Void) -> Void
    {
        let alert = UIAlertController(title: title,message: message,preferredStyle: UIAlertController.Style.alert)
        
        for title in alertButtonTitles {
            let actionObj = UIAlertAction(title: title,
                                          style: alertButtonStyles[alertButtonTitles.firstIndex(of: title)!], handler: { action in
                                            completion(alertButtonTitles.firstIndex(of: action.title!)!)
            })
            
            alert.addAction(actionObj)
        }
        
        alert.view.tintColor = AppThemeColor
        //vc will be the view controller on which you will present your alert as you cannot use self because this method is static.
        vc.present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithActionSheet(_ title: String?, message: String?, alertButtonTitles: [String], alertButtonStyles: [UIAlertAction.Style], vc: UIViewController, completion: @escaping (Int)->Void) -> Void
    {
        let alert = UIAlertController(title: title,
                                      message: message == "" ? nil : message,
                                      preferredStyle: UIAlertController.Style.actionSheet)
        
        for title in alertButtonTitles {
            let actionObj = UIAlertAction(title: title,
                                          style: alertButtonStyles[alertButtonTitles.firstIndex(of: title)!], handler: { action in
                                            completion(alertButtonTitles.firstIndex(of: action.title!)!)
            })
            
            alert.addAction(actionObj)
        }
        
        alert.modalPresentationStyle = .popover
        if let popoverController = alert.popoverPresentationController {
            popoverController.sourceView = vc.view
            popoverController.sourceRect = CGRect(x: vc.view.bounds.midX, y: vc.view.bounds.midY, width: 0, height: 0)
            popoverController.permittedArrowDirections = []
        }
        
        vc.present(alert, animated: true)
        
        //vc will be the view controller on which you will present your alert as you cannot use self because this method is static.
        //  vc.present(alert, animated: true, completion: nil)
    }
    
    // check email is in correct format or not like (abcd@zyc.com)
    class func isValidEmail(testStr:String) -> Bool {
         let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
         return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: testStr)
     }

}

class DesignManager: NSObject {
    
    class func loadViewControllerFromMainStoryBoard(identifier: String) -> Any {
        let storyBoard = UIStoryboard(name: "Main", bundle: Bundle.main)
        let controller = storyBoard.instantiateViewController(withIdentifier: identifier)
        return controller
    }
    
    class func loadViewControllerFromDashboardStoryBoard(identifier: String) -> Any {
        let storyBoard = UIStoryboard(name: "Dashboard", bundle: Bundle.main)
        let controller = storyBoard.instantiateViewController(withIdentifier: identifier)
        return controller
    }
    
    class func loadViewControllerFromWebStoryBoard(identifier: String) -> Any {
        let storyBoard = UIStoryboard(name: "Web", bundle: Bundle.main)
        let controller = storyBoard.instantiateViewController(withIdentifier: identifier)
        return controller
    }
    
    class func loadViewControllerFromContentStoryBoard(identifier: String) -> Any {
        let storyBoard = UIStoryboard(name: "Content", bundle: Bundle.main)
        let controller = storyBoard.instantiateViewController(withIdentifier: identifier)
        return controller
    }
    
}

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
