//
//  MyChannelModel.swift
//
//  Created by Sameer Khan on 18/05/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class MyChannelModel: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kMyChannelModelMyChanneldataKey: String = "data"
  private let kMyChannelModelStatusKey: String = "status"
  private let kMyChannelModelMsgKey: String = "msg"

  // MARK: Properties
  public var myChanneldata: [MyChanneldata]?
  public var status: String?
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
    if let items = json[kMyChannelModelMyChanneldataKey].array { myChanneldata = items.map { MyChanneldata(json: $0) } }
    status = json[kMyChannelModelStatusKey].string
    msg = json[kMyChannelModelMsgKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = myChanneldata { dictionary[kMyChannelModelMyChanneldataKey] = value.map { $0.dictionaryRepresentation() } }
    if let value = status { dictionary[kMyChannelModelStatusKey] = value }
    if let value = msg { dictionary[kMyChannelModelMsgKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.myChanneldata = aDecoder.decodeObject(forKey: kMyChannelModelMyChanneldataKey) as? [MyChanneldata]
    self.status = aDecoder.decodeObject(forKey: kMyChannelModelStatusKey) as? String
    self.msg = aDecoder.decodeObject(forKey: kMyChannelModelMsgKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(myChanneldata, forKey: kMyChannelModelMyChanneldataKey)
    aCoder.encode(status, forKey: kMyChannelModelStatusKey)
    aCoder.encode(msg, forKey: kMyChannelModelMsgKey)
  }

}