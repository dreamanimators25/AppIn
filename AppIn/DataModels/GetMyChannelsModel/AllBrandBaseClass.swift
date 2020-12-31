//
//  AllBrandBaseClass.swift
//
//  Created by sameer khan on 30/12/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class AllBrandBaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kAllBrandBaseClassStatusKey: String = "status"
  private let kAllBrandBaseClassDataKey: String = "data"

  // MARK: Properties
  public var status: String?
  public var data: [AllBrandData]?

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
    status = json[kAllBrandBaseClassStatusKey].string
    if let items = json[kAllBrandBaseClassDataKey].array { data = items.map { AllBrandData(json: $0) } }
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = status { dictionary[kAllBrandBaseClassStatusKey] = value }
    if let value = data { dictionary[kAllBrandBaseClassDataKey] = value.map { $0.dictionaryRepresentation() } }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.status = aDecoder.decodeObject(forKey: kAllBrandBaseClassStatusKey) as? String
    self.data = aDecoder.decodeObject(forKey: kAllBrandBaseClassDataKey) as? [AllBrandData]
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(status, forKey: kAllBrandBaseClassStatusKey)
    aCoder.encode(data, forKey: kAllBrandBaseClassDataKey)
  }

}
