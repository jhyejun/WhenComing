//
//  Extension.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 4. 26..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, alpha: CGFloat) {
        let floatRed = CGFloat(red) / 255
        let floatGreen = CGFloat(green) / 255
        let floatBlue = CGFloat(blue) / 255
        
        self.init(red: floatRed, green: floatGreen, blue: floatBlue, alpha: alpha)
    }
    
    class func getBusTextColor(busRouteType: String) -> UIColor {
        switch busRouteType {
        case "공항버스":
            return UIColor(red: 0, green: 160, blue: 233, alpha: 1)
        case "마을버스":
            return UIColor(red: 83, green: 179, blue: 50, alpha: 1)
        case "간선버스":
            return UIColor(red: 0, green: 104, blue: 183, alpha: 1)
        case "지선버스":
            return UIColor(red: 83, green: 179, blue: 50, alpha: 1)
        case "순환버스":
            return UIColor(red: 242, green: 183, blue: 10, alpha: 1)
        case "광역버스":
            return UIColor(red: 230, green: 0, blue: 18, alpha: 1)
        case "인천버스":
            return UIColor(red: 61, green: 91, blue: 171, alpha: 1)
        case "경기버스":
            return UIColor(red: 0, green: 158, blue: 150, alpha: 1)
        case "폐지":
            return UIColor.gray
        case "공용":
            return UIColor(red: 0, green: 104, blue: 183, alpha: 1)
        default: // "버스"
            return UIColor(red: 0, green: 104, blue: 183, alpha: 1)
        }
    }
    
}
