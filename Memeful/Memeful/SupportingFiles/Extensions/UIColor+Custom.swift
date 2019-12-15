//
//  UIColor+Custom.swift
//  Shelfie
//
//  Created by Jegan on 03/08/17.
//  Copyright © 2017 Lakeba. All rights reserved.
//

//Example usage
//let color = UIColor(red: 0xFF, green: 0xFF, blue: 0xFF, a: 0xFF)
//let color2 = UIColor(argb: 0xFFFFFF)

import Foundation
import UIKit

extension UIColor {
    
    static var appThemeGreen: UIColor{
        return UIColor(rgb: 0x189572)
    }
    
    static var appThemeDark: UIColor{
        return UIColor(rgb: 0x34C759)
    }
    
    static var appThemeColor: UIColor{
        return UIColor(rgb: 0x34C759)
    }
    static var defaultBorderColor: UIColor{
        return UIColor(rgb: 0xD1D1D1)
    }
    
    static var appValidation: UIColor{
        return UIColor(rgb: 0x34C759)
    }
    
    // Override UIColor
    convenience init(red: Int, green: Int, blue: Int, a: CGFloat = 1.0) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: a)
    }
    
    // Create Color
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
}

