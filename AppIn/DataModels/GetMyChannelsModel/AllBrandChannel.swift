//
//  AllBrandChannel.swift
//
//  Created by sameer khan on 30/12/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class AllBrandChannel: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kAllBrandChannelIsActiveKey: String = "isActive"
  private let kAllBrandChannelNameKey: String = "name"
  private let kAllBrandChannelBrandIdKey: String = "brandId"
  private let kAllBrandChannelCreatedDateKey: String = "createdDate"
  private let kAllBrandChannelDescriptionValueKey: String = "description"
  private let kAllBrandChannelDisclaimerKey: String = "disclaimer"
  private let kAllBrandChannelUserIdKey: String = "userId"
  private let kAllBrandChannelModifiedDateKey: String = "modifiedDate"
  private let kAllBrandChannelOver21Key: String = "over21"
  private let kAllBrandChannelCategoryKey: String = "category"
  private let kAllBrandChannelPriorityKey: String = "priority"
  private let kAllBrandChannelColorKey: String = "color"
  private let kAllBrandChannelLatitudeKey: String = "latitude"
  private let kAllBrandChannelIsDefaultKey: String = "isDefault"
  private let kAllBrandChannelIsDeletedKey: String = "isDeleted"
  private let kAllBrandChannelInternalIdentifierKey: String = "id"
  private let kAllBrandChannelQrCodeKey: String = "qrCode"
  private let kAllBrandChannelIsPublicKey: String = "isPublic"
  private let kAllBrandChannelAmbaNeedApprovalKey: String = "ambaNeedApproval"
  private let kAllBrandChannelShortCodeKey: String = "shortCode"
  private let kAllBrandChannelLongitudeKey: String = "longitude"
  private let kAllBrandChannelIsFeaturedKey: String = "isFeatured"
  private let kAllBrandChannelLogoKey: String = "logo"

  // MARK: Properties
  public var isActive: String?
  public var name: String?
  public var brandId: String?
  public var createdDate: String?
  public var descriptionValue: String?
  public var disclaimer: String?
  public var userId: String?
  public var modifiedDate: String?
  public var over21: String?
  public var category: String?
  public var priority: String?
  public var color: String?
  public var latitude: String?
  public var isDefault: String?
  public var isDeleted: String?
  public var internalIdentifier: String?
  public var qrCode: String?
  public var isPublic: String?
  public var ambaNeedApproval: String?
  public var shortCode: String?
  public var longitude: String?
  public var isFeatured: String?
  public var logo: String?

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
    isActive = json[kAllBrandChannelIsActiveKey].string
    name = json[kAllBrandChannelNameKey].string
    brandId = json[kAllBrandChannelBrandIdKey].string
    createdDate = json[kAllBrandChannelCreatedDateKey].string
    descriptionValue = json[kAllBrandChannelDescriptionValueKey].string
    disclaimer = json[kAllBrandChannelDisclaimerKey].string
    userId = json[kAllBrandChannelUserIdKey].string
    modifiedDate = json[kAllBrandChannelModifiedDateKey].string
    over21 = json[kAllBrandChannelOver21Key].string
    category = json[kAllBrandChannelCategoryKey].string
    priority = json[kAllBrandChannelPriorityKey].string
    color = json[kAllBrandChannelColorKey].string
    latitude = json[kAllBrandChannelLatitudeKey].string
    isDefault = json[kAllBrandChannelIsDefaultKey].string
    isDeleted = json[kAllBrandChannelIsDeletedKey].string
    internalIdentifier = json[kAllBrandChannelInternalIdentifierKey].string
    qrCode = json[kAllBrandChannelQrCodeKey].string
    isPublic = json[kAllBrandChannelIsPublicKey].string
    ambaNeedApproval = json[kAllBrandChannelAmbaNeedApprovalKey].string
    shortCode = json[kAllBrandChannelShortCodeKey].string
    longitude = json[kAllBrandChannelLongitudeKey].string
    isFeatured = json[kAllBrandChannelIsFeaturedKey].string
    logo = json[kAllBrandChannelLogoKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = isActive { dictionary[kAllBrandChannelIsActiveKey] = value }
    if let value = name { dictionary[kAllBrandChannelNameKey] = value }
    if let value = brandId { dictionary[kAllBrandChannelBrandIdKey] = value }
    if let value = createdDate { dictionary[kAllBrandChannelCreatedDateKey] = value }
    if let value = descriptionValue { dictionary[kAllBrandChannelDescriptionValueKey] = value }
    if let value = disclaimer { dictionary[kAllBrandChannelDisclaimerKey] = value }
    if let value = userId { dictionary[kAllBrandChannelUserIdKey] = value }
    if let value = modifiedDate { dictionary[kAllBrandChannelModifiedDateKey] = value }
    if let value = over21 { dictionary[kAllBrandChannelOver21Key] = value }
    if let value = category { dictionary[kAllBrandChannelCategoryKey] = value }
    if let value = priority { dictionary[kAllBrandChannelPriorityKey] = value }
    if let value = color { dictionary[kAllBrandChannelColorKey] = value }
    if let value = latitude { dictionary[kAllBrandChannelLatitudeKey] = value }
    if let value = isDefault { dictionary[kAllBrandChannelIsDefaultKey] = value }
    if let value = isDeleted { dictionary[kAllBrandChannelIsDeletedKey] = value }
    if let value = internalIdentifier { dictionary[kAllBrandChannelInternalIdentifierKey] = value }
    if let value = qrCode { dictionary[kAllBrandChannelQrCodeKey] = value }
    if let value = isPublic { dictionary[kAllBrandChannelIsPublicKey] = value }
    if let value = ambaNeedApproval { dictionary[kAllBrandChannelAmbaNeedApprovalKey] = value }
    if let value = shortCode { dictionary[kAllBrandChannelShortCodeKey] = value }
    if let value = longitude { dictionary[kAllBrandChannelLongitudeKey] = value }
    if let value = isFeatured { dictionary[kAllBrandChannelIsFeaturedKey] = value }
    if let value = logo { dictionary[kAllBrandChannelLogoKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.isActive = aDecoder.decodeObject(forKey: kAllBrandChannelIsActiveKey) as? String
    self.name = aDecoder.decodeObject(forKey: kAllBrandChannelNameKey) as? String
    self.brandId = aDecoder.decodeObject(forKey: kAllBrandChannelBrandIdKey) as? String
    self.createdDate = aDecoder.decodeObject(forKey: kAllBrandChannelCreatedDateKey) as? String
    self.descriptionValue = aDecoder.decodeObject(forKey: kAllBrandChannelDescriptionValueKey) as? String
    self.disclaimer = aDecoder.decodeObject(forKey: kAllBrandChannelDisclaimerKey) as? String
    self.userId = aDecoder.decodeObject(forKey: kAllBrandChannelUserIdKey) as? String
    self.modifiedDate = aDecoder.decodeObject(forKey: kAllBrandChannelModifiedDateKey) as? String
    self.over21 = aDecoder.decodeObject(forKey: kAllBrandChannelOver21Key) as? String
    self.category = aDecoder.decodeObject(forKey: kAllBrandChannelCategoryKey) as? String
    self.priority = aDecoder.decodeObject(forKey: kAllBrandChannelPriorityKey) as? String
    self.color = aDecoder.decodeObject(forKey: kAllBrandChannelColorKey) as? String
    self.latitude = aDecoder.decodeObject(forKey: kAllBrandChannelLatitudeKey) as? String
    self.isDefault = aDecoder.decodeObject(forKey: kAllBrandChannelIsDefaultKey) as? String
    self.isDeleted = aDecoder.decodeObject(forKey: kAllBrandChannelIsDeletedKey) as? String
    self.internalIdentifier = aDecoder.decodeObject(forKey: kAllBrandChannelInternalIdentifierKey) as? String
    self.qrCode = aDecoder.decodeObject(forKey: kAllBrandChannelQrCodeKey) as? String
    self.isPublic = aDecoder.decodeObject(forKey: kAllBrandChannelIsPublicKey) as? String
    self.ambaNeedApproval = aDecoder.decodeObject(forKey: kAllBrandChannelAmbaNeedApprovalKey) as? String
    self.shortCode = aDecoder.decodeObject(forKey: kAllBrandChannelShortCodeKey) as? String
    self.longitude = aDecoder.decodeObject(forKey: kAllBrandChannelLongitudeKey) as? String
    self.isFeatured = aDecoder.decodeObject(forKey: kAllBrandChannelIsFeaturedKey) as? String
    self.logo = aDecoder.decodeObject(forKey: kAllBrandChannelLogoKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(isActive, forKey: kAllBrandChannelIsActiveKey)
    aCoder.encode(name, forKey: kAllBrandChannelNameKey)
    aCoder.encode(brandId, forKey: kAllBrandChannelBrandIdKey)
    aCoder.encode(createdDate, forKey: kAllBrandChannelCreatedDateKey)
    aCoder.encode(descriptionValue, forKey: kAllBrandChannelDescriptionValueKey)
    aCoder.encode(disclaimer, forKey: kAllBrandChannelDisclaimerKey)
    aCoder.encode(userId, forKey: kAllBrandChannelUserIdKey)
    aCoder.encode(modifiedDate, forKey: kAllBrandChannelModifiedDateKey)
    aCoder.encode(over21, forKey: kAllBrandChannelOver21Key)
    aCoder.encode(category, forKey: kAllBrandChannelCategoryKey)
    aCoder.encode(priority, forKey: kAllBrandChannelPriorityKey)
    aCoder.encode(color, forKey: kAllBrandChannelColorKey)
    aCoder.encode(latitude, forKey: kAllBrandChannelLatitudeKey)
    aCoder.encode(isDefault, forKey: kAllBrandChannelIsDefaultKey)
    aCoder.encode(isDeleted, forKey: kAllBrandChannelIsDeletedKey)
    aCoder.encode(internalIdentifier, forKey: kAllBrandChannelInternalIdentifierKey)
    aCoder.encode(qrCode, forKey: kAllBrandChannelQrCodeKey)
    aCoder.encode(isPublic, forKey: kAllBrandChannelIsPublicKey)
    aCoder.encode(ambaNeedApproval, forKey: kAllBrandChannelAmbaNeedApprovalKey)
    aCoder.encode(shortCode, forKey: kAllBrandChannelShortCodeKey)
    aCoder.encode(longitude, forKey: kAllBrandChannelLongitudeKey)
    aCoder.encode(isFeatured, forKey: kAllBrandChannelIsFeaturedKey)
    aCoder.encode(logo, forKey: kAllBrandChannelLogoKey)
  }

}
