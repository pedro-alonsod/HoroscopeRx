//
//  DataValidator.swift
//  HoroscopeRx
//
//  Created by Pedro Alonso on 5/21/18.
//  Copyright © 2018 Pedro Alonso. All rights reserved.
//

import Foundation
import RxSwift
//import RE
class DataValidator {
    class func validName(name: String) -> Bool {
        if let regex = try? NSRegularExpression(pattern: "^\\w+(\\w+.?)*$", options: .caseInsensitive) {
            return name.lengthOfBytes(using: .utf8) > 2 && regex.matches(in: name, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange(location: 0, length: name.lengthOfBytes(using: String.Encoding.utf8))).count > 0
        }
        return false
    }
    
    class func validEmail(email: String) -> Bool {
        if let regex = try? NSRegularExpression(pattern: "^\\S+@\\S+\\.\\S+$", options: .caseInsensitive) {
            return email.lengthOfBytes(using: .utf8) > 2 && regex.matches(in: email, options: NSRegularExpression.MatchingOptions.reportProgress, range: NSRange(location: 0, length: email.lengthOfBytes(using: String.Encoding.utf8))).count > 0
        }
        return false
    }
} // End DataValidator
