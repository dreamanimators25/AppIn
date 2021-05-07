//
//  AllNewChannels.swift
//
//  Created by Sameer Khan on 06/05/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class AllNewChannels: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kAllNewChannelsIsActiveKey: String = "isActive"
  private let kAllNewChannelsNameKey: String = "name"
  private let kAllNewChannelsBrandIdKey: String = "brandId"
  private let kAllNewChannelsCreatedDateKey: String = "createdDate"
  private let kAllNewChannelsDescriptionValueKey: String = "description"
  private let kAllNewChannelsDisclaimerKey: String = "disclaimer"
  private let kAllNewChannelsModifiedDateKey: String = "modifiedDate"
  private let kAllNewChannelsOver21Key: String = "over21"
  private let kAllNewChannelsCategoryKey: String = "category"
  private let kAllNewChannelsPriorityKey: String = "priority"
  private let kAllNewChannelsColorKey: String = "color"
  private let kAllNewChannelsLatitudeKey: String = "latitude"
  private let kAllNewChannelsIsDefaultKey: String = "isDefault"
  private let kAllNewChannelsIsDeletedKey: String = "isDeleted"
  private let kAllNewChannelsInternalIdentifierKey: String = "id"
  private let kAllNewChannelsQrCodeKey: String = "qrCode"
  private let kAllNewChannelsIsPublicKey: String = "isPublic"
  private let kAllNewChannelsOtherImagesKey: String = "otherImages"
  private let kAllNewChannelsAmbaNeedApprovalKey: String = "ambaNeedApproval"
  private let kAllNewChannelsShortCodeKey: String = "shortCode"
  private let kAllNewChannelsLongitudeKey: String = "longitude"
  private let kAllNewChannelsIsFeaturedKey: String = "isFeatured"
  private let kAllNewChannelsLogoKey: String = "logo"
  private let kAllNewChannelsPagesKey: String = "pages"

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
  public var otherImages: String?
  public var ambaNeedApproval: String?
  public var shortCode: String?
  public var longitude: String?
  public var isFeatured: String?
  public var logo: String?
  public var pages: [AllNewPages]?

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
    isActive = json[kAllNewChannelsIsActiveKey].string
    name = json[kAllNewChannelsNameKey].string
    brandId = json[kAllNewChannelsBrandIdKey].string
    createdDate = json[kAllNewChannelsCreatedDateKey].string
    descriptionValue = json[kAllNewChannelsDescriptionValueKey].string
    disclaimer = json[kAllNewChannelsDisclaimerKey].string
    modifiedDate = json[kAllNewChannelsModifiedDateKey].string
    over21 = json[kAllNewChannelsOver21Key].string
    category = json[kAllNewChannelsCategoryKey].string
    priority = json[kAllNewChannelsPriorityKey].string
    color = json[kAllNewChannelsColorKey].string
    latitude = json[kAllNewChannelsLatitudeKey].string
    isDefault = json[kAllNewChannelsIsDefaultKey].string
    isDeleted = json[kAllNewChannelsIsDeletedKey].string
    internalIdentifier = json[kAllNewChannelsInternalIdentifierKey].string
    qrCode = json[kAllNewChannelsQrCodeKey].string
    isPublic = json[kAllNewChannelsIsPublicKey].string
    otherImages = json[kAllNewChannelsOtherImagesKey].string
    ambaNeedApproval = json[kAllNewChannelsAmbaNeedApprovalKey].string
    shortCode = json[kAllNewChannelsShortCodeKey].string
    longitude = json[kAllNewChannelsLongitudeKey].string
    isFeatured = json[kAllNewChannelsIsFeaturedKey].string
    logo = json[kAllNewChannelsLogoKey].string
    if let items = json[kAllNewChannelsPagesKey].array { pages = items.map { AllNewPages(json: $0) } }
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = isActive { dictionary[kAllNewChannelsIsActiveKey] = value }
    if let value = name { dictionary[kAllNewChannelsNameKey] = value }
    if let value = brandId { dictionary[kAllNewChannelsBrandIdKey] = value }
    if let value = createdDate { dictionary[kAllNewChannelsCreatedDateKey] = value }
    if let value = descriptionValue { dictionary[kAllNewChannelsDescriptionValueKey] = value }
    if let value = disclaimer { dictionary[kAllNewChannelsDisclaimerKey] = value }
    if let value = modifiedDate { dictionary[kAllNewChannelsModifiedDateKey] = value }
    if let value = over21 { dictionary[kAllNewChannelsOver21Key] = value }
    if let value = category { dictionary[kAllNewChannelsCategoryKey] = value }
    if let value = priority { dictionary[kAllNewChannelsPriorityKey] = value }
    if let value = color { dictionary[kAllNewChannelsColorKey] = value }
    if let value = latitude { dictionary[kAllNewChannelsLatitudeKey] = value }
    if let value = isDefault { dictionary[kAllNewChannelsIsDefaultKey] = value }
    if let value = isDeleted { dictionary[kAllNewChannelsIsDeletedKey] = value }
    if let value = internalIdentifier { dictionary[kAllNewChannelsInternalIdentifierKey] = value }
    if let value = qrCode { dictionary[kAllNewChannelsQrCodeKey] = value }
    if let value = isPublic { dictionary[kAllNewChannelsIsPublicKey] = value }
    if let value = otherImages { dictionary[kAllNewChannelsOtherImagesKey] = value }
    if let value = ambaNeedApproval { dictionary[kAllNewChannelsAmbaNeedApprovalKey] = value }
    if let value = shortCode { dictionary[kAllNewChannelsShortCodeKey] = value }
    if let value = longitude { dictionary[kAllNewChannelsLongitudeKey] = value }
    if let value = isFeatured { dictionary[kAllNewChannelsIsFeaturedKey] = value }
    if let value = logo { dictionary[kAllNewChannelsLogoKey] = value }
    if let value = pages { dictionary[kAllNewChannelsPagesKey] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.isActive = aDecoder.decodeObject(forKey: kAllNewChannelsIsActiveKey) as? String
    self.name = aDecoder.decodeObject(forKey: kAllNewChannelsNameKey) as? String
    self.brandId = aDecoder.decodeObject(forKey: kAllNewChannelsBrandIdKey) as? String
    self.createdDate = aDecoder.decodeObject(forKey: kAllNewChannelsCreatedDateKey) as? String
    self.descriptionValue = aDecoder.decodeObject(forKey: kAllNewChannelsDescriptionValueKey) as? String
    self.disclaimer = aDecoder.decodeObject(forKey: kAllNewChannelsDisclaimerKey) as? String
    self.modifiedDate = aDecoder.decodeObject(forKey: kAllNewChannelsModifiedDateKey) as? String
    self.over21 = aDecoder.decodeObject(forKey: kAllNewChannelsOver21Key) as? String
    self.category = aDecoder.decodeObject(forKey: kAllNewChannelsCategoryKey) as? String
    self.priority = aDecoder.decodeObject(forKey: kAllNewChannelsPriorityKey) as? String
    self.color = aDecoder.decodeObject(forKey: kAllNewChannelsColorKey) as? String
    self.latitude = aDecoder.decodeObject(forKey: kAllNewChannelsLatitudeKey) as? String
    self.isDefault = aDecoder.decodeObject(forKey: kAllNewChannelsIsDefaultKey) as? String
    self.isDeleted = aDecoder.decodeObject(forKey: kAllNewChannelsIsDeletedKey) as? String
    self.internalIdentifier = aDecoder.decodeObject(forKey: kAllNewChannelsInternalIdentifierKey) as? String
    self.qrCode = aDecoder.decodeObject(forKey: kAllNewChannelsQrCodeKey) as? String
    self.isPublic = aDecoder.decodeObject(forKey: kAllNewChannelsIsPublicKey) as? String
    self.otherImages = aDecoder.decodeObject(forKey: kAllNewChannelsOtherImagesKey) as? String
    self.ambaNeedApproval = aDecoder.decodeObject(forKey: kAllNewChannelsAmbaNeedApprovalKey) as? String
    self.shortCode = aDecoder.decodeObject(forKey: kAllNewChannelsShortCodeKey) as? String
    self.longitude = aDecoder.decodeObject(forKey: kAllNewChannelsLongitudeKey) as? String
    self.isFeatured = aDecoder.decodeObject(forKey: kAllNewChannelsIsFeaturedKey) as? String
    self.logo = aDecoder.decodeObject(forKey: kAllNewChannelsLogoKey) as? String
    self.pages = aDecoder.decodeObject(forKey: kAllNewChannelsPagesKey) as? [AllNewPages]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(isActive, forKey: kAllNewChannelsIsActiveKey)
    aCoder.encode(name, forKey: kAllNewChannelsNameKey)
    aCoder.encode(brandId, forKey: kAllNewChannelsBrandIdKey)
    aCoder.encode(createdDate, forKey: kAllNewChannelsCreatedDateKey)
    aCoder.encode(descriptionValue, forKey: kAllNewChannelsDescriptionValueKey)
    aCoder.encode(disclaimer, forKey: kAllNewChannelsDisclaimerKey)
    aCoder.encode(modifiedDate, forKey: kAllNewChannelsModifiedDateKey)
    aCoder.encode(over21, forKey: kAllNewChannelsOver21Key)
    aCoder.encode(category, forKey: kAllNewChannelsCategoryKey)
    aCoder.encode(priority, forKey: kAllNewChannelsPriorityKey)
    aCoder.encode(color, forKey: kAllNewChannelsColorKey)
    aCoder.encode(latitude, forKey: kAllNewChannelsLatitudeKey)
    aCoder.encode(isDefault, forKey: kAllNewChannelsIsDefaultKey)
    aCoder.encode(isDeleted, forKey: kAllNewChannelsIsDeletedKey)
    aCoder.encode(internalIdentifier, forKey: kAllNewChannelsInternalIdentifierKey)
    aCoder.encode(qrCode, forKey: kAllNewChannelsQrCodeKey)
    aCoder.encode(isPublic, forKey: kAllNewChannelsIsPublicKey)
    aCoder.encode(otherImages, forKey: kAllNewChannelsOtherImagesKey)
    aCoder.encode(ambaNeedApproval, forKey: kAllNewChannelsAmbaNeedApprovalKey)
    aCoder.encode(shortCode, forKey: kAllNewChannelsShortCodeKey)
    aCoder.encode(longitude, forKey: kAllNewChannelsLongitudeKey)
    aCoder.encode(isFeatured, forKey: kAllNewChannelsIsFeaturedKey)
    aCoder.encode(logo, forKey: kAllNewChannelsLogoKey)
    aCoder.encode(pages, forKey: kAllNewChannelsPagesKey)
  }

}
