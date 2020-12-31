//
//  AllFeedData.swift
//
//  Created by sameer khan on 31/12/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class AllFeedData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kAllFeedDataStateKey: String = "state"
  private let kAllFeedDataIsActiveKey: String = "isActive"
  private let kAllFeedDataBrandIdKey: String = "brandId"
  private let kAllFeedDataTotalRatingKey: String = "totalRating"
  private let kAllFeedDataWASupportNumberKey: String = "WASupportNumber"
  private let kAllFeedDataModifiedDateKey: String = "modifiedDate"
  private let kAllFeedDataUserIdKey: String = "userId"
  private let kAllFeedDataLatitudeKey: String = "latitude"
  private let kAllFeedDataFbLinkKey: String = "fbLink"
  private let kAllFeedDataPrimaryColorKey: String = "primaryColor"
  private let kAllFeedDataZipKey: String = "zip"
  private let kAllFeedDataEnableRatingKey: String = "enableRating"
  private let kAllFeedDataLogoKey: String = "logo"
  private let kAllFeedDataLongitudeKey: String = "longitude"
  private let kAllFeedDataIsFeaturedKey: String = "isFeatured"
  private let kAllFeedDataNameKey: String = "name"
  private let kAllFeedDataCityKey: String = "city"
  private let kAllFeedDataEmailKey: String = "email"
  private let kAllFeedDataTotalRatingCountKey: String = "totalRatingCount"
  private let kAllFeedDataWebsiteKey: String = "website"
  private let kAllFeedDataExpiryDateKey: String = "expiryDate"
  private let kAllFeedDataStreetKey: String = "street"
  private let kAllFeedDataDescriptionValueKey: String = "description"
  private let kAllFeedDataDisclaimerKey: String = "disclaimer"
  private let kAllFeedDataPriorityKey: String = "priority"
  private let kAllFeedDataAddedDateKey: String = "addedDate"
  private let kAllFeedDataIsDeletedKey: String = "isDeleted"
  private let kAllFeedDataIsPublicKey: String = "isPublic"
  private let kAllFeedDataSecondaryNumberKey: String = "secondaryNumber"
  private let kAllFeedDataPrimaryNumberKey: String = "primaryNumber"
  private let kAllFeedDataOtherImagesKey: String = "otherImages"
  private let kAllFeedDataChannelsKey: String = "channels"
  private let kAllFeedDataChannelIdKey: String = "channelId"
  private let kAllFeedDataCountryKey: String = "country"

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
  public var channels: [AllFeedChannels]?
  public var channelId: String?
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
    state = json[kAllFeedDataStateKey].string
    isActive = json[kAllFeedDataIsActiveKey].string
    brandId = json[kAllFeedDataBrandIdKey].string
    totalRating = json[kAllFeedDataTotalRatingKey].string
    wASupportNumber = json[kAllFeedDataWASupportNumberKey].string
    modifiedDate = json[kAllFeedDataModifiedDateKey].string
    userId = json[kAllFeedDataUserIdKey].string
    latitude = json[kAllFeedDataLatitudeKey].string
    fbLink = json[kAllFeedDataFbLinkKey].string
    primaryColor = json[kAllFeedDataPrimaryColorKey].string
    zip = json[kAllFeedDataZipKey].string
    enableRating = json[kAllFeedDataEnableRatingKey].string
    logo = json[kAllFeedDataLogoKey].string
    longitude = json[kAllFeedDataLongitudeKey].string
    isFeatured = json[kAllFeedDataIsFeaturedKey].string
    name = json[kAllFeedDataNameKey].string
    city = json[kAllFeedDataCityKey].string
    email = json[kAllFeedDataEmailKey].string
    totalRatingCount = json[kAllFeedDataTotalRatingCountKey].string
    website = json[kAllFeedDataWebsiteKey].string
    expiryDate = json[kAllFeedDataExpiryDateKey].string
    street = json[kAllFeedDataStreetKey].string
    descriptionValue = json[kAllFeedDataDescriptionValueKey].string
    disclaimer = json[kAllFeedDataDisclaimerKey].string
    priority = json[kAllFeedDataPriorityKey].string
    addedDate = json[kAllFeedDataAddedDateKey].string
    isDeleted = json[kAllFeedDataIsDeletedKey].string
    isPublic = json[kAllFeedDataIsPublicKey].string
    secondaryNumber = json[kAllFeedDataSecondaryNumberKey].string
    primaryNumber = json[kAllFeedDataPrimaryNumberKey].string
    otherImages = json[kAllFeedDataOtherImagesKey].string
    if let items = json[kAllFeedDataChannelsKey].array { channels = items.map { AllFeedChannels(json: $0) } }
    channelId = json[kAllFeedDataChannelIdKey].string
    country = json[kAllFeedDataCountryKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = state { dictionary[kAllFeedDataStateKey] = value }
    if let value = isActive { dictionary[kAllFeedDataIsActiveKey] = value }
    if let value = brandId { dictionary[kAllFeedDataBrandIdKey] = value }
    if let value = totalRating { dictionary[kAllFeedDataTotalRatingKey] = value }
    if let value = wASupportNumber { dictionary[kAllFeedDataWASupportNumberKey] = value }
    if let value = modifiedDate { dictionary[kAllFeedDataModifiedDateKey] = value }
    if let value = userId { dictionary[kAllFeedDataUserIdKey] = value }
    if let value = latitude { dictionary[kAllFeedDataLatitudeKey] = value }
    if let value = fbLink { dictionary[kAllFeedDataFbLinkKey] = value }
    if let value = primaryColor { dictionary[kAllFeedDataPrimaryColorKey] = value }
    if let value = zip { dictionary[kAllFeedDataZipKey] = value }
    if let value = enableRating { dictionary[kAllFeedDataEnableRatingKey] = value }
    if let value = logo { dictionary[kAllFeedDataLogoKey] = value }
    if let value = longitude { dictionary[kAllFeedDataLongitudeKey] = value }
    if let value = isFeatured { dictionary[kAllFeedDataIsFeaturedKey] = value }
    if let value = name { dictionary[kAllFeedDataNameKey] = value }
    if let value = city { dictionary[kAllFeedDataCityKey] = value }
    if let value = email { dictionary[kAllFeedDataEmailKey] = value }
    if let value = totalRatingCount { dictionary[kAllFeedDataTotalRatingCountKey] = value }
    if let value = website { dictionary[kAllFeedDataWebsiteKey] = value }
    if let value = expiryDate { dictionary[kAllFeedDataExpiryDateKey] = value }
    if let value = street { dictionary[kAllFeedDataStreetKey] = value }
    if let value = descriptionValue { dictionary[kAllFeedDataDescriptionValueKey] = value }
    if let value = disclaimer { dictionary[kAllFeedDataDisclaimerKey] = value }
    if let value = priority { dictionary[kAllFeedDataPriorityKey] = value }
    if let value = addedDate { dictionary[kAllFeedDataAddedDateKey] = value }
    if let value = isDeleted { dictionary[kAllFeedDataIsDeletedKey] = value }
    if let value = isPublic { dictionary[kAllFeedDataIsPublicKey] = value }
    if let value = secondaryNumber { dictionary[kAllFeedDataSecondaryNumberKey] = value }
    if let value = primaryNumber { dictionary[kAllFeedDataPrimaryNumberKey] = value }
    if let value = otherImages { dictionary[kAllFeedDataOtherImagesKey] = value }
    if let value = channels { dictionary[kAllFeedDataChannelsKey] = value.map { $0.dictionaryRepresentation() } }
    if let value = channelId { dictionary[kAllFeedDataChannelIdKey] = value }
    if let value = country { dictionary[kAllFeedDataCountryKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.state = aDecoder.decodeObject(forKey: kAllFeedDataStateKey) as? String
    self.isActive = aDecoder.decodeObject(forKey: kAllFeedDataIsActiveKey) as? String
    self.brandId = aDecoder.decodeObject(forKey: kAllFeedDataBrandIdKey) as? String
    self.totalRating = aDecoder.decodeObject(forKey: kAllFeedDataTotalRatingKey) as? String
    self.wASupportNumber = aDecoder.decodeObject(forKey: kAllFeedDataWASupportNumberKey) as? String
    self.modifiedDate = aDecoder.decodeObject(forKey: kAllFeedDataModifiedDateKey) as? String
    self.userId = aDecoder.decodeObject(forKey: kAllFeedDataUserIdKey) as? String
    self.latitude = aDecoder.decodeObject(forKey: kAllFeedDataLatitudeKey) as? String
    self.fbLink = aDecoder.decodeObject(forKey: kAllFeedDataFbLinkKey) as? String
    self.primaryColor = aDecoder.decodeObject(forKey: kAllFeedDataPrimaryColorKey) as? String
    self.zip = aDecoder.decodeObject(forKey: kAllFeedDataZipKey) as? String
    self.enableRating = aDecoder.decodeObject(forKey: kAllFeedDataEnableRatingKey) as? String
    self.logo = aDecoder.decodeObject(forKey: kAllFeedDataLogoKey) as? String
    self.longitude = aDecoder.decodeObject(forKey: kAllFeedDataLongitudeKey) as? String
    self.isFeatured = aDecoder.decodeObject(forKey: kAllFeedDataIsFeaturedKey) as? String
    self.name = aDecoder.decodeObject(forKey: kAllFeedDataNameKey) as? String
    self.city = aDecoder.decodeObject(forKey: kAllFeedDataCityKey) as? String
    self.email = aDecoder.decodeObject(forKey: kAllFeedDataEmailKey) as? String
    self.totalRatingCount = aDecoder.decodeObject(forKey: kAllFeedDataTotalRatingCountKey) as? String
    self.website = aDecoder.decodeObject(forKey: kAllFeedDataWebsiteKey) as? String
    self.expiryDate = aDecoder.decodeObject(forKey: kAllFeedDataExpiryDateKey) as? String
    self.street = aDecoder.decodeObject(forKey: kAllFeedDataStreetKey) as? String
    self.descriptionValue = aDecoder.decodeObject(forKey: kAllFeedDataDescriptionValueKey) as? String
    self.disclaimer = aDecoder.decodeObject(forKey: kAllFeedDataDisclaimerKey) as? String
    self.priority = aDecoder.decodeObject(forKey: kAllFeedDataPriorityKey) as? String
    self.addedDate = aDecoder.decodeObject(forKey: kAllFeedDataAddedDateKey) as? String
    self.isDeleted = aDecoder.decodeObject(forKey: kAllFeedDataIsDeletedKey) as? String
    self.isPublic = aDecoder.decodeObject(forKey: kAllFeedDataIsPublicKey) as? String
    self.secondaryNumber = aDecoder.decodeObject(forKey: kAllFeedDataSecondaryNumberKey) as? String
    self.primaryNumber = aDecoder.decodeObject(forKey: kAllFeedDataPrimaryNumberKey) as? String
    self.otherImages = aDecoder.decodeObject(forKey: kAllFeedDataOtherImagesKey) as? String
    self.channels = aDecoder.decodeObject(forKey: kAllFeedDataChannelsKey) as? [AllFeedChannels]
    self.channelId = aDecoder.decodeObject(forKey: kAllFeedDataChannelIdKey) as? String
    self.country = aDecoder.decodeObject(forKey: kAllFeedDataCountryKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(state, forKey: kAllFeedDataStateKey)
    aCoder.encode(isActive, forKey: kAllFeedDataIsActiveKey)
    aCoder.encode(brandId, forKey: kAllFeedDataBrandIdKey)
    aCoder.encode(totalRating, forKey: kAllFeedDataTotalRatingKey)
    aCoder.encode(wASupportNumber, forKey: kAllFeedDataWASupportNumberKey)
    aCoder.encode(modifiedDate, forKey: kAllFeedDataModifiedDateKey)
    aCoder.encode(userId, forKey: kAllFeedDataUserIdKey)
    aCoder.encode(latitude, forKey: kAllFeedDataLatitudeKey)
    aCoder.encode(fbLink, forKey: kAllFeedDataFbLinkKey)
    aCoder.encode(primaryColor, forKey: kAllFeedDataPrimaryColorKey)
    aCoder.encode(zip, forKey: kAllFeedDataZipKey)
    aCoder.encode(enableRating, forKey: kAllFeedDataEnableRatingKey)
    aCoder.encode(logo, forKey: kAllFeedDataLogoKey)
    aCoder.encode(longitude, forKey: kAllFeedDataLongitudeKey)
    aCoder.encode(isFeatured, forKey: kAllFeedDataIsFeaturedKey)
    aCoder.encode(name, forKey: kAllFeedDataNameKey)
    aCoder.encode(city, forKey: kAllFeedDataCityKey)
    aCoder.encode(email, forKey: kAllFeedDataEmailKey)
    aCoder.encode(totalRatingCount, forKey: kAllFeedDataTotalRatingCountKey)
    aCoder.encode(website, forKey: kAllFeedDataWebsiteKey)
    aCoder.encode(expiryDate, forKey: kAllFeedDataExpiryDateKey)
    aCoder.encode(street, forKey: kAllFeedDataStreetKey)
    aCoder.encode(descriptionValue, forKey: kAllFeedDataDescriptionValueKey)
    aCoder.encode(disclaimer, forKey: kAllFeedDataDisclaimerKey)
    aCoder.encode(priority, forKey: kAllFeedDataPriorityKey)
    aCoder.encode(addedDate, forKey: kAllFeedDataAddedDateKey)
    aCoder.encode(isDeleted, forKey: kAllFeedDataIsDeletedKey)
    aCoder.encode(isPublic, forKey: kAllFeedDataIsPublicKey)
    aCoder.encode(secondaryNumber, forKey: kAllFeedDataSecondaryNumberKey)
    aCoder.encode(primaryNumber, forKey: kAllFeedDataPrimaryNumberKey)
    aCoder.encode(otherImages, forKey: kAllFeedDataOtherImagesKey)
    aCoder.encode(channels, forKey: kAllFeedDataChannelsKey)
    aCoder.encode(channelId, forKey: kAllFeedDataChannelIdKey)
    aCoder.encode(country, forKey: kAllFeedDataCountryKey)
  }

}
