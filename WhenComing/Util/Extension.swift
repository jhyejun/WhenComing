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
        case "1": // 공항버스
            return UIColor(red: 0, green: 160, blue: 233, alpha: 1)
        case "2": // 마을버스
            return UIColor(red: 83, green: 179, blue: 50, alpha: 1)
        case "3": // 간선버스
            return UIColor(red: 0, green: 104, blue: 183, alpha: 1)
        case "4": // 지선버스
            return UIColor(red: 83, green: 179, blue: 50, alpha: 1)
        case "5": // 순환버스
            return UIColor(red: 242, green: 183, blue: 10, alpha: 1)
        case "6": // 광역버스
            return UIColor(red: 230, green: 0, blue: 18, alpha: 1)
        case "7": // 인천버스
            return UIColor(red: 61, green: 91, blue: 171, alpha: 1)
        case "8": // 경기버스
            return UIColor(red: 0, green: 158, blue: 150, alpha: 1)
        case "9": // 폐지
            return UIColor.gray
        case "0": // 공용
            return UIColor(red: 0, green: 104, blue: 183, alpha: 1)
        default: // "버스"
            return UIColor(red: 0, green: 104, blue: 183, alpha: 1)
        }
    }
    
}
