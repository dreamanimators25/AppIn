//
//  RoundButton.swift
//  AppIn
//
//  Created by sameer khan on 14/10/20.
//  Copyright © 2020 Sameer khan. All rights reserved.
//

import Foundation

@IBDesignable class RoundButton: UIButton {

    override init(frame: CGRect) {
        super.init(frame: frame)
        sharedInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        sharedInit()
    }
    
    override func prepareForInterfaceBuilder() {
        sharedInit()
    }
    
    func sharedInit() {
        // Common logic goes here
        refreshCorners(value: cornerRadius)
    }
    
    func refreshCorners(value: CGFloat) {
        layer.cornerRadius = value
    }
    
    @IBInspectable var btnCornerRadius: CGFloat = 20 {
        didSet {
            refreshCorners(value: cornerRadius)
        }
    }
    
}
