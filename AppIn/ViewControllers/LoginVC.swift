//
//  LoginVC.swift
//  AppIn
//
//  Created by sameer khan on 14/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var logInBtn: UIButton!
    @IBOutlet weak var forgotPasswordBtn: UIButton!
    @IBOutlet weak var createAccountBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.logInBtn.layer.cornerRadius = 5.0
        self.forgotPasswordBtn.layer.cornerRadius = 5.0
        self.createAccountBtn.layer.cornerRadius = 5.0
        
    }
    
    //MARK: IBAction
    @IBAction func loginBtnClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func forgotBtnClicked(_ sender: UIButton) {
        
    }
    
    @IBAction func createBtnClicked(_ sender: UIButton) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "CreateAccountVC") as! CreateAccountVC
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
