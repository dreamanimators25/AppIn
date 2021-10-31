//
//  FeedData.swift
//
//  Created by Sameer Khan on 07/10/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class FeedData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kFeedDataStatusKey: String = "status"
  private let kFeedDataDataKey: String = "data"
  private let kFeedDataMsgKey: String = "msg"

  // MARK: Properties
  public var status: String?
  public var data: [fdData]?
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
    status = json[kFeedDataStatusKey].string
    if let items = json[kFeedDataDataKey].array { data = items.map { fdData(json: $0) } }
    msg = json[kFeedDataMsgKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = status { dictionary[kFeedDataStatusKey] = value }
    if let value = data { dictionary[kFeedDataDataKey] = value.map { $0.dictionaryRepresentation() } }
    if let value = msg { dictionary[kFeedDataMsgKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.status = aDecoder.decodeObject(forKey: kFeedDataStatusKey) as? String
    self.data = aDecoder.decodeObject(forKey: kFeedDataDataKey) as? [fdData]
    self.msg = aDecoder.decodeObject(forKey: kFeedDataMsgKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(status, forKey: kFeedDataStatusKey)
    aCoder.encode(data, forKey: kFeedDataDataKey)
    aCoder.encode(msg, forKey: kFeedDataMsgKey)
  }

}
