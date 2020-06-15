//
//  CreateAccountVC.swift
//  AppIn
//
//  Created by sameer khan on 14/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class CreateAccountVC: UIViewController {
    
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var nextBtn: UIButton!
    
    @IBOutlet weak var txtFieldFirstName: UITextField!
    @IBOutlet weak var txtFieldLastName: UITextField!
    @IBOutlet weak var txtFieldCompanyName: UITextField!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    @IBOutlet weak var txtFieldPasswordAgain: UITextField!
    
    @IBOutlet weak var mainViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var firstViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var secondViewHeightConstraint: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.backBtn.layer.cornerRadius = 5.0
        self.nextBtn.layer.cornerRadius = 5.0
        
        DispatchQueue.main.async {
            self.mainViewHeightConstraint.constant = 305
            self.secondViewHeightConstraint.constant = 0
            
            self.txtFieldEmail.isUserInteractionEnabled = false
            self.txtFieldPassword.isUserInteractionEnabled = false
            self.txtFieldPasswordAgain.isUserInteractionEnabled = false
        }
        
    }
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        
        if nextBtn.titleLabel?.text == "Next" {
            _ = self.navigationController?.popViewController(animated: true)
        }else {
            DispatchQueue.main.async {
                self.mainViewHeightConstraint.constant = 305
                self.firstViewHeightConstraint.constant = 225
                self.secondViewHeightConstraint.constant = 0
                self.nextBtn.setTitle("Next", for: .normal)
                
                self.txtFieldFirstName.isUserInteractionEnabled = true
                self.txtFieldLastName.isUserInteractionEnabled = true
                self.txtFieldCompanyName.isUserInteractionEnabled = true
                self.txtFieldEmail.isUserInteractionEnabled = false
                self.txtFieldPassword.isUserInteractionEnabled = false
                self.txtFieldPasswordAgain.isUserInteractionEnabled = false
            }
        }
        
    }

    //MARK: IBAction
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        
        if sender.titleLabel?.text == "Next" {
            DispatchQueue.main.async {
                self.mainViewHeightConstraint.constant = 505
                self.firstViewHeightConstraint.constant = 0
                self.secondViewHeightConstraint.constant = 425
                sender.setTitle("DONE", for: .normal)
                
                self.txtFieldEmail.becomeFirstResponder()
                
                self.txtFieldFirstName.isUserInteractionEnabled = false
                self.txtFieldLastName.isUserInteractionEnabled = false
                self.txtFieldCompanyName.isUserInteractionEnabled = false
                self.txtFieldEmail.isUserInteractionEnabled = true
                self.txtFieldPassword.isUserInteractionEnabled = true
                self.txtFieldPasswordAgain.isUserInteractionEnabled = true
            }
        }else {
            
        }
        
    }
    
    @IBAction func userAgreementBtnClicked(_ sender: UIButton) {
        print("One")
    }
    
    @IBAction func privacyPolicyBtnClicked(_ sender: UIButton) {
        print("One")
    }
    
    @IBAction func GDPRAgreementBtnClicked(_ sender: UIButton) {
        print("One")
    }
    
    @IBAction func checkBoxBtnClicked(_ sender: UIButton) {
        print("One")
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
