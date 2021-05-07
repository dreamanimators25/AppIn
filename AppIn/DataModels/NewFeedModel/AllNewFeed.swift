//
//  AllNewFeed.swift
//
//  Created by Sameer Khan on 06/05/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class AllNewFeed: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kAllNewFeedStatusKey: String = "status"
  private let kAllNewFeedDataKey: String = "data"
  private let kAllNewFeedMsgKey: String = "msg"

  // MARK: Properties
  public var status: String?
  public var data: [AllNewData]?
  public var msg: String?

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
    status = json[kAllNewFeedStatusKey].string
    if let items = json[kAllNewFeedDataKey].array { data = items.map { AllNewData(json: $0) } }
    msg = json[kAllNewFeedMsgKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = status { dictionary[kAllNewFeedStatusKey] = value }
    if let value = data { dictionary[kAllNewFeedDataKey] = value.map { $0.dictionaryRepresentation() } }
    if let value = msg { dictionary[kAllNewFeedMsgKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.status = aDecoder.decodeObject(forKey: kAllNewFeedStatusKey) as? String
    self.data = aDecoder.decodeObject(forKey: kAllNewFeedDataKey) as? [AllNewData]
    self.msg = aDecoder.decodeObject(forKey: kAllNewFeedMsgKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(status, forKey: kAllNewFeedStatusKey)
    aCoder.encode(data, forKey: kAllNewFeedDataKey)
    aCoder.encode(msg, forKey: kAllNewFeedMsgKey)
  }

}
