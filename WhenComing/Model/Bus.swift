//
//  Bus.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 4. 19..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import Foundation
import UIKit

struct Bus {
    var time: String
    var type: BusType
    var status: BusStatus
    
    init(data: Dictionary<String, Any>) {
        time = data["time"] as! String
        type = data["type"] as! BusType
        status = data["status"] as! BusStatus
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
