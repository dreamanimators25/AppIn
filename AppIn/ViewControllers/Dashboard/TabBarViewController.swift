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
        self.tabBar.barTintColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        
        setTabBarItems()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.isHidden = true
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func setTabBarItems() {
        
        //myTabBarItem1.image = #imageLiteral(resourceName: "Channels_unselect")
        //myTabBarItem1.selectedImage = #imageLiteral(resourceName: "Channels_select")
        //#colorLiteral(red: 0.6039215686, green: 0.537254902, blue: 0.537254902, alpha: 1)
        
        let myTabBarItem1 = (self.tabBar.items?[0])! as UITabBarItem
        myTabBarItem1.image = UIImage(named: "Channels_unselect")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem1.selectedImage = UIImage(named: "Channels_select")?.withRenderingMode(.alwaysOriginal)
        myTabBarItem1.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        myTabBarItem1.title = "Channels"
        myTabBarItem1.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], for: .selected)
        myTabBarItem1.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)], for: .normal)
        
        
        let myTabBarItem2 = (self.tabBar.items?[1])! as UITabBarItem
        myTabBarItem2.image = UIImage(named: "Feed_unselect")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem2.selectedImage = UIImage(named: "Feed_select")?.withRenderingMode(.alwaysOriginal)
        myTabBarItem2.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        myTabBarItem2.title = "Feed"
        myTabBarItem2.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], for: .selected)
        myTabBarItem2.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)], for: .normal)
        
        
        let myTabBarItem3 = (self.tabBar.items?[2])!as UITabBarItem
        myTabBarItem3.image = UIImage(named: "Bell_unselect")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem3.selectedImage = UIImage(named: "Bell_select")?.withRenderingMode(.alwaysOriginal)
        myTabBarItem3.imageInsets = UIEdgeInsets(top:0, left: 0, bottom: 0, right: 0)
        myTabBarItem3.title = "Notifications"
        myTabBarItem3.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], for: .selected)
        myTabBarItem3.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)], for: .normal)
        
        
        let myTabBarItem4 = (self.tabBar.items?[3])! as UITabBarItem
        myTabBarItem4.image = UIImage(named: "Setting_unselect")?.withRenderingMode(UIImage.RenderingMode.alwaysOriginal)
        myTabBarItem4.selectedImage = UIImage(named: "Setting_select")?.withRenderingMode(.alwaysOriginal)
        myTabBarItem4.imageInsets = UIEdgeInsets(top:0, left: 0, bottom: 0, right: 0)
        myTabBarItem4.title = "Settings"
        myTabBarItem4.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)], for: .selected)
        myTabBarItem4.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0)], for: .normal)
        
    }
    
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        let indexOfTab = tabBar.items?.firstIndex(of: item)
        print(indexOfTab ?? 0)
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    
}
