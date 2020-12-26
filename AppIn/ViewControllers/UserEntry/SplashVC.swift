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
        
        let userData = UserDefaults.getUserData()
        if userData != nil {
            
            DispatchQueue.main.async(execute: {
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.navigateToDashboardScreen()
                }
            })
            
        }else {
            
            DispatchQueue.main.async(execute: {
                if let appDelegate = UIApplication.shared.delegate as? AppDelegate {
                    appDelegate.navigateToLoginScreen()
                }
            })
        
        }

    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
