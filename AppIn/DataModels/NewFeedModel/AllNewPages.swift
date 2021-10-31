//
//  AllNewPages.swift
//
//  Created by Sameer Khan on 06/05/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class AllNewPages: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kAllNewPagesBackgroundTypeKey: String = "backgroundType"
  private let kAllNewPagesIsActiveKey: String = "isActive"
  private let kAllNewPagesContentTypeKey: String = "contentType"
  private let kAllNewPagesUsersKey: String = "users"
  private let kAllNewPagesBrandIdKey: String = "brandId"
  private let kAllNewPagesIsPrivateKey: String = "isPrivate"
  private let kAllNewPagesModifiedDateKey: String = "modifiedDate"
  private let kAllNewPagesBackgroundSoundKey: String = "backgroundSound"
  private let kAllNewPagesActionButtonMetaKey: String = "actionButtonMeta"
  private let kAllNewPagesPositionKey: String = "position"
  private let kAllNewPagesUserGroupKey: String = "userGroup"
  private let kAllNewPagesContentKey: String = "content"
  private let kAllNewPagesTitleKey: String = "title"
  private let kAllNewPagesPageIdKey: String = "pageId"
  private let kAllNewPagesViewedCountKey: String = "viewedCount"
  private let kAllNewPagesStartDateKey: String = "startDate"
  private let kAllNewPagesBackgroundMetaKey: String = "backgroundMeta"
  private let kAllNewPagesSharedCountKey: String = "sharedCount"
  private let kAllNewPagesDisclaimerKey: String = "disclaimer"
  private let kAllNewPagesOver21Key: String = "over21"
  private let kAllNewPagesAddedDateKey: String = "addedDate"
  private let kAllNewPagesIsDeletedKey: String = "isDeleted"
  private let kAllNewPagesQrCodeKey: String = "qrCode"
  private let kAllNewPagesThirdPartyKey: String = "third_party"
  private let kAllNewPagesAutoShareKey: String = "autoShare"
  private let kAllNewPagesChannelIdKey: String = "channelId"

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
  public var userGroup: String?
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
  public var thirdParty: String?
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
    backgroundType = json[kAllNewPagesBackgroundTypeKey].string
    isActive = json[kAllNewPagesIsActiveKey].string
    contentType = json[kAllNewPagesContentTypeKey].string
    users = json[kAllNewPagesUsersKey].string
    brandId = json[kAllNewPagesBrandIdKey].string
    isPrivate = json[kAllNewPagesIsPrivateKey].string
    modifiedDate = json[kAllNewPagesModifiedDateKey].string
    backgroundSound = json[kAllNewPagesBackgroundSoundKey].string
    actionButtonMeta = json[kAllNewPagesActionButtonMetaKey].string
    position = json[kAllNewPagesPositionKey].string
    userGroup = json[kAllNewPagesUserGroupKey].string
    content = json[kAllNewPagesContentKey].string
    title = json[kAllNewPagesTitleKey].string
    pageId = json[kAllNewPagesPageIdKey].string
    viewedCount = json[kAllNewPagesViewedCountKey].string
    startDate = json[kAllNewPagesStartDateKey].string
    backgroundMeta = json[kAllNewPagesBackgroundMetaKey].string
    sharedCount = json[kAllNewPagesSharedCountKey].string
    disclaimer = json[kAllNewPagesDisclaimerKey].string
    over21 = json[kAllNewPagesOver21Key].string
    addedDate = json[kAllNewPagesAddedDateKey].string
    isDeleted = json[kAllNewPagesIsDeletedKey].string
    qrCode = json[kAllNewPagesQrCodeKey].string
    thirdParty = json[kAllNewPagesThirdPartyKey].string
    autoShare = json[kAllNewPagesAutoShareKey].string
    channelId = json[kAllNewPagesChannelIdKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = backgroundType { dictionary[kAllNewPagesBackgroundTypeKey] = value }
    if let value = isActive { dictionary[kAllNewPagesIsActiveKey] = value }
    if let value = contentType { dictionary[kAllNewPagesContentTypeKey] = value }
    if let value = users { dictionary[kAllNewPagesUsersKey] = value }
    if let value = brandId { dictionary[kAllNewPagesBrandIdKey] = value }
    if let value = isPrivate { dictionary[kAllNewPagesIsPrivateKey] = value }
    if let value = modifiedDate { dictionary[kAllNewPagesModifiedDateKey] = value }
    if let value = backgroundSound { dictionary[kAllNewPagesBackgroundSoundKey] = value }
    if let value = actionButtonMeta { dictionary[kAllNewPagesActionButtonMetaKey] = value }
    if let value = position { dictionary[kAllNewPagesPositionKey] = value }
    if let value = userGroup { dictionary[kAllNewPagesUserGroupKey] = value }
    if let value = content { dictionary[kAllNewPagesContentKey] = value }
    if let value = title { dictionary[kAllNewPagesTitleKey] = value }
    if let value = pageId { dictionary[kAllNewPagesPageIdKey] = value }
    if let value = viewedCount { dictionary[kAllNewPagesViewedCountKey] = value }
    if let value = startDate { dictionary[kAllNewPagesStartDateKey] = value }
    if let value = backgroundMeta { dictionary[kAllNewPagesBackgroundMetaKey] = value }
    if let value = sharedCount { dictionary[kAllNewPagesSharedCountKey] = value }
    if let value = disclaimer { dictionary[kAllNewPagesDisclaimerKey] = value }
    if let value = over21 { dictionary[kAllNewPagesOver21Key] = value }
    if let value = addedDate { dictionary[kAllNewPagesAddedDateKey] = value }
    if let value = isDeleted { dictionary[kAllNewPagesIsDeletedKey] = value }
    if let value = qrCode { dictionary[kAllNewPagesQrCodeKey] = value }
    if let value = thirdParty { dictionary[kAllNewPagesThirdPartyKey] = value }
    if let value = autoShare { dictionary[kAllNewPagesAutoShareKey] = value }
    if let value = channelId { dictionary[kAllNewPagesChannelIdKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.backgroundType = aDecoder.decodeObject(forKey: kAllNewPagesBackgroundTypeKey) as? String
    self.isActive = aDecoder.decodeObject(forKey: kAllNewPagesIsActiveKey) as? String
    self.contentType = aDecoder.decodeObject(forKey: kAllNewPagesContentTypeKey) as? String
    self.users = aDecoder.decodeObject(forKey: kAllNewPagesUsersKey) as? String
    self.brandId = aDecoder.decodeObject(forKey: kAllNewPagesBrandIdKey) as? String
    self.isPrivate = aDecoder.decodeObject(forKey: kAllNewPagesIsPrivateKey) as? String
    self.modifiedDate = aDecoder.decodeObject(forKey: kAllNewPagesModifiedDateKey) as? String
    self.backgroundSound = aDecoder.decodeObject(forKey: kAllNewPagesBackgroundSoundKey) as? String
    self.actionButtonMeta = aDecoder.decodeObject(forKey: kAllNewPagesActionButtonMetaKey) as? String
    self.position = aDecoder.decodeObject(forKey: kAllNewPagesPositionKey) as? String
    self.userGroup = aDecoder.decodeObject(forKey: kAllNewPagesUserGroupKey) as? String
    self.content = aDecoder.decodeObject(forKey: kAllNewPagesContentKey) as? String
    self.title = aDecoder.decodeObject(forKey: kAllNewPagesTitleKey) as? String
    self.pageId = aDecoder.decodeObject(forKey: kAllNewPagesPageIdKey) as? String
    self.viewedCount = aDecoder.decodeObject(forKey: kAllNewPagesViewedCountKey) as? String
    self.startDate = aDecoder.decodeObject(forKey: kAllNewPagesStartDateKey) as? String
    self.backgroundMeta = aDecoder.decodeObject(forKey: kAllNewPagesBackgroundMetaKey) as? String
    self.sharedCount = aDecoder.decodeObject(forKey: kAllNewPagesSharedCountKey) as? String
    self.disclaimer = aDecoder.decodeObject(forKey: kAllNewPagesDisclaimerKey) as? String
    self.over21 = aDecoder.decodeObject(forKey: kAllNewPagesOver21Key) as? String
    self.addedDate = aDecoder.decodeObject(forKey: kAllNewPagesAddedDateKey) as? String
    self.isDeleted = aDecoder.decodeObject(forKey: kAllNewPagesIsDeletedKey) as? String
    self.qrCode = aDecoder.decodeObject(forKey: kAllNewPagesQrCodeKey) as? String
    self.thirdParty = aDecoder.decodeObject(forKey: kAllNewPagesThirdPartyKey) as? String
    self.autoShare = aDecoder.decodeObject(forKey: kAllNewPagesAutoShareKey) as? String
    self.channelId = aDecoder.decodeObject(forKey: kAllNewPagesChannelIdKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(backgroundType, forKey: kAllNewPagesBackgroundTypeKey)
    aCoder.encode(isActive, forKey: kAllNewPagesIsActiveKey)
    aCoder.encode(contentType, forKey: kAllNewPagesContentTypeKey)
    aCoder.encode(users, forKey: kAllNewPagesUsersKey)
    aCoder.encode(brandId, forKey: kAllNewPagesBrandIdKey)
    aCoder.encode(isPrivate, forKey: kAllNewPagesIsPrivateKey)
    aCoder.encode(modifiedDate, forKey: kAllNewPagesModifiedDateKey)
    aCoder.encode(backgroundSound, forKey: kAllNewPagesBackgroundSoundKey)
    aCoder.encode(actionButtonMeta, forKey: kAllNewPagesActionButtonMetaKey)
    aCoder.encode(position, forKey: kAllNewPagesPositionKey)
    aCoder.encode(userGroup, forKey: kAllNewPagesUserGroupKey)
    aCoder.encode(content, forKey: kAllNewPagesContentKey)
    aCoder.encode(title, forKey: kAllNewPagesTitleKey)
    aCoder.encode(pageId, forKey: kAllNewPagesPageIdKey)
    aCoder.encode(viewedCount, forKey: kAllNewPagesViewedCountKey)
    aCoder.encode(startDate, forKey: kAllNewPagesStartDateKey)
    aCoder.encode(backgroundMeta, forKey: kAllNewPagesBackgroundMetaKey)
    aCoder.encode(sharedCount, forKey: kAllNewPagesSharedCountKey)
    aCoder.encode(disclaimer, forKey: kAllNewPagesDisclaimerKey)
    aCoder.encode(over21, forKey: kAllNewPagesOver21Key)
    aCoder.encode(addedDate, forKey: kAllNewPagesAddedDateKey)
    aCoder.encode(isDeleted, forKey: kAllNewPagesIsDeletedKey)
    aCoder.encode(qrCode, forKey: kAllNewPagesQrCodeKey)
    aCoder.encode(thirdParty, forKey: kAllNewPagesThirdPartyKey)
    aCoder.encode(autoShare, forKey: kAllNewPagesAutoShareKey)
    aCoder.encode(channelId, forKey: kAllNewPagesChannelIdKey)
  }

}
