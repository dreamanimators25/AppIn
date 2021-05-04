//
//  SplashVC.swift
//  AppIn
//
//  Created by sameer khan on 21/12/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class SplashVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarColor()
        
        let userData = UserDefaults.getUserData()
        if userData != nil {
            
            //DispatchQueue.main.async(execute: {
                //if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                //appDelegate.navigateToDashboardScreen()
            
                    let mainStoryboard = UIStoryboard(name: "Dashboard", bundle: nil)
                    let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "TabBarViewController") as! TabBarViewController
                    self.navigationController?.pushViewController(loginVC, animated: true)
            
            //let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            //let verifyVC = mainStoryboard.instantiateViewController(withIdentifier: "VerifyEmailVC") as! VerifyEmailVC
            //self.navigationController?.pushViewController(verifyVC, animated: true)
            
                //}
            //})
            
        }else {
            
            //if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                //appDelegate.navigateToLoginScreen()
                
                let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                let loginVC = mainStoryboard.instantiateViewController(withIdentifier: "IntroSplashVC") as! IntroSplashVC
                self.navigationController?.pushViewController(loginVC, animated: true)
                
            //}
            
        }

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
