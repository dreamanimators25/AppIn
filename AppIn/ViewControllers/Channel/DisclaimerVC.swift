//
//  DisclaimerVC.swift
//  AppIn
//
//  Created by Sameer Khan on 23/02/21.
//  Copyright © 2021 Sameer khan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class DisclaimerVC: UIViewController {
    
    @IBOutlet weak var contentLbl: UILabel!
    @IBOutlet weak var okBtn: UIButton!
    
    var strContent : String?
    var strContentType : String?
    var strContentNo : String?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let strData = self.strContent {
            self.contentLbl.text = strData.htmlToString
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
    
    @IBAction func agreeBtnClicked(_ sender: UIButton) {
        self.dismiss(animated: true) {
            self.goToFeedContent()
        }
    }
    
    func goToFeedContent() {
        if let selectedIndex = CVgoThereIndex {
            selectedIndex(self.strContentType ?? "", self.strContentNo ?? "")
        }
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
