//
//  RegisterData.swift
//
//  Created by sameer khan on 28/11/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class RegisterData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kRegisterDataNameKey: String = "name"
  private let kRegisterDataEmailKey: String = "email"
  private let kRegisterDataProfileImageKey: String = "profileImage"
  private let kRegisterDataAddressKey: String = "address"
  private let kRegisterDataLanguageKey: String = "language"
  private let kRegisterDataUserNameKey: String = "userName"
  private let kRegisterDataLastLoginKey: String = "lastLogin"
  private let kRegisterDataDeviceIdKey: String = "deviceId"
  private let kRegisterDataGenderKey: String = "gender"
  private let kRegisterDataDeviceMetaKey: String = "deviceMeta"
  private let kRegisterDataBirthDateKey: String = "birthDate"
  private let kRegisterDataOsKey: String = "os"
  private let kRegisterDataProfileBioKey: String = "profileBio"
  private let kRegisterDataContactNoKey: String = "contactNo"
  private let kRegisterDataPasswordKey: String = "password"
  private let kRegisterDataTimeZoneKey: String = "timeZone"
  private let kRegisterDataBackgroundImageKey: String = "backgroundImage"
  private let kRegisterDataCountryKey: String = "country"
  private let kRegisterDataUserIdKey: String = "id"
  private let kRegisterDataBrandIdKey: String = "brandId"
  private let kRegisterDataOver21Key: String = "over21"
  private let kRegisterDataStatusKey: String = "status"
  private let kRegisterDataIsDeletedKey: String = "isDeleted"
  private let kRegisterDataAgeFeelKey: String = "ageFeel"

  // MARK: Properties
  public var name: String?
  public var email: String?
  public var profileImage: String?
  public var address: String?
  public var language: String?
  public var userName: String?
  public var lastLogin: String?
  public var deviceId: String?
  public var gender: String?
  public var deviceMeta: String?
  public var birthDate: String?
  public var os: String?
  public var profileBio: String?
  public var contactNo: String?
  public var password: String?
  public var timeZone: String?
  public var backgroundImage: String?
  public var country: String?
  public var UserId: String?
  public var brandId: String?
  public var over21: String?
  public var status: String?
  public var isDeleted: String?
  public var ageFeel: String?
    

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
    name = json[kRegisterDataNameKey].string
    email = json[kRegisterDataEmailKey].string
    profileImage = json[kRegisterDataProfileImageKey].string
    address = json[kRegisterDataAddressKey].string
    language = json[kRegisterDataLanguageKey].string
    userName = json[kRegisterDataUserNameKey].string
    lastLogin = json[kRegisterDataLastLoginKey].string
    deviceId = json[kRegisterDataDeviceIdKey].string
    gender = json[kRegisterDataGenderKey].string
    deviceMeta = json[kRegisterDataDeviceMetaKey].string
    birthDate = json[kRegisterDataBirthDateKey].string
    os = json[kRegisterDataOsKey].string
    profileBio = json[kRegisterDataProfileBioKey].string
    contactNo = json[kRegisterDataContactNoKey].string
    password = json[kRegisterDataPasswordKey].string
    timeZone = json[kRegisterDataTimeZoneKey].string
    backgroundImage = json[kRegisterDataBackgroundImageKey].string
    country = json[kRegisterDataCountryKey].string
    UserId = json[kRegisterDataUserIdKey].string
    brandId = json[kRegisterDataBrandIdKey].string
    over21 = json[kRegisterDataOver21Key].string
    status = json[kRegisterDataStatusKey].string
    isDeleted = json[kRegisterDataIsDeletedKey].string
    ageFeel = json[kRegisterDataAgeFeelKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = name { dictionary[kRegisterDataNameKey] = value }
    if let value = email { dictionary[kRegisterDataEmailKey] = value }
    if let value = profileImage { dictionary[kRegisterDataProfileImageKey] = value }
    if let value = address { dictionary[kRegisterDataAddressKey] = value }
    if let value = language { dictionary[kRegisterDataLanguageKey] = value }
    if let value = userName { dictionary[kRegisterDataUserNameKey] = value }
    if let value = lastLogin { dictionary[kRegisterDataLastLoginKey] = value }
    if let value = deviceId { dictionary[kRegisterDataDeviceIdKey] = value }
    if let value = gender { dictionary[kRegisterDataGenderKey] = value }
    if let value = deviceMeta { dictionary[kRegisterDataDeviceMetaKey] = value }
    if let value = birthDate { dictionary[kRegisterDataBirthDateKey] = value }
    if let value = os { dictionary[kRegisterDataOsKey] = value }
    if let value = profileBio { dictionary[kRegisterDataProfileBioKey] = value }
    if let value = contactNo { dictionary[kRegisterDataContactNoKey] = value }
    if let value = password { dictionary[kRegisterDataPasswordKey] = value }
    if let value = timeZone { dictionary[kRegisterDataTimeZoneKey] = value }
    if let value = backgroundImage { dictionary[kRegisterDataBackgroundImageKey] = value }
    if let value = country { dictionary[kRegisterDataCountryKey] = value }
    if let value = UserId { dictionary[kRegisterDataUserIdKey] = value }
    if let value = brandId { dictionary[kRegisterDataBrandIdKey] = value }
    if let value = over21 { dictionary[kRegisterDataOver21Key] = value }
    if let value = status { dictionary[kRegisterDataStatusKey] = value }
    if let value = isDeleted { dictionary[kRegisterDataIsDeletedKey] = value }
    if let value = ageFeel { dictionary[kRegisterDataAgeFeelKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.name = aDecoder.decodeObject(forKey: kRegisterDataNameKey) as? String
    self.email = aDecoder.decodeObject(forKey: kRegisterDataEmailKey) as? String
    self.profileImage = aDecoder.decodeObject(forKey: kRegisterDataProfileImageKey) as? String
    self.address = aDecoder.decodeObject(forKey: kRegisterDataAddressKey) as? String
    self.language = aDecoder.decodeObject(forKey: kRegisterDataLanguageKey) as? String
    self.userName = aDecoder.decodeObject(forKey: kRegisterDataUserNameKey) as? String
    self.lastLogin = aDecoder.decodeObject(forKey: kRegisterDataLastLoginKey) as? String
    self.deviceId = aDecoder.decodeObject(forKey: kRegisterDataDeviceIdKey) as? String
    self.gender = aDecoder.decodeObject(forKey: kRegisterDataGenderKey) as? String
    self.deviceMeta = aDecoder.decodeObject(forKey: kRegisterDataDeviceMetaKey) as? String
    self.birthDate = aDecoder.decodeObject(forKey: kRegisterDataBirthDateKey) as? String
    self.os = aDecoder.decodeObject(forKey: kRegisterDataOsKey) as? String
    self.profileBio = aDecoder.decodeObject(forKey: kRegisterDataProfileBioKey) as? String
    self.contactNo = aDecoder.decodeObject(forKey: kRegisterDataContactNoKey) as? String
    self.password = aDecoder.decodeObject(forKey: kRegisterDataPasswordKey) as? String
    self.timeZone = aDecoder.decodeObject(forKey: kRegisterDataTimeZoneKey) as? String
    self.backgroundImage = aDecoder.decodeObject(forKey: kRegisterDataBackgroundImageKey) as? String
    self.country = aDecoder.decodeObject(forKey: kRegisterDataCountryKey) as? String
    self.UserId = aDecoder.decodeObject(forKey: kRegisterDataUserIdKey) as? String
    self.brandId = aDecoder.decodeObject(forKey: kRegisterDataBrandIdKey) as? String
    self.over21 = aDecoder.decodeObject(forKey: kRegisterDataOver21Key) as? String
    self.status = aDecoder.decodeObject(forKey: kRegisterDataStatusKey) as? String
    self.isDeleted = aDecoder.decodeObject(forKey: kRegisterDataIsDeletedKey) as? String
    self.ageFeel = aDecoder.decodeObject(forKey: kRegisterDataAgeFeelKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(name, forKey: kRegisterDataNameKey)
    aCoder.encode(email, forKey: kRegisterDataEmailKey)
    aCoder.encode(profileImage, forKey: kRegisterDataProfileImageKey)
    aCoder.encode(address, forKey: kRegisterDataAddressKey)
    aCoder.encode(language, forKey: kRegisterDataLanguageKey)
    aCoder.encode(userName, forKey: kRegisterDataUserNameKey)
    aCoder.encode(lastLogin, forKey: kRegisterDataLastLoginKey)
    aCoder.encode(deviceId, forKey: kRegisterDataDeviceIdKey)
    aCoder.encode(gender, forKey: kRegisterDataGenderKey)
    aCoder.encode(deviceMeta, forKey: kRegisterDataDeviceMetaKey)
    aCoder.encode(birthDate, forKey: kRegisterDataBirthDateKey)
    aCoder.encode(os, forKey: kRegisterDataOsKey)
    aCoder.encode(profileBio, forKey: kRegisterDataProfileBioKey)
    aCoder.encode(contactNo, forKey: kRegisterDataContactNoKey)
    aCoder.encode(password, forKey: kRegisterDataPasswordKey)
    aCoder.encode(timeZone, forKey: kRegisterDataTimeZoneKey)
    aCoder.encode(backgroundImage, forKey: kRegisterDataBackgroundImageKey)
    aCoder.encode(country, forKey: kRegisterDataCountryKey)
    aCoder.encode(UserId, forKey: kRegisterDataUserIdKey)
    aCoder.encode(brandId, forKey: kRegisterDataBrandIdKey)
    aCoder.encode(over21, forKey: kRegisterDataOver21Key)
    aCoder.encode(status, forKey: kRegisterDataStatusKey)
    aCoder.encode(isDeleted, forKey: kRegisterDataIsDeletedKey)
    aCoder.encode(ageFeel, forKey: kRegisterDataAgeFeelKey)
  }

}
