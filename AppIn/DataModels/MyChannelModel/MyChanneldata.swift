//
//  MyChanneldata.swift
//
//  Created by Sameer Khan on 18/05/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class MyChanneldata: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kMyChanneldataChannelNameKey: String = "channelName"
  private let kMyChanneldataSendPushKey: String = "sendPush"
  private let kMyChanneldataBrandLogoKey: String = "brandLogo"
  private let kMyChanneldataBrandIdKey: String = "brandId"
  private let kMyChanneldataUserIdKey: String = "userId"
  private let kMyChanneldataBrandNameKey: String = "brandName"
  private let kMyChanneldataLogoKey: String = "logo"
  private let kMyChanneldataShortCodeKey: String = "shortCode"
  private let kMyChanneldataChannelIdKey: String = "channelId"

  // MARK: Properties
  public var channelName: String?
  public var sendPush: String?
  public var brandLogo: String?
  public var brandId: String?
  public var userId: String?
  public var brandName: String?
  public var logo: String?
  public var shortCode: String?
  public var channelId: String?

  // MARK: SwiftyJSON Initalizers
  /**
   Initates the instance based on the object
   - parameter object: The object of either Dictionary or Array kind that was passed.
   - returns: An initalized instance of the class.
  */
  convenience public init(object: Any) {
    self.init(json: JSON(object))
  }

  /**
   Initates the instance based on the JSON that was passed.
   - parameter json: JSON object from SwiftyJSON.
   - returns: An initalized instance of the class.
  */
  public init(json: JSON) {
    channelName = json[kMyChanneldataChannelNameKey].string
    sendPush = json[kMyChanneldataSendPushKey].string
    brandLogo = json[kMyChanneldataBrandLogoKey].string
    brandId = json[kMyChanneldataBrandIdKey].string
    userId = json[kMyChanneldataUserIdKey].string
    brandName = json[kMyChanneldataBrandNameKey].string
    logo = json[kMyChanneldataLogoKey].string
    shortCode = json[kMyChanneldataShortCodeKey].string
    channelId = json[kMyChanneldataChannelIdKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = channelName { dictionary[kMyChanneldataChannelNameKey] = value }
    if let value = sendPush { dictionary[kMyChanneldataSendPushKey] = value }
    if let value = brandLogo { dictionary[kMyChanneldataBrandLogoKey] = value }
    if let value = brandId { dictionary[kMyChanneldataBrandIdKey] = value }
    if let value = userId { dictionary[kMyChanneldataUserIdKey] = value }
    if let value = brandName { dictionary[kMyChanneldataBrandNameKey] = value }
    if let value = logo { dictionary[kMyChanneldataLogoKey] = value }
    if let value = shortCode { dictionary[kMyChanneldataShortCodeKey] = value }
    if let value = channelId { dictionary[kMyChanneldataChannelIdKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.channelName = aDecoder.decodeObject(forKey: kMyChanneldataChannelNameKey) as? String
    self.sendPush = aDecoder.decodeObject(forKey: kMyChanneldataSendPushKey) as? String
    self.brandLogo = aDecoder.decodeObject(forKey: kMyChanneldataBrandLogoKey) as? String
    self.brandId = aDecoder.decodeObject(forKey: kMyChanneldataBrandIdKey) as? String
    self.userId = aDecoder.decodeObject(forKey: kMyChanneldataUserIdKey) as? String
    self.brandName = aDecoder.decodeObject(forKey: kMyChanneldataBrandNameKey) as? String
    self.logo = aDecoder.decodeObject(forKey: kMyChanneldataLogoKey) as? String
    self.shortCode = aDecoder.decodeObject(forKey: kMyChanneldataShortCodeKey) as? String
    self.channelId = aDecoder.decodeObject(forKey: kMyChanneldataChannelIdKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(channelName, forKey: kMyChanneldataChannelNameKey)
    aCoder.encode(sendPush, forKey: kMyChanneldataSendPushKey)
    aCoder.encode(brandLogo, forKey: kMyChanneldataBrandLogoKey)
    aCoder.encode(brandId, forKey: kMyChanneldataBrandIdKey)
    aCoder.encode(userId, forKey: kMyChanneldataUserIdKey)
    aCoder.encode(brandName, forKey: kMyChanneldataBrandNameKey)
    aCoder.encode(logo, forKey: kMyChanneldataLogoKey)
    aCoder.encode(shortCode, forKey: kMyChanneldataShortCodeKey)
    aCoder.encode(channelId, forKey: kMyChanneldataChannelIdKey)
  }

}
