//
//  Data.swift
//
//  Created by sameer khan on 19/12/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class NotiData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kDataAddedDateKey: String = "addedDate"
  private let kDataValueKey: String = "value"
  private let kDataIsDeletedKey: String = "isDeleted"
  private let kDataInternalIdentifierKey: String = "id"
  private let kDataIsReadKey: String = "isRead"
  private let kDataIdentityKey: String = "identity"
  private let kDataUserIdKey: String = "userId"
  private let kDataModifiedDateKey: String = "modifiedDate"
  private let kDataTypeKey: String = "type"

  // MARK: Properties
  public var addedDate: String?
  public var value: String?
  public var isDeleted: String?
  public var internalIdentifier: String?
  public var isRead: String?
  public var identity: String?
  public var userId: String?
  public var modifiedDate: String?
  public var type: String?

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
    addedDate = json[kDataAddedDateKey].string
    value = json[kDataValueKey].string
    isDeleted = json[kDataIsDeletedKey].string
    internalIdentifier = json[kDataInternalIdentifierKey].string
    isRead = json[kDataIsReadKey].string
    identity = json[kDataIdentityKey].string
    userId = json[kDataUserIdKey].string
    modifiedDate = json[kDataModifiedDateKey].string
    type = json[kDataTypeKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = addedDate { dictionary[kDataAddedDateKey] = value }
    if let value = value { dictionary[kDataValueKey] = value }
    if let value = isDeleted { dictionary[kDataIsDeletedKey] = value }
    if let value = internalIdentifier { dictionary[kDataInternalIdentifierKey] = value }
    if let value = isRead { dictionary[kDataIsReadKey] = value }
    if let value = identity { dictionary[kDataIdentityKey] = value }
    if let value = userId { dictionary[kDataUserIdKey] = value }
    if let value = modifiedDate { dictionary[kDataModifiedDateKey] = value }
    if let value = type { dictionary[kDataTypeKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.addedDate = aDecoder.decodeObject(forKey: kDataAddedDateKey) as? String
    self.value = aDecoder.decodeObject(forKey: kDataValueKey) as? String
    self.isDeleted = aDecoder.decodeObject(forKey: kDataIsDeletedKey) as? String
    self.internalIdentifier = aDecoder.decodeObject(forKey: kDataInternalIdentifierKey) as? String
    self.isRead = aDecoder.decodeObject(forKey: kDataIsReadKey) as? String
    self.identity = aDecoder.decodeObject(forKey: kDataIdentityKey) as? String
    self.userId = aDecoder.decodeObject(forKey: kDataUserIdKey) as? String
    self.modifiedDate = aDecoder.decodeObject(forKey: kDataModifiedDateKey) as? String
    self.type = aDecoder.decodeObject(forKey: kDataTypeKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(addedDate, forKey: kDataAddedDateKey)
    aCoder.encode(value, forKey: kDataValueKey)
    aCoder.encode(isDeleted, forKey: kDataIsDeletedKey)
    aCoder.encode(internalIdentifier, forKey: kDataInternalIdentifierKey)
    aCoder.encode(isRead, forKey: kDataIsReadKey)
    aCoder.encode(identity, forKey: kDataIdentityKey)
    aCoder.encode(userId, forKey: kDataUserIdKey)
    aCoder.encode(modifiedDate, forKey: kDataModifiedDateKey)
    aCoder.encode(type, forKey: kDataTypeKey)
  }

}
