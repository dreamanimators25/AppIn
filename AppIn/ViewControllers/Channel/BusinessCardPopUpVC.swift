//
//  BusinessCardPopUpVC.swift
//  AppIn
//
//  Created by Sameer Khan on 20/06/21.
//  Copyright © 2021 Sameer khan. All rights reserved.
//

import UIKit
import MessageUI

class BusinessCardPopUpVC: UIViewController, MFMailComposeViewControllerDelegate {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblPhoneNum: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    
    @IBOutlet weak var nameView: UIView!
    @IBOutlet weak var designationView: UIView!
    @IBOutlet weak var phoneNumView: UIView!
    @IBOutlet weak var emailView: UIView!
    @IBOutlet weak var socialView: UIView!
    
    @IBOutlet weak var nameBtn: UIButton!
    @IBOutlet weak var designationBtn: UIButton!
    @IBOutlet weak var contactNoBtn: UIButton!
    @IBOutlet weak var emailBtn: UIButton!
    
    @IBOutlet weak var facebookBtn: UIButton!
    @IBOutlet weak var linkedInBtn: UIButton!
    @IBOutlet weak var whatsAppBtn: UIButton!
    @IBOutlet weak var webBtn: UIButton!
    
    var businessDict : NSDictionary?
    var strContact = ""
    var strEmail = ""
    var strFacebook = ""
    var strLinkedIn = ""
    var strWhatsApp = ""
    var strWebsite = ""

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.changeColorOfBtn()
        
        if let name = self.businessDict?["cardName"] as? String , name != "" {
            self.nameView.isHidden = false
            self.lblName.text = name
        }else {
            self.nameView.isHidden = true
        }

        if let designation = self.businessDict?["designation"] as? String, designation != "" {
            self.designationView.isHidden = false
            self.lblDesignation.text = designation
        }else {
            self.designationView.isHidden = true
        }

        if let contactNumber = self.businessDict?["contactNumber"] as? String, contactNumber != "" {
            self.phoneNumView.isHidden = false
            self.lblPhoneNum.text = contactNumber
            self.strContact = contactNumber
        }else {
            self.phoneNumView.isHidden = true
        }

        if let emailAddress = self.businessDict?["emailAddress"] as? String, emailAddress != "" {
            self.emailView.isHidden = false
            self.lblEmail.text = emailAddress
            self.strEmail = emailAddress
        }else {
            self.emailView.isHidden = true
        }
        
