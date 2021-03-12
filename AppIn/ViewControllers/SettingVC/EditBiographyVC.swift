//
//  EditBiographyVC.swift
//  AppIn
//
//  Created by sameer khan on 24/10/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class EditBiographyVC: UIViewController {
    
    @IBOutlet weak var txtViewBiography: UITextView!
    
    var setBio : ((_ bio : String) -> (Void))?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarColor()
        
        self.txtViewBiography.becomeFirstResponder()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.tabBarController?.tabBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.tabBarController?.tabBar.isHidden = false
    }
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        
        Alert.showAlertWithTowButton("", message: "Do you want to?", alertButtonTitles: ["SAVE","DISCARD"], alertButtonStyles: [.destructive,.default], vc: self) { (index) in
            
            DispatchQueue.main.async {
                self.dismiss(animated: true) { }
            }
            
        }
        
    }
    
    @IBAction func saveBtnClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        
        self.dismiss(animated: true) {
            if let bio = self.setBio {
                bio(self.txtViewBiography.text ?? "")
            }
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
