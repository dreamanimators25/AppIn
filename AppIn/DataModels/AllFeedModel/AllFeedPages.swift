//
//  AllFeedPages.swift
//
//  Created by sameer khan on 31/12/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class AllFeedPages: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kAllFeedPagesBackgroundTypeKey: String = "backgroundType"
  private let kAllFeedPagesIsActiveKey: String = "isActive"
  private let kAllFeedPagesContentTypeKey: String = "contentType"
  private let kAllFeedPagesUsersKey: String = "users"
  private let kAllFeedPagesBrandIdKey: String = "brandId"
  private let kAllFeedPagesIsPrivateKey: String = "isPrivate"
  private let kAllFeedPagesModifiedDateKey: String = "modifiedDate"
  private let kAllFeedPagesBackgroundSoundKey: String = "backgroundSound"
  private let kAllFeedPagesActionButtonMetaKey: String = "actionButtonMeta"
  private let kAllFeedPagesPositionKey: String = "position"
  private let kAllFeedPagesContentKey: String = "content"
  private let kAllFeedPagesTitleKey: String = "title"
  private let kAllFeedPagesPageIdKey: String = "pageId"
  private let kAllFeedPagesViewedCountKey: String = "viewedCount"
  private let kAllFeedPagesStartDateKey: String = "startDate"
  private let kAllFeedPagesBackgroundMetaKey: String = "backgroundMeta"
  private let kAllFeedPagesSharedCountKey: String = "sharedCount"
  private let kAllFeedPagesDisclaimerKey: String = "disclaimer"
  private let kAllFeedPagesOver21Key: String = "over21"
  private let kAllFeedPagesAddedDateKey: String = "addedDate"
  private let kAllFeedPagesIsDeletedKey: String = "isDeleted"
  private let kAllFeedPagesQrCodeKey: String = "qrCode"
  private let kAllFeedPagesEndDateKey: String = "endDate"
  private let kAllFeedPagesAutoShareKey: String = "autoShare"
  private let kAllFeedPagesChannelIdKey: String = "channelId"

  // MARK: Properties
  public var backgroundType: String?
  public var isActive: String?
  public var contentType: String?
  public var users: String?
  public var brandId: String?
  public var isPrivate: String?
  public var modifiedDate: String?
  public var backgroundSound: String?
  public var actionButtonMeta: String?
  public var position: String?
  public var content: String?
  public var title: String?
  public var pageId: String?
  public var viewedCount: String?
  public var startDate: String?
  public var backgroundMeta: String?
  public var sharedCount: String?
  public var disclaimer: String?
  public var over21: String?
  public var addedDate: String?
  public var isDeleted: String?
  public var qrCode: String?
  public var endDate: String?
  public var autoShare: String?
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
    backgroundType = json[kAllFeedPagesBackgroundTypeKey].string
    isActive = json[kAllFeedPagesIsActiveKey].string
    contentType = json[kAllFeedPagesContentTypeKey].string
    users = json[kAllFeedPagesUsersKey].string
    brandId = json[kAllFeedPagesBrandIdKey].string
    isPrivate = json[kAllFeedPagesIsPrivateKey].string
    modifiedDate = json[kAllFeedPagesModifiedDateKey].string
    backgroundSound = json[kAllFeedPagesBackgroundSoundKey].string
    actionButtonMeta = json[kAllFeedPagesActionButtonMetaKey].string
    position = json[kAllFeedPagesPositionKey].string
    content = json[kAllFeedPagesContentKey].string
    title = json[kAllFeedPagesTitleKey].string
    pageId = json[kAllFeedPagesPageIdKey].string
    viewedCount = json[kAllFeedPagesViewedCountKey].string
    startDate = json[kAllFeedPagesStartDateKey].string
    backgroundMeta = json[kAllFeedPagesBackgroundMetaKey].string
    sharedCount = json[kAllFeedPagesSharedCountKey].string
    disclaimer = json[kAllFeedPagesDisclaimerKey].string
    over21 = json[kAllFeedPagesOver21Key].string
    addedDate = json[kAllFeedPagesAddedDateKey].string
    isDeleted = json[kAllFeedPagesIsDeletedKey].string
    qrCode = json[kAllFeedPagesQrCodeKey].string
    endDate = json[kAllFeedPagesEndDateKey].string
    autoShare = json[kAllFeedPagesAutoShareKey].string
    channelId = json[kAllFeedPagesChannelIdKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = backgroundType { dictionary[kAllFeedPagesBackgroundTypeKey] = value }
    if let value = isActive { dictionary[kAllFeedPagesIsActiveKey] = value }
    if let value = contentType { dictionary[kAllFeedPagesContentTypeKey] = value }
    if let value = users { dictionary[kAllFeedPagesUsersKey] = value }
    if let value = brandId { dictionary[kAllFeedPagesBrandIdKey] = value }
    if let value = isPrivate { dictionary[kAllFeedPagesIsPrivateKey] = value }
    if let value = modifiedDate { dictionary[kAllFeedPagesModifiedDateKey] = value }
    if let value = backgroundSound { dictionary[kAllFeedPagesBackgroundSoundKey] = value }
    if let value = actionButtonMeta { dictionary[kAllFeedPagesActionButtonMetaKey] = value }
    if let value = position { dictionary[kAllFeedPagesPositionKey] = value }
    if let value = content { dictionary[kAllFeedPagesContentKey] = value }
    if let value = title { dictionary[kAllFeedPagesTitleKey] = value }
    if let value = pageId { dictionary[kAllFeedPagesPageIdKey] = value }
    if let value = viewedCount { dictionary[kAllFeedPagesViewedCountKey] = value }
    if let value = startDate { dictionary[kAllFeedPagesStartDateKey] = value }
    if let value = backgroundMeta { dictionary[kAllFeedPagesBackgroundMetaKey] = value }
    if let value = sharedCount { dictionary[kAllFeedPagesSharedCountKey] = value }
    if let value = disclaimer { dictionary[kAllFeedPagesDisclaimerKey] = value }
    if let value = over21 { dictionary[kAllFeedPagesOver21Key] = value }
    if let value = addedDate { dictionary[kAllFeedPagesAddedDateKey] = value }
    if let value = isDeleted { dictionary[kAllFeedPagesIsDeletedKey] = value }
    if let value = qrCode { dictionary[kAllFeedPagesQrCodeKey] = value }
    if let value = endDate { dictionary[kAllFeedPagesEndDateKey] = value }
    if let value = autoShare { dictionary[kAllFeedPagesAutoShareKey] = value }
    if let value = channelId { dictionary[kAllFeedPagesChannelIdKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.backgroundType = aDecoder.decodeObject(forKey: kAllFeedPagesBackgroundTypeKey) as? String
    self.isActive = aDecoder.decodeObject(forKey: kAllFeedPagesIsActiveKey) as? String
    self.contentType = aDecoder.decodeObject(forKey: kAllFeedPagesContentTypeKey) as? String
    self.users = aDecoder.decodeObject(forKey: kAllFeedPagesUsersKey) as? String
    self.brandId = aDecoder.decodeObject(forKey: kAllFeedPagesBrandIdKey) as? String
    self.isPrivate = aDecoder.decodeObject(forKey: kAllFeedPagesIsPrivateKey) as? String
    self.modifiedDate = aDecoder.decodeObject(forKey: kAllFeedPagesModifiedDateKey) as? String
    self.backgroundSound = aDecoder.decodeObject(forKey: kAllFeedPagesBackgroundSoundKey) as? String
    self.actionButtonMeta = aDecoder.decodeObject(forKey: kAllFeedPagesActionButtonMetaKey) as? String
    self.position = aDecoder.decodeObject(forKey: kAllFeedPagesPositionKey) as? String
    self.content = aDecoder.decodeObject(forKey: kAllFeedPagesContentKey) as? String
    self.title = aDecoder.decodeObject(forKey: kAllFeedPagesTitleKey) as? String
    self.pageId = aDecoder.decodeObject(forKey: kAllFeedPagesPageIdKey) as? String
    self.viewedCount = aDecoder.decodeObject(forKey: kAllFeedPagesViewedCountKey) as? String
    self.startDate = aDecoder.decodeObject(forKey: kAllFeedPagesStartDateKey) as? String
    self.backgroundMeta = aDecoder.decodeObject(forKey: kAllFeedPagesBackgroundMetaKey) as? String
    self.sharedCount = aDecoder.decodeObject(forKey: kAllFeedPagesSharedCountKey) as? String
    self.disclaimer = aDecoder.decodeObject(forKey: kAllFeedPagesDisclaimerKey) as? String
    self.over21 = aDecoder.decodeObject(forKey: kAllFeedPagesOver21Key) as? String
    self.addedDate = aDecoder.decodeObject(forKey: kAllFeedPagesAddedDateKey) as? String
    self.isDeleted = aDecoder.decodeObject(forKey: kAllFeedPagesIsDeletedKey) as? String
    self.qrCode = aDecoder.decodeObject(forKey: kAllFeedPagesQrCodeKey) as? String
    self.endDate = aDecoder.decodeObject(forKey: kAllFeedPagesEndDateKey) as? String
    self.autoShare = aDecoder.decodeObject(forKey: kAllFeedPagesAutoShareKey) as? String
    self.channelId = aDecoder.decodeObject(forKey: kAllFeedPagesChannelIdKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(backgroundType, forKey: kAllFeedPagesBackgroundTypeKey)
    aCoder.encode(isActive, forKey: kAllFeedPagesIsActiveKey)
    aCoder.encode(contentType, forKey: kAllFeedPagesContentTypeKey)
    aCoder.encode(users, forKey: kAllFeedPagesUsersKey)
    aCoder.encode(brandId, forKey: kAllFeedPagesBrandIdKey)
    aCoder.encode(isPrivate, forKey: kAllFeedPagesIsPrivateKey)
    aCoder.encode(modifiedDate, forKey: kAllFeedPagesModifiedDateKey)
    aCoder.encode(backgroundSound, forKey: kAllFeedPagesBackgroundSoundKey)
    aCoder.encode(actionButtonMeta, forKey: kAllFeedPagesActionButtonMetaKey)
    aCoder.encode(position, forKey: kAllFeedPagesPositionKey)
    aCoder.encode(content, forKey: kAllFeedPagesContentKey)
    aCoder.encode(title, forKey: kAllFeedPagesTitleKey)
    aCoder.encode(pageId, forKey: kAllFeedPagesPageIdKey)
    aCoder.encode(viewedCount, forKey: kAllFeedPagesViewedCountKey)
    aCoder.encode(startDate, forKey: kAllFeedPagesStartDateKey)
    aCoder.encode(backgroundMeta, forKey: kAllFeedPagesBackgroundMetaKey)
    aCoder.encode(sharedCount, forKey: kAllFeedPagesSharedCountKey)
    aCoder.encode(disclaimer, forKey: kAllFeedPagesDisclaimerKey)
    aCoder.encode(over21, forKey: kAllFeedPagesOver21Key)
    aCoder.encode(addedDate, forKey: kAllFeedPagesAddedDateKey)
    aCoder.encode(isDeleted, forKey: kAllFeedPagesIsDeletedKey)
    aCoder.encode(qrCode, forKey: kAllFeedPagesQrCodeKey)
    aCoder.encode(endDate, forKey: kAllFeedPagesEndDateKey)
    aCoder.encode(autoShare, forKey: kAllFeedPagesAutoShareKey)
    aCoder.encode(channelId, forKey: kAllFeedPagesChannelIdKey)
  }

}
