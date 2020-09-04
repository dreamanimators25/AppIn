//
//  TabBarViewController.swift
//  Medicus
//
//  Created by Jitendra Singh on 22/03/18.
//  Copyright © 2018 Jitendra Singh. All rights reserved.
//

import UIKit

class TabBarViewController: UITabBarController {
    
    var selecIndexTab = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabBarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setTabBarItems() {
        
        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        myTabBarItem1.image = #imageLiteral(resourceName: "home")
        myTabBarItem1.selectedImage = #imageLiteral(resourceName: "home")
        myTabBarItem1.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        myTabBarItem1.title = "HOME"
        myTabBarItem1.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppThemeColor], for: .selected)
        myTabBarItem1.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .normal)
        
        
        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        myTabBarItem2.image = #imageLiteral(resourceName: "profile")
        myTabBarItem2.selectedImage = #imageLiteral(resourceName: "profile")
        myTabBarItem2.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        myTabBarItem2.title = "PROFILE"
        myTabBarItem2.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppThemeColor], for: .selected)
        myTabBarItem2.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .normal)
        
        
        let myTabBarItem3 = (self.tabBar.items?[2])! as UITabBarItem
        myTabBarItem3.image = #imageLiteral(resourceName: "setting")
        myTabBarItem3.selectedImage =  #imageLiteral(resourceName: "setting")
        myTabBarItem3.imageInsets = UIEdgeInsets(top:0, left: 0, bottom: 0, right: 0)
        myTabBarItem3.title = "SETTINGS"
        myTabBarItem3.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: AppThemeColor], for: .selected)
        myTabBarItem3.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.darkGray], for: .normal)
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let indexOfTab = tabBar.items?.firstIndex(of: item)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
