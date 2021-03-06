//
//  GetAllNotifications.swift
//
//  Created by sameer khan on 19/12/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class GetAllNotifications: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kGetAllNotificationsStatusKey: String = "status"
  private let kGetAllNotificationsDataKey: String = "data"

  // MARK: Properties
  public var status: String?
  public var data: [GetAllNotificationData]?

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
    status = json[kGetAllNotificationsStatusKey].string
    if let items = json[kGetAllNotificationsDataKey].array { data = items.map { GetAllNotificationData(json: $0) } }
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = status { dictionary[kGetAllNotificationsStatusKey] = value }
    if let value = data { dictionary[kGetAllNotificationsDataKey] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.status = aDecoder.decodeObject(forKey: kGetAllNotificationsStatusKey) as? String
    self.data = aDecoder.decodeObject(forKey: kGetAllNotificationsDataKey) as? [GetAllNotificationData]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(status, forKey: kGetAllNotificationsStatusKey)
    aCoder.encode(data, forKey: kGetAllNotificationsDataKey)
  }

}
