//
//  ContentPageBackground.swift
//  iList Ambassador
//
//  Created by Pontus Andersson on 21/04/16.
//  Copyright © 2016 iList AB. All rights reserved.
//

import Foundation
import AVFoundation
import UIKit

private let kAPIKeyId = "id"
private let kAPIKeyType = "type"
private let kAPIKeyFile = "file"
private let kAPIKeyFileURL = "file_url"
private let kAPIKeyMeta = "meta"
private let kAPIKeyContentPage = "content_page"
private let kAPIKeyCreated = "created"
private let kAPIKeyUpdated = "updated"
private let kAPIKeyOrder = "order"

//Consume Action
private let kAPIKeyCABackgroundBox = "background_box"
private let kAPIKeyCABoxColor = "box_color"
private let kAPIKeyCAColor = "color"
private let kAPIKeyCAFontSize = "font_size"
private let kAPIKeyCAOpacity = "opacity"
private let kAPIKeyCARoundedBox = "rounded_box"
private let kAPIKeyCAText = "text"
private let kAPIKeyCATextAlign = "text_align"


open class ContentPageBackground {
    
    var id: Int = 0
    var type: ContentPageBackgroundType
    var file_url: String?
    var file: String?
    var meta: [String:Any]?
    var contentPage: Int = 0
    var order: Int = 0
    
    var created: Date?
    var updated: Date?
    var video: AVPlayerItem?
    var videoThumb: UIImage?
    
    init(dictionary: [String:Any]) {
        if let id = dictionary[kAPIKeyId] as? Int {
            self.id = id
        }
        //print("typessss = \(dictionary[kAPIKeyType])")
        self.type = ContentPageBackgroundType(rawValue: dictionary[kAPIKeyType] as! String)!
        
//        print("type huy = \(type), \(dictionary[kAPIKeyFile]), \(dictionary[kAPIKeyFileURL])")
//
        if let fileurl = dictionary[kAPIKeyFileURL] as? String {
            self.file_url = fileurl
            if self.type == .Video {
                let item = AVPlayerItem(url: URL(string: fileurl)!)
                let player = Player(playerItem: item)
                player.isMuted = true
                MPCacher.sharedInstance.setObjectForKey(player, key: fileurl)
            } else {
                self.file_url = fileurl
            }
        }
        
        if let file = dictionary[kAPIKeyFile] as? String {
            self.file = file
            if self.type == .Video {
                let item = AVPlayerItem(url: URL(string: file)!)
                let player = Player(playerItem: item)
                player.isMuted = true
                MPCacher.sharedInstance.setObjectForKey(player, key: file)
            } else {
                self.file = file
            }
            
        }
        if let meta = dictionary[kAPIKeyMeta] as? [String:Any] {
            self.meta = meta
        }
        if let contentPage = dictionary[kAPIKeyContentPage] as? Int {
            self.contentPage = contentPage
        }
        if let order = dictionary[kAPIKeyOrder] as? Int {
            self.order = order
        }
        if let createdString = dictionary[kAPIKeyCreated] as? String, let createdDate = NSDate(string: createdString, formatString: APIDefinitions.FullDateFormat) {
            created = createdDate as Date
        }
        if let updatedString = dictionary[kAPIKeyUpdated] as? String, let updatedDate = NSDate(string: updatedString, formatString: APIDefinitions.FullDateFormat) {
            updated = updatedDate as Date
        }
    }
}

open class ConsumeActionComponents {
    
    var backGroundBox : String?
    var boxColor : String?
    var roundedBox : String?
    var color : String?
    var text : String?
    var textAlign : String?
    var opacity : String?
    var fontSize : String?    
    
    init(dictionary: [String:Any]) {
        if let backBox = dictionary[kAPIKeyCABackgroundBox] as? String {
            self.backGroundBox = backBox
        }
        
        if let boccolor = dictionary[kAPIKeyCABoxColor] as? String {
            self.boxColor = boccolor
        }
        
        if let col = dictionary[kAPIKeyCAColor] as? String {
            self.color = col
        }
        
        if let roundBoc = dictionary[kAPIKeyCARoundedBox] as? String {
            self.roundedBox = roundBoc
        }
        
        if let txt = dictionary[kAPIKeyCAText] as? String {
            self.text = txt
        }
        
        if let txtAlign = dictionary[kAPIKeyCATextAlign] as? String {
            self.textAlign = txtAlign
        }
        
        if let opct = dictionary[kAPIKeyCAOpacity] as? String {
            self.opacity = opct
        }
        
        if let fntSize = dictionary[kAPIKeyCAFontSize] as? String {
            self.fontSize = fntSize
        }
        
    }

}
