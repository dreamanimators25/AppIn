//
//  AllNewData.swift
//
//  Created by Sameer Khan on 06/05/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class AllNewData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kAllNewDataNameKey: String = "name"
  private let kAllNewDataChannelsKey: String = "channels"
  private let kAllNewDataBrandIdKey: String = "brandId"
  private let kAllNewDataUserIdKey: String = "userId"
  private let kAllNewDataLogoKey: String = "logo"
  private let kAllNewDataOver21Key: String = "over21"
  private let kAllNewDataChannelIdsKey: String = "channelIds"

  // MARK: Properties
  public var name: String?
  public var channels: [AllNewChannels]?
  public var brandId: String?
  public var userId: String?
  public var logo: String?
  public var over21: String?
  public var channelIds: String?

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
    name = json[kAllNewDataNameKey].string
    if let items = json[kAllNewDataChannelsKey].array { channels = items.map { AllNewChannels(json: $0) } }
    brandId = json[kAllNewDataBrandIdKey].string
    userId = json[kAllNewDataUserIdKey].string
    logo = json[kAllNewDataLogoKey].string
    over21 = json[kAllNewDataOver21Key].string
    channelIds = json[kAllNewDataChannelIdsKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[kAllNewDataNameKey] = value }
    if let value = channels { dictionary[kAllNewDataChannelsKey] = value.map { $0.dictionaryRepresentation() } }
    if let value = brandId { dictionary[kAllNewDataBrandIdKey] = value }
    if let value = userId { dictionary[kAllNewDataUserIdKey] = value }
    if let value = logo { dictionary[kAllNewDataLogoKey] = value }
    if let value = over21 { dictionary[kAllNewDataOver21Key] = value }
    if let value = channelIds { dictionary[kAllNewDataChannelIdsKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: kAllNewDataNameKey) as? String
    self.channels = aDecoder.decodeObject(forKey: kAllNewDataChannelsKey) as? [AllNewChannels]
    self.brandId = aDecoder.decodeObject(forKey: kAllNewDataBrandIdKey) as? String
    self.userId = aDecoder.decodeObject(forKey: kAllNewDataUserIdKey) as? String
    self.logo = aDecoder.decodeObject(forKey: kAllNewDataLogoKey) as? String
    self.over21 = aDecoder.decodeObject(forKey: kAllNewDataOver21Key) as? String
    self.channelIds = aDecoder.decodeObject(forKey: kAllNewDataChannelIdsKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: kAllNewDataNameKey)
    aCoder.encode(channels, forKey: kAllNewDataChannelsKey)
    aCoder.encode(brandId, forKey: kAllNewDataBrandIdKey)
    aCoder.encode(userId, forKey: kAllNewDataUserIdKey)
    aCoder.encode(logo, forKey: kAllNewDataLogoKey)
    aCoder.encode(over21, forKey: kAllNewDataOver21Key)
    aCoder.encode(channelIds, forKey: kAllNewDataChannelIdsKey)
  }

}
