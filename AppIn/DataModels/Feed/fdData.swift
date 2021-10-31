//
//  Data.swift
//
//  Created by Sameer Khan on 07/10/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class fdData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kDataChannelNameKey: String = "channelName"
  private let kDataSendPushKey: String = "sendPush"
  private let kDataBrandLogoKey: String = "brandLogo"
  private let kDataBrandIdKey: String = "brandId"
  private let kDataUserIdKey: String = "userId"
  private let kDataLogoKey: String = "logo"
  private let kDataShortCodeKey: String = "shortCode"
  private let kDataPriorityKey: String = "priority"
  private let kDataChannelIdKey: String = "channelId"
  private let kDataBrandNameKey: String = "brandName"

  // MARK: Properties
  public var channelName: String?
  public var sendPush: String?
  public var brandLogo: String?
  public var brandId: String?
  public var userId: String?
  public var logo: String?
  public var shortCode: String?
  public var priority: String?
  public var channelId: String?
  public var brandName: String?

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
    channelName = json[kDataChannelNameKey].string
    sendPush = json[kDataSendPushKey].string
    brandLogo = json[kDataBrandLogoKey].string
    brandId = json[kDataBrandIdKey].string
    userId = json[kDataUserIdKey].string
    logo = json[kDataLogoKey].string
    shortCode = json[kDataShortCodeKey].string
    priority = json[kDataPriorityKey].string
    channelId = json[kDataChannelIdKey].string
    brandName = json[kDataBrandNameKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = channelName { dictionary[kDataChannelNameKey] = value }
    if let value = sendPush { dictionary[kDataSendPushKey] = value }
    if let value = brandLogo { dictionary[kDataBrandLogoKey] = value }
    if let value = brandId { dictionary[kDataBrandIdKey] = value }
    if let value = userId { dictionary[kDataUserIdKey] = value }
    if let value = logo { dictionary[kDataLogoKey] = value }
    if let value = shortCode { dictionary[kDataShortCodeKey] = value }
    if let value = priority { dictionary[kDataPriorityKey] = value }
    if let value = channelId { dictionary[kDataChannelIdKey] = value }
    if let value = brandName { dictionary[kDataBrandNameKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.channelName = aDecoder.decodeObject(forKey: kDataChannelNameKey) as? String
    self.sendPush = aDecoder.decodeObject(forKey: kDataSendPushKey) as? String
    self.brandLogo = aDecoder.decodeObject(forKey: kDataBrandLogoKey) as? String
    self.brandId = aDecoder.decodeObject(forKey: kDataBrandIdKey) as? String
    self.userId = aDecoder.decodeObject(forKey: kDataUserIdKey) as? String
    self.logo = aDecoder.decodeObject(forKey: kDataLogoKey) as? String
    self.shortCode = aDecoder.decodeObject(forKey: kDataShortCodeKey) as? String
    self.priority = aDecoder.decodeObject(forKey: kDataPriorityKey) as? String
    self.channelId = aDecoder.decodeObject(forKey: kDataChannelIdKey) as? String
    self.brandName = aDecoder.decodeObject(forKey: kDataBrandNameKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(channelName, forKey: kDataChannelNameKey)
    aCoder.encode(sendPush, forKey: kDataSendPushKey)
    aCoder.encode(brandLogo, forKey: kDataBrandLogoKey)
    aCoder.encode(brandId, forKey: kDataBrandIdKey)
    aCoder.encode(userId, forKey: kDataUserIdKey)
    aCoder.encode(logo, forKey: kDataLogoKey)
    aCoder.encode(shortCode, forKey: kDataShortCodeKey)
    aCoder.encode(priority, forKey: kDataPriorityKey)
    aCoder.encode(channelId, forKey: kDataChannelIdKey)
    aCoder.encode(brandName, forKey: kDataBrandNameKey)
  }

}
