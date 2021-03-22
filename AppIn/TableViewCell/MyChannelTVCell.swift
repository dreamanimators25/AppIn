//
//  MyChannelTVCell.swift
//  AppIn
//
//  Created by sameer khan on 24/10/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import DropDown

class MyChannelTVCell: UITableViewCell {
    
    @IBOutlet weak var channelImgView: UIImageView!
    @IBOutlet weak var channelSubNameLbl: UILabel!
    @IBOutlet weak var channelNameLbl: UILabel!
    @IBOutlet weak var notificationBtn: UIButton!
    @IBOutlet weak var moreBtn: UIButton!
    @IBOutlet weak var seperatorLbl: UILabel!
    
    let cellDropDown = DropDown()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        cellDropDown.anchorView = self.moreBtn
        //cellDropDown.dataSource = ["Invite","About","Remove channel","Share"]
        cellDropDown.dataSource = ["Invite","About","Remove channel"]
        cellDropDown.cellConfiguration = { (index, item) in return "\(item)" }
       
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    @IBAction func notificationBtnClicked(_ sender: UIButton) {
        //sender.isSelected = !sender.isSelected
        
        if let selectedIndex = TVNotificationIndex {
            selectedIndex(sender.tag, sender)
            
            sender.isSelected = !sender.isSelected
        }
    }
    
    @IBAction func moreBtnClicked(_ sender: UIButton) {
        
        cellDropDown.selectionAction = { (index: Int, item: String) in
            
            if let selectedIndex = TVDropDownIndex {
                selectedIndex(sender.tag, index, sender)
            }
        }

        cellDropDown.width = 130
        cellDropDown.layer.cornerRadius = 20.0
        cellDropDown.backgroundColor = UIColor.white
        
        cellDropDown.bottomOffset = CGPoint(x: -110, y:(cellDropDown.anchorView?.plainView.bounds.height)!)
        cellDropDown.show()
        
    }
    
}
