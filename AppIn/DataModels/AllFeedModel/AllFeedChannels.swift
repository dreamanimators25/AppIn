//
//  AllFeedChannels.swift
//
//  Created by sameer khan on 31/12/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class AllFeedChannels: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kAllFeedChannelsIsActiveKey: String = "isActive"
  private let kAllFeedChannelsNameKey: String = "name"
  private let kAllFeedChannelsBrandIdKey: String = "brandId"
  private let kAllFeedChannelsCreatedDateKey: String = "createdDate"
  private let kAllFeedChannelsDescriptionValueKey: String = "description"
  private let kAllFeedChannelsDisclaimerKey: String = "disclaimer"
  private let kAllFeedChannelsModifiedDateKey: String = "modifiedDate"
  private let kAllFeedChannelsOver21Key: String = "over21"
  private let kAllFeedChannelsCategoryKey: String = "category"
  private let kAllFeedChannelsPriorityKey: String = "priority"
  private let kAllFeedChannelsColorKey: String = "color"
  private let kAllFeedChannelsLatitudeKey: String = "latitude"
  private let kAllFeedChannelsIsDefaultKey: String = "isDefault"
  private let kAllFeedChannelsIsDeletedKey: String = "isDeleted"
  private let kAllFeedChannelsInternalIdentifierKey: String = "id"
  private let kAllFeedChannelsQrCodeKey: String = "qrCode"
  private let kAllFeedChannelsIsPublicKey: String = "isPublic"
  private let kAllFeedChannelsAmbaNeedApprovalKey: String = "ambaNeedApproval"
  private let kAllFeedChannelsShortCodeKey: String = "shortCode"
  private let kAllFeedChannelsLongitudeKey: String = "longitude"
  private let kAllFeedChannelsIsFeaturedKey: String = "isFeatured"
  private let kAllFeedChannelsLogoKey: String = "logo"
  private let kAllFeedChannelsPagesKey: String = "pages"

  // MARK: Properties
  public var isActive: String?
  public var name: String?
  public var brandId: String?
  public var createdDate: String?
  public var descriptionValue: String?
  public var disclaimer: String?
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
  public var pages: [AllFeedPages]?

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
    isActive = json[kAllFeedChannelsIsActiveKey].string
    name = json[kAllFeedChannelsNameKey].string
    brandId = json[kAllFeedChannelsBrandIdKey].string
    createdDate = json[kAllFeedChannelsCreatedDateKey].string
    descriptionValue = json[kAllFeedChannelsDescriptionValueKey].string
    disclaimer = json[kAllFeedChannelsDisclaimerKey].string
    modifiedDate = json[kAllFeedChannelsModifiedDateKey].string
    over21 = json[kAllFeedChannelsOver21Key].string
    category = json[kAllFeedChannelsCategoryKey].string
    priority = json[kAllFeedChannelsPriorityKey].string
    color = json[kAllFeedChannelsColorKey].string
    latitude = json[kAllFeedChannelsLatitudeKey].string
    isDefault = json[kAllFeedChannelsIsDefaultKey].string
    isDeleted = json[kAllFeedChannelsIsDeletedKey].string
    internalIdentifier = json[kAllFeedChannelsInternalIdentifierKey].string
    qrCode = json[kAllFeedChannelsQrCodeKey].string
    isPublic = json[kAllFeedChannelsIsPublicKey].string
    ambaNeedApproval = json[kAllFeedChannelsAmbaNeedApprovalKey].string
    shortCode = json[kAllFeedChannelsShortCodeKey].string
    longitude = json[kAllFeedChannelsLongitudeKey].string
    isFeatured = json[kAllFeedChannelsIsFeaturedKey].string
    logo = json[kAllFeedChannelsLogoKey].string
    if let items = json[kAllFeedChannelsPagesKey].array { pages = items.map { AllFeedPages(json: $0) } }
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = isActive { dictionary[kAllFeedChannelsIsActiveKey] = value }
    if let value = name { dictionary[kAllFeedChannelsNameKey] = value }
    if let value = brandId { dictionary[kAllFeedChannelsBrandIdKey] = value }
    if let value = createdDate { dictionary[kAllFeedChannelsCreatedDateKey] = value }
    if let value = descriptionValue { dictionary[kAllFeedChannelsDescriptionValueKey] = value }
    if let value = disclaimer { dictionary[kAllFeedChannelsDisclaimerKey] = value }
    if let value = modifiedDate { dictionary[kAllFeedChannelsModifiedDateKey] = value }
    if let value = over21 { dictionary[kAllFeedChannelsOver21Key] = value }
    if let value = category { dictionary[kAllFeedChannelsCategoryKey] = value }
    if let value = priority { dictionary[kAllFeedChannelsPriorityKey] = value }
    if let value = color { dictionary[kAllFeedChannelsColorKey] = value }
    if let value = latitude { dictionary[kAllFeedChannelsLatitudeKey] = value }
    if let value = isDefault { dictionary[kAllFeedChannelsIsDefaultKey] = value }
    if let value = isDeleted { dictionary[kAllFeedChannelsIsDeletedKey] = value }
    if let value = internalIdentifier { dictionary[kAllFeedChannelsInternalIdentifierKey] = value }
    if let value = qrCode { dictionary[kAllFeedChannelsQrCodeKey] = value }
    if let value = isPublic { dictionary[kAllFeedChannelsIsPublicKey] = value }
    if let value = ambaNeedApproval { dictionary[kAllFeedChannelsAmbaNeedApprovalKey] = value }
    if let value = shortCode { dictionary[kAllFeedChannelsShortCodeKey] = value }
    if let value = longitude { dictionary[kAllFeedChannelsLongitudeKey] = value }
    if let value = isFeatured { dictionary[kAllFeedChannelsIsFeaturedKey] = value }
    if let value = logo { dictionary[kAllFeedChannelsLogoKey] = value }
    if let value = pages { dictionary[kAllFeedChannelsPagesKey] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.isActive = aDecoder.decodeObject(forKey: kAllFeedChannelsIsActiveKey) as? String
    self.name = aDecoder.decodeObject(forKey: kAllFeedChannelsNameKey) as? String
    self.brandId = aDecoder.decodeObject(forKey: kAllFeedChannelsBrandIdKey) as? String
    self.createdDate = aDecoder.decodeObject(forKey: kAllFeedChannelsCreatedDateKey) as? String
    self.descriptionValue = aDecoder.decodeObject(forKey: kAllFeedChannelsDescriptionValueKey) as? String
    self.disclaimer = aDecoder.decodeObject(forKey: kAllFeedChannelsDisclaimerKey) as? String
    self.modifiedDate = aDecoder.decodeObject(forKey: kAllFeedChannelsModifiedDateKey) as? String
    self.over21 = aDecoder.decodeObject(forKey: kAllFeedChannelsOver21Key) as? String
    self.category = aDecoder.decodeObject(forKey: kAllFeedChannelsCategoryKey) as? String
    self.priority = aDecoder.decodeObject(forKey: kAllFeedChannelsPriorityKey) as? String
    self.color = aDecoder.decodeObject(forKey: kAllFeedChannelsColorKey) as? String
    self.latitude = aDecoder.decodeObject(forKey: kAllFeedChannelsLatitudeKey) as? String
    self.isDefault = aDecoder.decodeObject(forKey: kAllFeedChannelsIsDefaultKey) as? String
    self.isDeleted = aDecoder.decodeObject(forKey: kAllFeedChannelsIsDeletedKey) as? String
    self.internalIdentifier = aDecoder.decodeObject(forKey: kAllFeedChannelsInternalIdentifierKey) as? String
    self.qrCode = aDecoder.decodeObject(forKey: kAllFeedChannelsQrCodeKey) as? String
    self.isPublic = aDecoder.decodeObject(forKey: kAllFeedChannelsIsPublicKey) as? String
    self.ambaNeedApproval = aDecoder.decodeObject(forKey: kAllFeedChannelsAmbaNeedApprovalKey) as? String
    self.shortCode = aDecoder.decodeObject(forKey: kAllFeedChannelsShortCodeKey) as? String
    self.longitude = aDecoder.decodeObject(forKey: kAllFeedChannelsLongitudeKey) as? String
    self.isFeatured = aDecoder.decodeObject(forKey: kAllFeedChannelsIsFeaturedKey) as? String
    self.logo = aDecoder.decodeObject(forKey: kAllFeedChannelsLogoKey) as? String
    self.pages = aDecoder.decodeObject(forKey: kAllFeedChannelsPagesKey) as? [AllFeedPages]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(isActive, forKey: kAllFeedChannelsIsActiveKey)
    aCoder.encode(name, forKey: kAllFeedChannelsNameKey)
    aCoder.encode(brandId, forKey: kAllFeedChannelsBrandIdKey)
    aCoder.encode(createdDate, forKey: kAllFeedChannelsCreatedDateKey)
    aCoder.encode(descriptionValue, forKey: kAllFeedChannelsDescriptionValueKey)
    aCoder.encode(disclaimer, forKey: kAllFeedChannelsDisclaimerKey)
    aCoder.encode(modifiedDate, forKey: kAllFeedChannelsModifiedDateKey)
    aCoder.encode(over21, forKey: kAllFeedChannelsOver21Key)
    aCoder.encode(category, forKey: kAllFeedChannelsCategoryKey)
    aCoder.encode(priority, forKey: kAllFeedChannelsPriorityKey)
    aCoder.encode(color, forKey: kAllFeedChannelsColorKey)
    aCoder.encode(latitude, forKey: kAllFeedChannelsLatitudeKey)
    aCoder.encode(isDefault, forKey: kAllFeedChannelsIsDefaultKey)
    aCoder.encode(isDeleted, forKey: kAllFeedChannelsIsDeletedKey)
    aCoder.encode(internalIdentifier, forKey: kAllFeedChannelsInternalIdentifierKey)
    aCoder.encode(qrCode, forKey: kAllFeedChannelsQrCodeKey)
    aCoder.encode(isPublic, forKey: kAllFeedChannelsIsPublicKey)
    aCoder.encode(ambaNeedApproval, forKey: kAllFeedChannelsAmbaNeedApprovalKey)
    aCoder.encode(shortCode, forKey: kAllFeedChannelsShortCodeKey)
    aCoder.encode(longitude, forKey: kAllFeedChannelsLongitudeKey)
    aCoder.encode(isFeatured, forKey: kAllFeedChannelsIsFeaturedKey)
    aCoder.encode(logo, forKey: kAllFeedChannelsLogoKey)
    aCoder.encode(pages, forKey: kAllFeedChannelsPagesKey)
  }

}
