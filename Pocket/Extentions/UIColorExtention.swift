//
//  UIColorExtention.swift
//  Pocket
//
//  Created by Danielle Gomes on 2020-01-31.
//  Copyright © 2020 Danielle Gomes. All rights reserved.
//

import Foundation

import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
    
    static var backgroundBlue: UIColor {
        return UIColor(red: 0x95, green: 0xC9, blue: 0xF5)
    }
    
    static var dayWeekMonthBlue: UIColor {
        return UIColor(red: 0x57, green: 0x81, blue: 0xA3)
    }
    
    static var lettersBlue: UIColor {
        return UIColor(red: 0x6F, green: 0xA7, blue: 0xF4)
    }
    
    static var lettersRed: UIColor {
        return UIColor(red: 0xF4, green: 0x6F, blue: 0x6F)
    }
    
    static var ligthBrownButtonBackgorund: UIColor {
        return UIColor(red: 0xF4, green: 0xE8, blue: 0xDC)
    }
    
}
