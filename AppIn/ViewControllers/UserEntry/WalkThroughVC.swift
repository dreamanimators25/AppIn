//
//  ViewController.swift
//  AppIn
//
//  Created by sameer khan on 14/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class WalkThroughVC: UIViewController {
    
    @IBOutlet weak var onboardingContainer: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setStatusBarColor()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
    }

    //MARK: Custom Methods
    
    
    //MARK: IBAction
    @IBAction func skipOnboarding(_ sender: UIButton) {
        sender.removeFromSuperview()
        onboardingContainer.removeFromSuperview()
    }

}

