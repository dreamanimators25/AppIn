//
//  MyChannelsVC.swift
//  AppIn
//
//  Created by sameer khan on 24/10/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit

var TVDropDownIndex : ((_ ind : Int) -> (Void))?

class MyChannelsVC: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    @IBOutlet weak var myChannelTableView: UITableView!
    
    var arrSec1 = ["SAS","Development","McDonalds"]
    var arrSec2 = ["Uber","Development"]
    var arrSec3 = ["Air bnb","Marketing"]

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
                        
        TVDropDownIndex = { index in
            switch index {
            case 0:
                let vc = DesignManager.loadViewControllerFromSettingStoryBoard(identifier: "InviteVC") as! InviteVC
                self.navigationController?.pushViewController(vc, animated: true)
                
                break
            case 1:
                let vc = DesignManager.loadViewControllerFromContentStoryBoard(identifier: "AboutSasVC") as! AboutSasVC
                self.navigationController?.pushViewController(vc, animated: true)
                
                break
            case 2:
                
                break
            default:
                
                break
            }
        }
        
    }
    
    //MARK: IBAction
    @IBAction func backBtnClicked(_ sender: UIButton) {
        _ = self.navigationController?.popViewController(animated: true)
    }
    
    //MARK: UITableView DataSource & Delegates
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return arrSec1.count
        case 1:
            return arrSec2.count
        default:
            return arrSec3.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let MyChannelTVCell = tableView.dequeueReusableCell(withIdentifier: "MyChannelTVCell", for: indexPath) as! MyChannelTVCell
        
        switch indexPath.section {
        case 0:
            MyChannelTVCell.channelNameLbl.text = arrSec1[indexPath.row]
            
            if indexPath.row == self.arrSec1.count - 1 {
                MyChannelTVCell.seperatorLbl.isHidden = false
                MyChannelTVCell.channelSubNameLbl.isHidden = false
                MyChannelTVCell.channelSubNameLbl.text = "Partner"
            }else {
                MyChannelTVCell.seperatorLbl.isHidden = true
                MyChannelTVCell.channelSubNameLbl.isHidden = true
            }
            
        case 1:
            MyChannelTVCell.channelNameLbl.text = arrSec2[indexPath.row]
            
            if indexPath.row == self.arrSec2.count - 1 {
                MyChannelTVCell.seperatorLbl.isHidden = false
                MyChannelTVCell.channelSubNameLbl.isHidden = false
                MyChannelTVCell.channelSubNameLbl.text = "Partner"
            }else {
                MyChannelTVCell.seperatorLbl.isHidden = true
                MyChannelTVCell.channelSubNameLbl.isHidden = true
            }
            
        default:
            MyChannelTVCell.channelNameLbl.text = arrSec3[indexPath.row]
            
            if indexPath.row == self.arrSec3.count - 1 {
                MyChannelTVCell.seperatorLbl.isHidden = false
                MyChannelTVCell.channelSubNameLbl.isHidden = false
                MyChannelTVCell.channelSubNameLbl.text = "Partner"
            }else {
                MyChannelTVCell.seperatorLbl.isHidden = true
                MyChannelTVCell.channelSubNameLbl.isHidden = true
            }
            
        }
        
        return MyChannelTVCell
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
