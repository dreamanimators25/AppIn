//
//  AddChannelPopUpVC.swift
//  AppIn
//
//  Created by sameer khan on 22/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddChannelPopUpVC: UIViewController {
    
    @IBOutlet weak var txtFieldChannelCode: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

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
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        
        self.dismiss(animated: true) {
            if let block = enableTabBarItems {
                block(self.txtFieldChannelCode.text ?? "")
            }
        }
        
    }
    
    //MARK: IBAction
    @IBAction func addBtnClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        
        if txtFieldChannelCode.text!.isEmpty {
            Alert.showAlert(strTitle: "", strMessage: "Please Enter Referrel code!", Onview: self)
        }else {
            self.dismiss(animated: true) {
                if let block = enableTabBarItems {
                    print("Call Api for Channel Add")
                    block(self.txtFieldChannelCode.text ?? "")
                }
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