        if ((self.businessDict?["facebook"]) == nil) && ((self.businessDict?["linkedin"]) == nil) && ((self.businessDict?["whatsAppDetail"]) == nil) && ((self.businessDict?["website"]) == nil) {
            
            self.socialView.isHidden = true
                        
        }else {
            self.socialView.isHidden = false
            
            if let facebook = self.businessDict?["facebook"] as? String, facebook != "" {
                self.facebookBtn.isHidden = false
                self.strFacebook = facebook
            }else {
                self.facebookBtn.isHidden = true
            }
            
            if let linkedin = self.businessDict?["linkedin"] as? String, linkedin != "" {
                self.linkedInBtn.isHidden = false
                self.strLinkedIn = linkedin
            }else {
                self.linkedInBtn.isHidden = true
            }
            
            if let whatsAppDetail = self.businessDict?["whatsAppDetail"] as? String, whatsAppDetail != "" {
                self.whatsAppBtn.isHidden = false
                self.strWhatsApp = whatsAppDetail
            }else {
                self.whatsAppBtn.isHidden = true
            }
            
            if let website = self.businessDict?["website"] as? String, website != "" {
                self.webBtn.isHidden = false
                self.strWebsite = website
            }else {
                self.webBtn.isHidden = true
            }
            
        }
        
        
    }
    
    //MARK: Custom Methods
    func changeColorOfBtn() {
        
        let origImage1 = UIImage(named: "icons8-user")
        let tintedImage1 = origImage1?.withRenderingMode(.alwaysTemplate)
        self.nameBtn.setImage(tintedImage1, for: .normal)
        self.nameBtn.tintColor = AppThemeColor
        
        let origImage2 = UIImage(named: "briefcase")
        let tintedImage2 = origImage2?.withRenderingMode(.alwaysTemplate)
        self.designationBtn.setImage(tintedImage2, for: .normal)
        self.designationBtn.tintColor = AppThemeColor
        
        let origImage3 = UIImage(named: "calling")
        let tintedImage3 = origImage3?.withRenderingMode(.alwaysTemplate)
        self.contactNoBtn.setImage(tintedImage3, for: .normal)
        self.contactNoBtn.tintColor = AppThemeColor
        
        let origImage4 = UIImage(named: "icons8-mail")
        let tintedImage4 = origImage4?.withRenderingMode(.alwaysTemplate)
        self.emailBtn.setImage(tintedImage4, for: .normal)
        self.emailBtn.tintColor = AppThemeColor
        
        let origImage5 = UIImage(named: "icons8-facebook")
        let tintedImage5 = origImage5?.withRenderingMode(.alwaysTemplate)
        self.facebookBtn.setImage(tintedImage5, for: .normal)
        self.facebookBtn.tintColor = AppThemeColor
        
        let origImage6 = UIImage(named: "linkedin")
        let tintedImage6 = origImage6?.withRenderingMode(.alwaysTemplate)
        self.linkedInBtn.setImage(tintedImage6, for: .normal)
        self.linkedInBtn.tintColor = AppThemeColor
        
        let origImage7 = UIImage(named: "icons8-whatsapp")
        let tintedImage7 = origImage7?.withRenderingMode(.alwaysTemplate)
        self.whatsAppBtn.setImage(tintedImage7, for: .normal)
        self.whatsAppBtn.tintColor = AppThemeColor
        
        let origImage8 = UIImage(named: "web")
        let tintedImage8 = origImage8?.withRenderingMode(.alwaysTemplate)
        self.webBtn.setImage(tintedImage8, for: .normal)
        self.webBtn.tintColor = AppThemeColor
        
        
    }
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true) { }
    }
        
    @IBAction func phoneNumBtnClicked(_ sender: UIButton) {
        
        DispatchQueue.main.async {
            guard let number = URL(string: "tel://\(self.strContact)") else { return }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(number, options: [:], completionHandler: { (status) in })
            } else {
                UIApplication.shared.openURL(number)
            }
        }
        
    }
    
    @IBAction func emailBtnClicked(_ sender: UIButton) {
    
        DispatchQueue.main.async {
            self.openEmailLink(link: self.strEmail)
        }
        
    }
    
    @IBAction func facebookBtnClicked(_ sender: UIButton) {
    
        DispatchQueue.main.async {
            
            if self.schemeAvailable(scheme: "facebook://app")
            {
                if let url = NSURL(string: self.strFacebook) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url as URL)
                    } else {
                        UIApplication.shared.openURL(url as URL)
                    }
                }
            }
            else
            {
                let urlStr = "https://apps.apple.com/us/app/facebook/id284882215"
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: urlStr)!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(URL(string: urlStr)!)
                }
            }
            
        }
        
    }
    
    @IBAction func linkedInBtnClicked(_ sender: UIButton) {
    
        DispatchQueue.main.async {
            
            if self.schemeAvailable(scheme: "linkedin://app")
            {
                if let url = NSURL(string: self.strLinkedIn) {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url as URL)
                    } else {
                        UIApplication.shared.openURL(url as URL)
                    }
                }
            }
            else
            {
                let urlStr = "https://apps.apple.com/us/app/linkedin-network-job-finder/id288429040"
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: urlStr)!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(URL(string: urlStr)!)
                }
            }
            
        }
        
    }
    
    @IBAction func whatsAppBtnClicked(_ sender: UIButton) {
    
        DispatchQueue.main.async {
            
            if self.schemeAvailable(scheme: "whatsapp://app")
            {
                if let url = NSURL(string: "https://api.whatsapp.com/send?phone=\(self.strWhatsApp)&text=") {
                    if #available(iOS 10, *) {
                        UIApplication.shared.open(url as URL)
                    } else {
                        UIApplication.shared.openURL(url as URL)
                    }
                }
            }
            else
            {
                let urlStr = "https://itunes.apple.com/in/app/whatsapp-messenger/id310633997?mt=8"
                if #available(iOS 10.0, *) {
                    UIApplication.shared.open(URL(string: urlStr)!, options: [:], completionHandler: nil)
                } else {
                    UIApplication.shared.openURL(URL(string: urlStr)!)
                }
            }
            
        }
        
    }
    
    @IBAction func webBtnClicked(_ sender: UIButton) {
    
        DispatchQueue.main.async {
            self.openLinkInAppInWebView(link: self.strWebsite)
        }
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    
    //MARK: Check App Install or not
    
    func schemeAvailable(scheme: String) -> Bool {
        if let url = URL(string: scheme) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    
    func openEmailLink(link: String) {
        
        if MFMailComposeViewController.canSendMail() {
            let mailComposerVC = MFMailComposeViewController()
            mailComposerVC.mailComposeDelegate = self
            mailComposerVC.setToRecipients([link])
            
            self.present(mailComposerVC, animated: true, completion: nil)
        } else {
            
        }
    }
    
    func openLinkInAppInWebView(link : String) {
        
        let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "WebViewVC") as! WebViewVC
        vc.isComeFrom = "CHINA BASIN"
        vc.loadableUrlStr = link
        vc.isPresent = true
        vc.modalPresentationStyle = .overFullScreen
        self.present(vc, animated: true) {
            
        }
        
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true, completion: nil)
    }
    
}
