//
//  SettingsVC.swift
//  AppIn
//
//  Created by sameer khan on 21/06/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var settingTableView: UITableView!
    
    let arrRows = ["USER AGREEMENT","PRIVACY POLICY","GDPR"]
    let arrUrl = ["http://www.jokk.app/agreementsv","http://www.jokk.app/privacysv","http://www.jokk.app/gdprsv"]
    let arrTitle = ["APPIN - User Agreement","APPIN - Privacy Policy","APPIN - GDPR"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: UITableView DataSource & Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let settingCell = tableView.dequeueReusableCell(withIdentifier: "settingCell", for: indexPath)
        let rowLbl : UILabel = settingCell.viewWithTag(10) as! UILabel
        rowLbl.text = self.arrRows[indexPath.row]
        
        return settingCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DesignManager.loadViewControllerFromWebStoryBoard(identifier: "WebViewVC") as! WebViewVC
        vc.isComeFrom = self.arrTitle[indexPath.row]
        vc.loadableUrlStr = self.arrUrl[indexPath.row]
        self.navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
