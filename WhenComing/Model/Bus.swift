//
//  Bus.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 4. 19..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import Foundation
import UIKit
import ObjectMapper

struct Bus: Mappable {
    var time: String?
    var type: BusType?
    var status: BusStatus?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.time <- map["time"]
        self.type <- map["type"]
        self.status <- map["status"]
    }
}

enum BusType {
    case blueBus
    case greenBus
    case greenTownBus
    case yellowBus
    case redBus
    
    var busTypeColor: UIColor {
        switch self {
        case .blueBus:
            return UIColor.blue
        case .greenBus:
            return UIColor.green
        case.greenTownBus:
            return UIColor.green
        case .yellowBus:
            return UIColor.yellow
        case.redBus:
            return UIColor.red
        }
    }
}

enum BusStatus {
    case busy
    case normal
    case free
    
    var busStatusImage: UIImage {
        switch self {
        case .busy:
            return UIImage(named: "")!
        case .normal:
            return UIImage(named: "")!
        case .free:
            return UIImage(named: "")!
        }
    }
}
