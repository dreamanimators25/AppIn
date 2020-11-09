//
//  SinglePageCell.swift
//  AppIn
//
//  Created by sameer khan on 01/11/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import AVFoundation
import DropDown

class SinglePageCell: UICollectionViewCell {
    
    @IBOutlet weak var moreBtn: UIButton!
    
    let cellDropDown = DropDown()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
        cellDropDown.anchorView = self.moreBtn
        cellDropDown.dataSource = ["Invite to channel","Share","About"]
        cellDropDown.cellConfiguration = { (index, item) in return "\(item)" }
       
    }

    @IBAction func moreBtnClicked(_ sender: UIButton) {
        cellDropDown.selectionAction = { (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            
            if let selectedIndex = CVDropDownIndex {
                selectedIndex(index)
            }
        }

        cellDropDown.width = 130
        cellDropDown.bottomOffset = CGPoint(x: 0, y:(cellDropDown.anchorView?.plainView.bounds.height)!)
        cellDropDown.show()
    }
    
}
