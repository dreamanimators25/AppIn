//
//  EntryNavigationVC.swift
//  AppIn
//
//  Created by Sameer Khan on 25/01/21.
//  Copyright © 2021 Sameer khan. All rights reserved.
//

import UIKit

class EntryNavigationVC: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.setStatusBarColor()
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
