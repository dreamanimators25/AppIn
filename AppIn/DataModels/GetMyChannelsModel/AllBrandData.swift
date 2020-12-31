//
//  AllBrandData.swift
//
//  Created by sameer khan on 30/12/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class AllBrandData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kAllBrandDataStateKey: String = "state"
  private let kAllBrandDataIsActiveKey: String = "isActive"
  private let kAllBrandDataBrandIdKey: String = "brandId"
  private let kAllBrandDataTotalRatingKey: String = "totalRating"
  private let kAllBrandDataWASupportNumberKey: String = "WASupportNumber"
  private let kAllBrandDataModifiedDateKey: String = "modifiedDate"
  private let kAllBrandDataUserIdKey: String = "userId"
  private let kAllBrandDataLatitudeKey: String = "latitude"
  private let kAllBrandDataFbLinkKey: String = "fbLink"
  private let kAllBrandDataPrimaryColorKey: String = "primaryColor"
  private let kAllBrandDataZipKey: String = "zip"
  private let kAllBrandDataEnableRatingKey: String = "enableRating"
  private let kAllBrandDataLogoKey: String = "logo"
  private let kAllBrandDataLongitudeKey: String = "longitude"
  private let kAllBrandDataIsFeaturedKey: String = "isFeatured"
  private let kAllBrandDataNameKey: String = "name"
  private let kAllBrandDataCityKey: String = "city"
  private let kAllBrandDataEmailKey: String = "email"
  private let kAllBrandDataTotalRatingCountKey: String = "totalRatingCount"
  private let kAllBrandDataWebsiteKey: String = "website"
  private let kAllBrandDataExpiryDateKey: String = "expiryDate"
  private let kAllBrandDataStreetKey: String = "street"
  private let kAllBrandDataDescriptionValueKey: String = "description"
  private let kAllBrandDataDisclaimerKey: String = "disclaimer"
  private let kAllBrandDataPriorityKey: String = "priority"
  private let kAllBrandDataAddedDateKey: String = "addedDate"
  private let kAllBrandDataIsDeletedKey: String = "isDeleted"
  private let kAllBrandDataIsPublicKey: String = "isPublic"
  private let kAllBrandDataSecondaryNumberKey: String = "secondaryNumber"
  private let kAllBrandDataPrimaryNumberKey: String = "primaryNumber"
  private let kAllBrandDataOtherImagesKey: String = "otherImages"
  private let kAllBrandDataChannelKey: String = "channel"
  private let kAllBrandDataCountryKey: String = "country"

  // MARK: Properties
  public var state: String?
  public var isActive: String?
  public var brandId: String?
  public var totalRating: String?
  public var wASupportNumber: String?
  public var modifiedDate: String?
  public var userId: String?
  public var latitude: String?
  public var fbLink: String?
  public var primaryColor: String?
  public var zip: String?
  public var enableRating: String?
  public var logo: String?
  public var longitude: String?
  public var isFeatured: String?
  public var name: String?
  public var city: String?
  public var email: String?
  public var totalRatingCount: String?
  public var website: String?
  public var expiryDate: String?
  public var street: String?
  public var descriptionValue: String?
  public var disclaimer: String?
  public var priority: String?
  public var addedDate: String?
  public var isDeleted: String?
  public var isPublic: String?
  public var secondaryNumber: String?
  public var primaryNumber: String?
  public var otherImages: String?
  public var channel: [AllBrandChannel]?
  public var country: String?

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
    state = json[kAllBrandDataStateKey].string
    isActive = json[kAllBrandDataIsActiveKey].string
    brandId = json[kAllBrandDataBrandIdKey].string
    totalRating = json[kAllBrandDataTotalRatingKey].string
    wASupportNumber = json[kAllBrandDataWASupportNumberKey].string
    modifiedDate = json[kAllBrandDataModifiedDateKey].string
    userId = json[kAllBrandDataUserIdKey].string
    latitude = json[kAllBrandDataLatitudeKey].string
    fbLink = json[kAllBrandDataFbLinkKey].string
    primaryColor = json[kAllBrandDataPrimaryColorKey].string
    zip = json[kAllBrandDataZipKey].string
    enableRating = json[kAllBrandDataEnableRatingKey].string
    logo = json[kAllBrandDataLogoKey].string
    longitude = json[kAllBrandDataLongitudeKey].string
    isFeatured = json[kAllBrandDataIsFeaturedKey].string
    name = json[kAllBrandDataNameKey].string
    city = json[kAllBrandDataCityKey].string
    email = json[kAllBrandDataEmailKey].string
    totalRatingCount = json[kAllBrandDataTotalRatingCountKey].string
    website = json[kAllBrandDataWebsiteKey].string
    expiryDate = json[kAllBrandDataExpiryDateKey].string
    street = json[kAllBrandDataStreetKey].string
    descriptionValue = json[kAllBrandDataDescriptionValueKey].string
    disclaimer = json[kAllBrandDataDisclaimerKey].string
    priority = json[kAllBrandDataPriorityKey].string
    addedDate = json[kAllBrandDataAddedDateKey].string
    isDeleted = json[kAllBrandDataIsDeletedKey].string
    isPublic = json[kAllBrandDataIsPublicKey].string
    secondaryNumber = json[kAllBrandDataSecondaryNumberKey].string
    primaryNumber = json[kAllBrandDataPrimaryNumberKey].string
    otherImages = json[kAllBrandDataOtherImagesKey].string
    if let items = json[kAllBrandDataChannelKey].array { channel = items.map { AllBrandChannel(json: $0) } }
    country = json[kAllBrandDataCountryKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = state { dictionary[kAllBrandDataStateKey] = value }
    if let value = isActive { dictionary[kAllBrandDataIsActiveKey] = value }
    if let value = brandId { dictionary[kAllBrandDataBrandIdKey] = value }
    if let value = totalRating { dictionary[kAllBrandDataTotalRatingKey] = value }
    if let value = wASupportNumber { dictionary[kAllBrandDataWASupportNumberKey] = value }
    if let value = modifiedDate { dictionary[kAllBrandDataModifiedDateKey] = value }
    if let value = userId { dictionary[kAllBrandDataUserIdKey] = value }
    if let value = latitude { dictionary[kAllBrandDataLatitudeKey] = value }
    if let value = fbLink { dictionary[kAllBrandDataFbLinkKey] = value }
    if let value = primaryColor { dictionary[kAllBrandDataPrimaryColorKey] = value }
    if let value = zip { dictionary[kAllBrandDataZipKey] = value }
    if let value = enableRating { dictionary[kAllBrandDataEnableRatingKey] = value }
    if let value = logo { dictionary[kAllBrandDataLogoKey] = value }
    if let value = longitude { dictionary[kAllBrandDataLongitudeKey] = value }
    if let value = isFeatured { dictionary[kAllBrandDataIsFeaturedKey] = value }
    if let value = name { dictionary[kAllBrandDataNameKey] = value }
    if let value = city { dictionary[kAllBrandDataCityKey] = value }
    if let value = email { dictionary[kAllBrandDataEmailKey] = value }
    if let value = totalRatingCount { dictionary[kAllBrandDataTotalRatingCountKey] = value }
    if let value = website { dictionary[kAllBrandDataWebsiteKey] = value }
    if let value = expiryDate { dictionary[kAllBrandDataExpiryDateKey] = value }
    if let value = street { dictionary[kAllBrandDataStreetKey] = value }
    if let value = descriptionValue { dictionary[kAllBrandDataDescriptionValueKey] = value }
    if let value = disclaimer { dictionary[kAllBrandDataDisclaimerKey] = value }
    if let value = priority { dictionary[kAllBrandDataPriorityKey] = value }
    if let value = addedDate { dictionary[kAllBrandDataAddedDateKey] = value }
    if let value = isDeleted { dictionary[kAllBrandDataIsDeletedKey] = value }
    if let value = isPublic { dictionary[kAllBrandDataIsPublicKey] = value }
    if let value = secondaryNumber { dictionary[kAllBrandDataSecondaryNumberKey] = value }
    if let value = primaryNumber { dictionary[kAllBrandDataPrimaryNumberKey] = value }
    if let value = otherImages { dictionary[kAllBrandDataOtherImagesKey] = value }
    if let value = channel { dictionary[kAllBrandDataChannelKey] = value.map { $0.dictionaryRepresentation() } }
    if let value = country { dictionary[kAllBrandDataCountryKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.state = aDecoder.decodeObject(forKey: kAllBrandDataStateKey) as? String
    self.isActive = aDecoder.decodeObject(forKey: kAllBrandDataIsActiveKey) as? String
    self.brandId = aDecoder.decodeObject(forKey: kAllBrandDataBrandIdKey) as? String
    self.totalRating = aDecoder.decodeObject(forKey: kAllBrandDataTotalRatingKey) as? String
    self.wASupportNumber = aDecoder.decodeObject(forKey: kAllBrandDataWASupportNumberKey) as? String
    self.modifiedDate = aDecoder.decodeObject(forKey: kAllBrandDataModifiedDateKey) as? String
    self.userId = aDecoder.decodeObject(forKey: kAllBrandDataUserIdKey) as? String
    self.latitude = aDecoder.decodeObject(forKey: kAllBrandDataLatitudeKey) as? String
    self.fbLink = aDecoder.decodeObject(forKey: kAllBrandDataFbLinkKey) as? String
    self.primaryColor = aDecoder.decodeObject(forKey: kAllBrandDataPrimaryColorKey) as? String
    self.zip = aDecoder.decodeObject(forKey: kAllBrandDataZipKey) as? String
    self.enableRating = aDecoder.decodeObject(forKey: kAllBrandDataEnableRatingKey) as? String
    self.logo = aDecoder.decodeObject(forKey: kAllBrandDataLogoKey) as? String
    self.longitude = aDecoder.decodeObject(forKey: kAllBrandDataLongitudeKey) as? String
    self.isFeatured = aDecoder.decodeObject(forKey: kAllBrandDataIsFeaturedKey) as? String
    self.name = aDecoder.decodeObject(forKey: kAllBrandDataNameKey) as? String
    self.city = aDecoder.decodeObject(forKey: kAllBrandDataCityKey) as? String
    self.email = aDecoder.decodeObject(forKey: kAllBrandDataEmailKey) as? String
    self.totalRatingCount = aDecoder.decodeObject(forKey: kAllBrandDataTotalRatingCountKey) as? String
    self.website = aDecoder.decodeObject(forKey: kAllBrandDataWebsiteKey) as? String
    self.expiryDate = aDecoder.decodeObject(forKey: kAllBrandDataExpiryDateKey) as? String
    self.street = aDecoder.decodeObject(forKey: kAllBrandDataStreetKey) as? String
    self.descriptionValue = aDecoder.decodeObject(forKey: kAllBrandDataDescriptionValueKey) as? String
    self.disclaimer = aDecoder.decodeObject(forKey: kAllBrandDataDisclaimerKey) as? String
    self.priority = aDecoder.decodeObject(forKey: kAllBrandDataPriorityKey) as? String
    self.addedDate = aDecoder.decodeObject(forKey: kAllBrandDataAddedDateKey) as? String
    self.isDeleted = aDecoder.decodeObject(forKey: kAllBrandDataIsDeletedKey) as? String
    self.isPublic = aDecoder.decodeObject(forKey: kAllBrandDataIsPublicKey) as? String
    self.secondaryNumber = aDecoder.decodeObject(forKey: kAllBrandDataSecondaryNumberKey) as? String
    self.primaryNumber = aDecoder.decodeObject(forKey: kAllBrandDataPrimaryNumberKey) as? String
    self.otherImages = aDecoder.decodeObject(forKey: kAllBrandDataOtherImagesKey) as? String
    self.channel = aDecoder.decodeObject(forKey: kAllBrandDataChannelKey) as? [AllBrandChannel]
    self.country = aDecoder.decodeObject(forKey: kAllBrandDataCountryKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(state, forKey: kAllBrandDataStateKey)
    aCoder.encode(isActive, forKey: kAllBrandDataIsActiveKey)
    aCoder.encode(brandId, forKey: kAllBrandDataBrandIdKey)
    aCoder.encode(totalRating, forKey: kAllBrandDataTotalRatingKey)
    aCoder.encode(wASupportNumber, forKey: kAllBrandDataWASupportNumberKey)
    aCoder.encode(modifiedDate, forKey: kAllBrandDataModifiedDateKey)
    aCoder.encode(userId, forKey: kAllBrandDataUserIdKey)
    aCoder.encode(latitude, forKey: kAllBrandDataLatitudeKey)
    aCoder.encode(fbLink, forKey: kAllBrandDataFbLinkKey)
    aCoder.encode(primaryColor, forKey: kAllBrandDataPrimaryColorKey)
    aCoder.encode(zip, forKey: kAllBrandDataZipKey)
    aCoder.encode(enableRating, forKey: kAllBrandDataEnableRatingKey)
    aCoder.encode(logo, forKey: kAllBrandDataLogoKey)
    aCoder.encode(longitude, forKey: kAllBrandDataLongitudeKey)
    aCoder.encode(isFeatured, forKey: kAllBrandDataIsFeaturedKey)
    aCoder.encode(name, forKey: kAllBrandDataNameKey)
    aCoder.encode(city, forKey: kAllBrandDataCityKey)
    aCoder.encode(email, forKey: kAllBrandDataEmailKey)
    aCoder.encode(totalRatingCount, forKey: kAllBrandDataTotalRatingCountKey)
    aCoder.encode(website, forKey: kAllBrandDataWebsiteKey)
    aCoder.encode(expiryDate, forKey: kAllBrandDataExpiryDateKey)
    aCoder.encode(street, forKey: kAllBrandDataStreetKey)
    aCoder.encode(descriptionValue, forKey: kAllBrandDataDescriptionValueKey)
    aCoder.encode(disclaimer, forKey: kAllBrandDataDisclaimerKey)
    aCoder.encode(priority, forKey: kAllBrandDataPriorityKey)
    aCoder.encode(addedDate, forKey: kAllBrandDataAddedDateKey)
    aCoder.encode(isDeleted, forKey: kAllBrandDataIsDeletedKey)
    aCoder.encode(isPublic, forKey: kAllBrandDataIsPublicKey)
    aCoder.encode(secondaryNumber, forKey: kAllBrandDataSecondaryNumberKey)
    aCoder.encode(primaryNumber, forKey: kAllBrandDataPrimaryNumberKey)
    aCoder.encode(otherImages, forKey: kAllBrandDataOtherImagesKey)
    aCoder.encode(channel, forKey: kAllBrandDataChannelKey)
    aCoder.encode(country, forKey: kAllBrandDataCountryKey)
  }

}
