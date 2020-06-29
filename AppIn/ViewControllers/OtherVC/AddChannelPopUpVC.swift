//
//  AddChannelPopUpVC.swift
//  AppIn
//
//  Created by sameer khan on 22/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class AddChannelPopUpVC: UIViewController {
    
    @IBOutlet weak var txtFieldChannelCode: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: IBAction
    @IBAction func cancelBtnClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        
        self.dismiss(animated: true) {
            if let block = enableTabBarItems {
                block()
            }
        }
        
    }
    
    //MARK: IBAction
    @IBAction func addBtnClicked(_ sender: UIButton) {
        self.view.endEditing(true)
        print("Call Api for Channel Add")
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
