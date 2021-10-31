//
//  Data.swift
//
//  Created by Sameer Khan on 16/02/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class AboutData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kDataStateKey: String = "state"
  private let kDataIsActiveKey: String = "isActive"
  private let kDataCreatedDateKey: String = "createdDate"
  private let kDataBrandIdKey: String = "brandId"
  private let kDataTotalRatingKey: String = "totalRating"
  private let kDataWASupportNumberKey: String = "WASupportNumber"
  private let kDataModifiedDateKey: String = "modifiedDate"
  private let kDataCategoryKey: String = "category"
  private let kDataColorKey: String = "color"
  private let kDataLatitudeKey: String = "latitude"
  private let kDataFbLinkKey: String = "fbLink"
  private let kDataPrimaryColorKey: String = "primaryColor"
  private let kDataInternalIdentifierKey: String = "id"
  private let kDataZipKey: String = "zip"
  private let kDataEnableRatingKey: String = "enableRating"
  private let kDataLogoKey: String = "logo"
  private let kDataLongitudeKey: String = "longitude"
  private let kDataIsFeaturedKey: String = "isFeatured"
  private let kDataNameKey: String = "name"
  private let kDataCityKey: String = "city"
  private let kDataEmailKey: String = "email"
  private let kDataTotalRatingCountKey: String = "totalRatingCount"
  private let kDataWebsiteKey: String = "website"
  private let kDataExpiryDateKey: String = "expiryDate"
  private let kDataStreetKey: String = "street"
  private let kDataDescriptionValueKey: String = "description"
  private let kDataDisclaimerKey: String = "disclaimer"
  private let kDataOver21Key: String = "over21"
  private let kDataPriorityKey: String = "priority"
  private let kDataAddedDateKey: String = "addedDate"
  private let kDataIsDefaultKey: String = "isDefault"
  private let kDataIsDeletedKey: String = "isDeleted"
  private let kDataIsPublicKey: String = "isPublic"
  private let kDataQrCodeKey: String = "qrCode"
  private let kDataSecondaryNumberKey: String = "secondaryNumber"
  private let kDataPrimaryNumberKey: String = "primaryNumber"
  private let kDataOtherImagesKey: String = "otherImages"
  private let kDataAmbaNeedApprovalKey: String = "ambaNeedApproval"
  private let kDataShortCodeKey: String = "shortCode"
  private let kDataCountryKey: String = "country"
  private let kDataBrandNameKey: String = "brand_name"
  private let kDataBrandDescriptionKey: String = "brand_description"
    
    

  // MARK: Properties
  public var state: String?
  public var isActive: String?
  public var createdDate: String?
  public var brandId: String?
  public var totalRating: String?
  public var wASupportNumber: String?
  public var modifiedDate: String?
  public var category: String?
  public var color: String?
  public var latitude: String?
  public var fbLink: String?
  public var primaryColor: String?
  public var internalIdentifier: String?
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
  public var over21: String?
  public var priority: String?
  public var addedDate: String?
  public var isDefault: String?
  public var isDeleted: String?
  public var isPublic: String?
  public var qrCode: String?
  public var secondaryNumber: String?
  public var primaryNumber: String?
  public var otherImages: String?
  public var ambaNeedApproval: String?
  public var shortCode: String?
  public var country: String?
  public var brandName: String?
  public var brandDescription: String?
      

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
    state = json[kDataStateKey].string
    isActive = json[kDataIsActiveKey].string
    createdDate = json[kDataCreatedDateKey].string
    brandId = json[kDataBrandIdKey].string
    totalRating = json[kDataTotalRatingKey].string
    wASupportNumber = json[kDataWASupportNumberKey].string
    modifiedDate = json[kDataModifiedDateKey].string
    category = json[kDataCategoryKey].string
    color = json[kDataColorKey].string
    latitude = json[kDataLatitudeKey].string
    fbLink = json[kDataFbLinkKey].string
    primaryColor = json[kDataPrimaryColorKey].string
    internalIdentifier = json[kDataInternalIdentifierKey].string
    zip = json[kDataZipKey].string
    enableRating = json[kDataEnableRatingKey].string
    logo = json[kDataLogoKey].string
    longitude = json[kDataLongitudeKey].string
    isFeatured = json[kDataIsFeaturedKey].string
    name = json[kDataNameKey].string
    city = json[kDataCityKey].string
    email = json[kDataEmailKey].string
    totalRatingCount = json[kDataTotalRatingCountKey].string
    website = json[kDataWebsiteKey].string
    expiryDate = json[kDataExpiryDateKey].string
    street = json[kDataStreetKey].string
    descriptionValue = json[kDataDescriptionValueKey].string
    disclaimer = json[kDataDisclaimerKey].string
    over21 = json[kDataOver21Key].string
    priority = json[kDataPriorityKey].string
    addedDate = json[kDataAddedDateKey].string
    isDefault = json[kDataIsDefaultKey].string
    isDeleted = json[kDataIsDeletedKey].string
    isPublic = json[kDataIsPublicKey].string
    qrCode = json[kDataQrCodeKey].string
    secondaryNumber = json[kDataSecondaryNumberKey].string
    primaryNumber = json[kDataPrimaryNumberKey].string
    otherImages = json[kDataOtherImagesKey].string
    ambaNeedApproval = json[kDataAmbaNeedApprovalKey].string
    shortCode = json[kDataShortCodeKey].string
    country = json[kDataCountryKey].string
    brandName = json[kDataBrandNameKey].string
    brandDescription = json[kDataBrandDescriptionKey].string
    
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = state { dictionary[kDataStateKey] = value }
    if let value = isActive { dictionary[kDataIsActiveKey] = value }
    if let value = createdDate { dictionary[kDataCreatedDateKey] = value }
    if let value = brandId { dictionary[kDataBrandIdKey] = value }
    if let value = totalRating { dictionary[kDataTotalRatingKey] = value }
    if let value = wASupportNumber { dictionary[kDataWASupportNumberKey] = value }
    if let value = modifiedDate { dictionary[kDataModifiedDateKey] = value }
    if let value = category { dictionary[kDataCategoryKey] = value }
    if let value = color { dictionary[kDataColorKey] = value }
    if let value = latitude { dictionary[kDataLatitudeKey] = value }
    if let value = fbLink { dictionary[kDataFbLinkKey] = value }
    if let value = primaryColor { dictionary[kDataPrimaryColorKey] = value }
    if let value = internalIdentifier { dictionary[kDataInternalIdentifierKey] = value }
    if let value = zip { dictionary[kDataZipKey] = value }
    if let value = enableRating { dictionary[kDataEnableRatingKey] = value }
    if let value = logo { dictionary[kDataLogoKey] = value }
    if let value = longitude { dictionary[kDataLongitudeKey] = value }
    if let value = isFeatured { dictionary[kDataIsFeaturedKey] = value }
    if let value = name { dictionary[kDataNameKey] = value }
    if let value = city { dictionary[kDataCityKey] = value }
    if let value = email { dictionary[kDataEmailKey] = value }
    if let value = totalRatingCount { dictionary[kDataTotalRatingCountKey] = value }
    if let value = website { dictionary[kDataWebsiteKey] = value }
    if let value = expiryDate { dictionary[kDataExpiryDateKey] = value }
    if let value = street { dictionary[kDataStreetKey] = value }
    if let value = descriptionValue { dictionary[kDataDescriptionValueKey] = value }
    if let value = disclaimer { dictionary[kDataDisclaimerKey] = value }
    if let value = over21 { dictionary[kDataOver21Key] = value }
    if let value = priority { dictionary[kDataPriorityKey] = value }
    if let value = addedDate { dictionary[kDataAddedDateKey] = value }
    if let value = isDefault { dictionary[kDataIsDefaultKey] = value }
    if let value = isDeleted { dictionary[kDataIsDeletedKey] = value }
    if let value = isPublic { dictionary[kDataIsPublicKey] = value }
    if let value = qrCode { dictionary[kDataQrCodeKey] = value }
    if let value = secondaryNumber { dictionary[kDataSecondaryNumberKey] = value }
    if let value = primaryNumber { dictionary[kDataPrimaryNumberKey] = value }
    if let value = otherImages { dictionary[kDataOtherImagesKey] = value }
    if let value = ambaNeedApproval { dictionary[kDataAmbaNeedApprovalKey] = value }
    if let value = shortCode { dictionary[kDataShortCodeKey] = value }
    if let value = country { dictionary[kDataCountryKey] = value }
    if let value = country { dictionary[kDataBrandNameKey] = value }
    if let value = country { dictionary[kDataBrandDescriptionKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.state = aDecoder.decodeObject(forKey: kDataStateKey) as? String
    self.isActive = aDecoder.decodeObject(forKey: kDataIsActiveKey) as? String
    self.createdDate = aDecoder.decodeObject(forKey: kDataCreatedDateKey) as? String
    self.brandId = aDecoder.decodeObject(forKey: kDataBrandIdKey) as? String
    self.totalRating = aDecoder.decodeObject(forKey: kDataTotalRatingKey) as? String
    self.wASupportNumber = aDecoder.decodeObject(forKey: kDataWASupportNumberKey) as? String
    self.modifiedDate = aDecoder.decodeObject(forKey: kDataModifiedDateKey) as? String
    self.category = aDecoder.decodeObject(forKey: kDataCategoryKey) as? String
    self.color = aDecoder.decodeObject(forKey: kDataColorKey) as? String
    self.latitude = aDecoder.decodeObject(forKey: kDataLatitudeKey) as? String
    self.fbLink = aDecoder.decodeObject(forKey: kDataFbLinkKey) as? String
    self.primaryColor = aDecoder.decodeObject(forKey: kDataPrimaryColorKey) as? String
    self.internalIdentifier = aDecoder.decodeObject(forKey: kDataInternalIdentifierKey) as? String
    self.zip = aDecoder.decodeObject(forKey: kDataZipKey) as? String
    self.enableRating = aDecoder.decodeObject(forKey: kDataEnableRatingKey) as? String
    self.logo = aDecoder.decodeObject(forKey: kDataLogoKey) as? String
    self.longitude = aDecoder.decodeObject(forKey: kDataLongitudeKey) as? String
    self.isFeatured = aDecoder.decodeObject(forKey: kDataIsFeaturedKey) as? String
    self.name = aDecoder.decodeObject(forKey: kDataNameKey) as? String
    self.city = aDecoder.decodeObject(forKey: kDataCityKey) as? String
    self.email = aDecoder.decodeObject(forKey: kDataEmailKey) as? String
    self.totalRatingCount = aDecoder.decodeObject(forKey: kDataTotalRatingCountKey) as? String
    self.website = aDecoder.decodeObject(forKey: kDataWebsiteKey) as? String
    self.expiryDate = aDecoder.decodeObject(forKey: kDataExpiryDateKey) as? String
    self.street = aDecoder.decodeObject(forKey: kDataStreetKey) as? String
    self.descriptionValue = aDecoder.decodeObject(forKey: kDataDescriptionValueKey) as? String
    self.disclaimer = aDecoder.decodeObject(forKey: kDataDisclaimerKey) as? String
    self.over21 = aDecoder.decodeObject(forKey: kDataOver21Key) as? String
    self.priority = aDecoder.decodeObject(forKey: kDataPriorityKey) as? String
    self.addedDate = aDecoder.decodeObject(forKey: kDataAddedDateKey) as? String
    self.isDefault = aDecoder.decodeObject(forKey: kDataIsDefaultKey) as? String
    self.isDeleted = aDecoder.decodeObject(forKey: kDataIsDeletedKey) as? String
    self.isPublic = aDecoder.decodeObject(forKey: kDataIsPublicKey) as? String
    self.qrCode = aDecoder.decodeObject(forKey: kDataQrCodeKey) as? String
    self.secondaryNumber = aDecoder.decodeObject(forKey: kDataSecondaryNumberKey) as? String
    self.primaryNumber = aDecoder.decodeObject(forKey: kDataPrimaryNumberKey) as? String
    self.otherImages = aDecoder.decodeObject(forKey: kDataOtherImagesKey) as? String
    self.ambaNeedApproval = aDecoder.decodeObject(forKey: kDataAmbaNeedApprovalKey) as? String
    self.shortCode = aDecoder.decodeObject(forKey: kDataShortCodeKey) as? String
    self.country = aDecoder.decodeObject(forKey: kDataCountryKey) as? String
    self.brandName = aDecoder.decodeObject(forKey: kDataBrandNameKey) as? String
    self.brandDescription = aDecoder.decodeObject(forKey: kDataBrandDescriptionKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(state, forKey: kDataStateKey)
    aCoder.encode(isActive, forKey: kDataIsActiveKey)
    aCoder.encode(createdDate, forKey: kDataCreatedDateKey)
    aCoder.encode(brandId, forKey: kDataBrandIdKey)
    aCoder.encode(totalRating, forKey: kDataTotalRatingKey)
    aCoder.encode(wASupportNumber, forKey: kDataWASupportNumberKey)
    aCoder.encode(modifiedDate, forKey: kDataModifiedDateKey)
    aCoder.encode(category, forKey: kDataCategoryKey)
    aCoder.encode(color, forKey: kDataColorKey)
    aCoder.encode(latitude, forKey: kDataLatitudeKey)
    aCoder.encode(fbLink, forKey: kDataFbLinkKey)
    aCoder.encode(primaryColor, forKey: kDataPrimaryColorKey)
    aCoder.encode(internalIdentifier, forKey: kDataInternalIdentifierKey)
    aCoder.encode(zip, forKey: kDataZipKey)
    aCoder.encode(enableRating, forKey: kDataEnableRatingKey)
    aCoder.encode(logo, forKey: kDataLogoKey)
    aCoder.encode(longitude, forKey: kDataLongitudeKey)
    aCoder.encode(isFeatured, forKey: kDataIsFeaturedKey)
    aCoder.encode(name, forKey: kDataNameKey)
    aCoder.encode(city, forKey: kDataCityKey)
    aCoder.encode(email, forKey: kDataEmailKey)
    aCoder.encode(totalRatingCount, forKey: kDataTotalRatingCountKey)
    aCoder.encode(website, forKey: kDataWebsiteKey)
    aCoder.encode(expiryDate, forKey: kDataExpiryDateKey)
    aCoder.encode(street, forKey: kDataStreetKey)
    aCoder.encode(descriptionValue, forKey: kDataDescriptionValueKey)
    aCoder.encode(disclaimer, forKey: kDataDisclaimerKey)
    aCoder.encode(over21, forKey: kDataOver21Key)
    aCoder.encode(priority, forKey: kDataPriorityKey)
    aCoder.encode(addedDate, forKey: kDataAddedDateKey)
    aCoder.encode(isDefault, forKey: kDataIsDefaultKey)
    aCoder.encode(isDeleted, forKey: kDataIsDeletedKey)
    aCoder.encode(isPublic, forKey: kDataIsPublicKey)
    aCoder.encode(qrCode, forKey: kDataQrCodeKey)
    aCoder.encode(secondaryNumber, forKey: kDataSecondaryNumberKey)
    aCoder.encode(primaryNumber, forKey: kDataPrimaryNumberKey)
    aCoder.encode(otherImages, forKey: kDataOtherImagesKey)
    aCoder.encode(ambaNeedApproval, forKey: kDataAmbaNeedApprovalKey)
    aCoder.encode(shortCode, forKey: kDataShortCodeKey)
    aCoder.encode(country, forKey: kDataCountryKey)
    aCoder.encode(country, forKey: kDataBrandNameKey)
    aCoder.encode(country, forKey: kDataBrandDescriptionKey)
  }

}
