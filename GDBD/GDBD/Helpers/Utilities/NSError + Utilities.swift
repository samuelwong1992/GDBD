//
//  NSError + Utilities.swift
//  GDBD
//
//  Created by Samuel Wong on 22/8/2022.
//

import Foundation

extension NSError {
    static func standardErrorWithString(errorString: String) -> NSError {
        return NSError(domain: Bundle.main.bundleIdentifier!, code: 0, userInfo: [NSLocalizedDescriptionKey : errorString])
    }
    
    static func standardNoDataError() -> Error {
        return NSError.standardErrorWithString(errorString: "No data was returned for this request.")
    }
}
