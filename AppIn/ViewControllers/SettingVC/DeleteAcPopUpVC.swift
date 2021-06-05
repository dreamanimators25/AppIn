//
//  DeleteAcPopUpVC.swift
//  AppIn
//
//  Created by sameer khan on 24/10/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DeleteAcPopUpVC: UIViewController {
    
    var yesDelete : (()->(Void))?
    
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    
    var strTitle : String?
    var strContent : String?
    var btnTitle : String?

    override func viewDidLoad() {
        super.viewDidLoad()
                
        if let str1 = strTitle {
            self.titleLbl.text = str1
        }
        
        if let str2 = strContent {
            self.contentLbl.text = str2
        }
        
        if let str3 = btnTitle {
            self.okBtn.setTitle(str3, for: .normal)
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
    @IBAction func dismissBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true) {
            
        }
    }
    
    @IBAction func deleteAcBtnClicked(_ sender: UIButton) {
        
        self.dismiss(animated: true) {
            
            if let sure = self.yesDelete {
                sure()
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
