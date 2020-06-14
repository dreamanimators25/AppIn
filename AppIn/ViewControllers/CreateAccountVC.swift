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

    override func viewDidLoad() {
        super.viewDidLoad()

        self.backBtn.layer.cornerRadius = 5.0
        self.nextBtn.layer.cornerRadius = 5.0
        
    }
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }

    //MARK: IBAction
    @IBAction func nextBtnClicked(_ sender: UIButton) {
        
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
