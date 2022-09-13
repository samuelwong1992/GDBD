//
//  UIColor + Utilities.swift
//  GDBD
//
//  Created by Samuel Wong on 25/8/2022.
//

import UIKit
import SwiftUI

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
    
    static func colorBetweenColors(color1: UIColor, color2: UIColor, percentage: CGFloat) -> UIColor {
        let percentage = max(min(percentage, 1), 0)
        switch percentage {
        case 0: return color1
        case 1: return color2
        default:
            var (r1, g1, b1, a1): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            var (r2, g2, b2, a2): (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
            guard color1.getRed(&r1, green: &g1, blue: &b1, alpha: &a1) else { return color1 }
            guard color2.getRed(&r2, green: &g2, blue: &b2, alpha: &a2) else { return color2 }

            return UIColor(red: CGFloat(r1 + (r2 - r1) * percentage),
                           green: CGFloat(g1 + (g2 - g1) * percentage),
                           blue: CGFloat(b1 + (b2 - b1) * percentage),
                           alpha: CGFloat(a1 + (a2 - a1) * percentage))
        }
    }
}

extension Color {
    static func colorBetweenColors(color1: Color, color2: Color, percentage: CGFloat) -> Color {
        return Color(uiColor: UIColor.colorBetweenColors(color1: UIColor(color1), color2: UIColor(color2), percentage: percentage))
    }
}
