//
//  AboutVC.swift
//  AppIn
//
//  Created by Sameer Khan on 18/02/21.
//  Copyright © 2021 Sameer khan. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {
    
    var isComeFrom = "Channel"
    var isID = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setStatusBarColor()
    }
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "about" {
            let dest = segue.destination as! AboutTblVC
            dest.isComeFrom = self.isComeFrom
            dest.isID = self.isID
        }
        
        
    }

}
