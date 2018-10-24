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
            return UIColor.blue
        case "마을버스":
            return UIColor.black
        case "간선버스":
            return UIColor(red: 54, green: 80, blue: 206, alpha: 1)
        case "지선버스":
            return UIColor(red: 86, green: 214, blue: 0, alpha: 1)
        case "순환버스":
            return UIColor.black
        case "광역버스":
            return UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        case "인천버스":
            return UIColor.blue
        case "경기버스":
            return UIColor.blue
        case "폐지":
            return UIColor.gray
        case "공용":
            return UIColor.blue
        default: // "버스"
            return UIColor.blue
        }
    }
    
}
