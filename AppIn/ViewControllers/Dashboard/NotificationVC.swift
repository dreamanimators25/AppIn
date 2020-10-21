//
//  NotificationVC.swift
//  AppIn
//
//  Created by sameer khan on 18/10/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

class NotificationVC: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var notificationTableView: UITableView!
    @IBOutlet weak var ErrorView: UIView!
    
    let arrRows = ["New information was added - Regulation 2020","New channel was added - Environment","New PDF was added - Human Resource 2020","HR channel was updated"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    //MARK: UITableView DataSource & Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if arrRows.count == 0 {
            self.ErrorView.isHidden = false
        }else {
            self.ErrorView.isHidden = true
        }
        
        return arrRows.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let notificationCell = tableView.dequeueReusableCell(withIdentifier: "notificationCell", for: indexPath)
        let notiImgView : UIImageView = notificationCell.viewWithTag(10) as! UIImageView
        let titelLbl : UILabel = notificationCell.viewWithTag(20) as! UILabel
        
        titelLbl.text = arrRows[indexPath.row]
        if indexPath.row % 2 == 0 {
            notiImgView.image = #imageLiteral(resourceName: "uber")
        }else {
            notiImgView.image = #imageLiteral(resourceName: "headSas")
        }
        
        return notificationCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }

}
