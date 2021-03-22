//
//  String+Extensions.swift
//  iList Ambassador
//
//  Created by Mathias Palm on 2016-05-17.
//  Copyright © 2016 iList AB. All rights reserved.
//

import UIKit

extension String {
    
    func replace(_ string: String, replacement: String) -> String {
        return replacingOccurrences(of: string, with: replacement, options: NSString.CompareOptions.literal, range: nil)
    }
    
    func removeWhitespace() -> String {
        return replace(" ", replacement: "")
    }
    
    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        
        return ceil(boundingBox.height)
    }
        
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
 
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func convertToDateFormate(current: String, convertTo: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = current
        guard let date = dateFormatter.date(from: self) else {
            return self
        }
        dateFormatter.dateFormat = convertTo
        return  dateFormatter.string(from: date)
    }
    
    /*
    public func getHtml2AttributedString(font: UIFont?) -> NSAttributedString? {
        
//            guard let font = font else {
//                return html2AttributedString
//            }

        let modifiedString = "<style>body{font-family: '\(fontNameMedium)'; font-size:\(font?.pointSize ?? 15)px;}</style>\(self)";

            guard let data = modifiedString.data(using: .utf8) else {
                return nil
            }

            do {
                return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding:String.Encoding.utf8.rawValue], documentAttributes: nil)
            }
            catch {
                print(error)
                return nil
            }
        
        }
    */
    
}
