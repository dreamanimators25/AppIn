//
//  AllNotificationData.swift
//
//  Created by sameer khan on 30/12/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class AllNotificationData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kAllNotificationDataAddedDateKey: String = "addedDate"
  private let kAllNotificationDataValueKey: String = "value"
  private let kAllNotificationDataIsDeletedKey: String = "isDeleted"
  private let kAllNotificationDataInternalIdentifierKey: String = "id"
  private let kAllNotificationDataBrandIdKey: String = "brandId"
  private let kAllNotificationDataIsReadKey: String = "isRead"
  private let kAllNotificationDataUserIdKey: String = "userId"
  private let kAllNotificationDataModifiedDateKey: String = "modifiedDate"
  private let kAllNotificationDataTitleKey: String = "title"
  private let kAllNotificationDataTypeKey: String = "type"
  private let kAllNotificationDataChannelIdKey: String = "channelId"

  // MARK: Properties
  public var addedDate: String?
  public var value: String?
  public var isDeleted: String?
  public var internalIdentifier: String?
  public var brandId: String?
  public var isRead: String?
  public var userId: String?
  public var modifiedDate: String?
  public var title: String?
  public var type: String?
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
    addedDate = json[kAllNotificationDataAddedDateKey].string
    value = json[kAllNotificationDataValueKey].string
    isDeleted = json[kAllNotificationDataIsDeletedKey].string
    internalIdentifier = json[kAllNotificationDataInternalIdentifierKey].string
    brandId = json[kAllNotificationDataBrandIdKey].string
    isRead = json[kAllNotificationDataIsReadKey].string
    userId = json[kAllNotificationDataUserIdKey].string
    modifiedDate = json[kAllNotificationDataModifiedDateKey].string
    title = json[kAllNotificationDataTitleKey].string
    type = json[kAllNotificationDataTypeKey].string
    channelId = json[kAllNotificationDataChannelIdKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = addedDate { dictionary[kAllNotificationDataAddedDateKey] = value }
    if let value = value { dictionary[kAllNotificationDataValueKey] = value }
    if let value = isDeleted { dictionary[kAllNotificationDataIsDeletedKey] = value }
    if let value = internalIdentifier { dictionary[kAllNotificationDataInternalIdentifierKey] = value }
    if let value = brandId { dictionary[kAllNotificationDataBrandIdKey] = value }
    if let value = isRead { dictionary[kAllNotificationDataIsReadKey] = value }
    if let value = userId { dictionary[kAllNotificationDataUserIdKey] = value }
    if let value = modifiedDate { dictionary[kAllNotificationDataModifiedDateKey] = value }
    if let value = title { dictionary[kAllNotificationDataTitleKey] = value }
    if let value = type { dictionary[kAllNotificationDataTypeKey] = value }
    if let value = channelId { dictionary[kAllNotificationDataChannelIdKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.addedDate = aDecoder.decodeObject(forKey: kAllNotificationDataAddedDateKey) as? String
    self.value = aDecoder.decodeObject(forKey: kAllNotificationDataValueKey) as? String
    self.isDeleted = aDecoder.decodeObject(forKey: kAllNotificationDataIsDeletedKey) as? String
    self.internalIdentifier = aDecoder.decodeObject(forKey: kAllNotificationDataInternalIdentifierKey) as? String
    self.brandId = aDecoder.decodeObject(forKey: kAllNotificationDataBrandIdKey) as? String
    self.isRead = aDecoder.decodeObject(forKey: kAllNotificationDataIsReadKey) as? String
    self.userId = aDecoder.decodeObject(forKey: kAllNotificationDataUserIdKey) as? String
    self.modifiedDate = aDecoder.decodeObject(forKey: kAllNotificationDataModifiedDateKey) as? String
    self.title = aDecoder.decodeObject(forKey: kAllNotificationDataTitleKey) as? String
    self.type = aDecoder.decodeObject(forKey: kAllNotificationDataTypeKey) as? String
    self.channelId = aDecoder.decodeObject(forKey: kAllNotificationDataChannelIdKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(addedDate, forKey: kAllNotificationDataAddedDateKey)
    aCoder.encode(value, forKey: kAllNotificationDataValueKey)
    aCoder.encode(isDeleted, forKey: kAllNotificationDataIsDeletedKey)
    aCoder.encode(internalIdentifier, forKey: kAllNotificationDataInternalIdentifierKey)
    aCoder.encode(brandId, forKey: kAllNotificationDataBrandIdKey)
    aCoder.encode(isRead, forKey: kAllNotificationDataIsReadKey)
    aCoder.encode(userId, forKey: kAllNotificationDataUserIdKey)
    aCoder.encode(modifiedDate, forKey: kAllNotificationDataModifiedDateKey)
    aCoder.encode(title, forKey: kAllNotificationDataTitleKey)
    aCoder.encode(type, forKey: kAllNotificationDataTypeKey)
    aCoder.encode(channelId, forKey: kAllNotificationDataChannelIdKey)
  }

}
