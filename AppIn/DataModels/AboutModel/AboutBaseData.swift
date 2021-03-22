//
//  AboutBaseData.swift
//
//  Created by Sameer Khan on 16/02/21
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class AboutBaseData: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kAboutBaseDataStatusKey: String = "status"
  private let kAboutBaseDataDataKey: String = "data"

  // MARK: Properties
  public var status: String?
  public var data: AboutData?

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
    status = json[kAboutBaseDataStatusKey].string
    data = AboutData(json: json[kAboutBaseDataDataKey])
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = status { dictionary[kAboutBaseDataStatusKey] = value }
    if let value = data { dictionary[kAboutBaseDataDataKey] = value.dictionaryRepresentation() }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.status = aDecoder.decodeObject(forKey: kAboutBaseDataStatusKey) as? String
    self.data = aDecoder.decodeObject(forKey: kAboutBaseDataDataKey) as? AboutData
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(status, forKey: kAboutBaseDataStatusKey)
    aCoder.encode(data, forKey: kAboutBaseDataDataKey)
  }

}
