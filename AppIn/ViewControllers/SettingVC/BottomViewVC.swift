//
//  BottomViewVC.swift
//  AppIn
//
//  Created by sameer khan on 31/10/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class BottomViewVC: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLbl: UILabel!
    @IBOutlet weak var actionBtn: UIButton!
    
    var img = UIImage()
    var lbl = String()
    var btn = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.iconImageView.image = img
        self.titleLbl.text = lbl
        self.actionBtn.setTitle(btn, for: .normal)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            // code to remove your view
            self.dismiss(animated: true) {
                
            }
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
        self.view.endEditing(true)
        
        self.dismiss(animated: true) {
            
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
