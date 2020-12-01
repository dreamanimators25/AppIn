//
//  RegisterBaseClass.swift
//
//  Created by sameer khan on 28/11/20
//  Copyright (c) . All rights reserved.
//

import Foundation
import SwiftyJSON

public class RegisterBaseClass: NSCoding {

  // MARK: Declaration for string constants to be used to decode and also serialize.
  private let kRegisterBaseClassStatusKey: String = "status"
  private let kRegisterBaseClassDataKey: String = "data"
  private let kRegisterBaseClassMsgKey: String = "msg"

  // MARK: Properties
  public var status: String?
  public var data: RegisterData?
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
    status = json[kRegisterBaseClassStatusKey].string
    data = RegisterData(json: json[kRegisterBaseClassDataKey])
    msg = json[kRegisterBaseClassMsgKey].string
  }

  /**
   Generates description of the object in the form of a NSDictionary.
   - returns: A Key value pair containing all valid values in the object.
  */
  public func dictionaryRepresentation() -> [String: Any] {
    var dictionary: [String: Any] = [:]
    if let value = status { dictionary[kRegisterBaseClassStatusKey] = value }
    if let value = data { dictionary[kRegisterBaseClassDataKey] = value.dictionaryRepresentation() }
    if let value = msg { dictionary[kRegisterBaseClassMsgKey] = value }
    return dictionary
  }

  // MARK: NSCoding Protocol
  required public init(coder aDecoder: NSCoder) {
    self.status = aDecoder.decodeObject(forKey: kRegisterBaseClassStatusKey) as? String
    self.data = aDecoder.decodeObject(forKey: kRegisterBaseClassDataKey) as? RegisterData
    self.msg = aDecoder.decodeObject(forKey: kRegisterBaseClassMsgKey) as? String
  }

  public func encode(with aCoder: NSCoder) {
    aCoder.encode(status, forKey: kRegisterBaseClassStatusKey)
    aCoder.encode(data, forKey: kRegisterBaseClassDataKey)
    aCoder.encode(msg, forKey: kRegisterBaseClassMsgKey)
  }

}
