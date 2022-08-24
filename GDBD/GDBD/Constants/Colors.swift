//
//  Colors.swift
//  GDBD
//
//  Created by Samuel Wong on 22/8/2022.
//

import SwiftUI
import UIKit

extension Color {
    static var midnightGray = Color(uiColor: UIColor.colourWithHexString("#2c2c2c"))
}

extension UIColor {
    class func colourWithHexString(_ hex: String, alpha: CGFloat = 1.0) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()
        
        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }
        
        if ((cString.count) != 6) {
            return UIColor.gray
        }
        
        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)
        
        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: alpha
        )
    }
}
