//
//  InformationVC.swift
//  AppIn
//
//  Created by sameer khan on 23/11/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class InformationVC: UIViewController {
    
    @IBOutlet weak var lblContentTitle: UILabel!
    @IBOutlet weak var lblContentData: UILabel!
    
    var strContentData: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setStatusBarColor()
        
        if let str = self.strContentData {
            self.lblContentData.text = str
        }
        
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
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: IBAction
    @IBAction func shareBtnClicked(_ sender: UIButton) {
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
