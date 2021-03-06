// This file was generated by json2swift. https://github.com/ijoshsmith/json2swift
//
//  Level.swift
//  iList Ambassador
//
//  Created by Adam Woods on 2017-08-15.
//  Copyright © 2017 iList AB. All rights reserved.
//

import Foundation

//
// MARK: - Data Model
//
struct Level: LevelProtocol { // TODO: Rename this struct
    let level1: Bool
    let level2: Bool
    let level3: Bool
    let level4: Bool
    init(level1: Bool, level2: Bool, level3: Bool, level4: Bool) {
        self.level1 = level1
        self.level2 = level2
        self.level3 = level3
        self.level4 = level4
    }
    init?(json: [String: Any]) {
        guard let level1 = json["level1"] as? Bool else { return nil }
        guard let level2 = json["level2"] as? Bool else { return nil }
        guard let level3 = json["level3"] as? Bool else { return nil }
        guard let level4 = json["level4"] as? Bool else { return nil }
        self.init(level1: level1, level2: level2, level3: level3, level4: level4)
    }
}

//
// MARK: - JSON Utilities
//
/// Adopted by a type that can be instantiated from JSON data.
protocol LevelProtocol {
    /// Attempts to configure a new instance of the conforming type with values from a JSON dictionary.
    init?(json: [String: Any])
}

extension LevelProtocol {
    /// Attempts to configure a new instance using a JSON dictionary selected by the `key` argument.
    init?(json: [String: Any], key: String) {
        guard let jsonDictionary = json[key] as? [String: Any] else { return nil }
        self.init(json: jsonDictionary)
    }
    
    /// Attempts to produce an array of instances of the conforming type based on an array in the JSON dictionary.
    /// - Returns: `nil` if the JSON array is missing or if there is an invalid/null element in the JSON array.
    static func createRequiredInstances(from json: [String: Any], arrayKey: String) -> [Self]? {
        guard let jsonDictionaries = json[arrayKey] as? [[String: Any]] else { return nil }
        return createRequiredInstances(from: jsonDictionaries)
    }
    
    /// Attempts to produce an array of instances of the conforming type based on an array of JSON dictionaries.
    /// - Returns: `nil` if there is an invalid/null element in the JSON array.
    static func createRequiredInstances(from jsonDictionaries: [[String: Any]]) -> [Self]? {
        var array = [Self]()
        for jsonDictionary in jsonDictionaries {
            guard let instance = Self.init(json: jsonDictionary) else { return nil }
            array.append(instance)
        }
        return array
    }
    
    /// Attempts to produce an array of instances of the conforming type, or `nil`, based on an array in the JSON dictionary.
    /// - Returns: `nil` if the JSON array is missing, or an array with `nil` for each invalid/null element in the JSON array.
    static func createOptionalInstances(from json: [String: Any], arrayKey: String) -> [Self?]? {
        guard let array = json[arrayKey] as? [Any] else { return nil }
        return createOptionalInstances(from: array)
    }
    
    /// Attempts to produce an array of instances of the conforming type, or `nil`, based on an array.
    /// - Returns: An array of instances of the conforming type and `nil` for each invalid/null element in the source array.
    static func createOptionalInstances(from array: [Any]) -> [Self?] {
        return array.map { item in
            if let jsonDictionary = item as? [String: Any] {
                return Self.init(json: jsonDictionary)
            }
            else {
                return nil
            }
        }
    }
}
