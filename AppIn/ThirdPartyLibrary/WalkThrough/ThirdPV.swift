//
//  ThirdPV.swift
//  AppIn
//
//  Created by sameer khan on 14/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class ThirdPV: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }

    //MARK: IBAction
    @IBAction func getStartedOnboarding(_ sender: UIButton) {
        let story = UIStoryboard.init(name: "Main", bundle: nil)
        let vc = story.instantiateViewController(withIdentifier: "LoginVC") as! LoginVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
