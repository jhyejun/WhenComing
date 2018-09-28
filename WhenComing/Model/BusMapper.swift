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

struct BusData: Mappable {
    
    var busList: [Bus] = []
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.busList <- map["data"]
    }
    
}

struct Bus: Mappable {
    
    var busRouteId: String?
    var busRouteNm: String?
    var busRouteType: String?
    var firstBusTm: String?
    var firstBusTmLow: [String: String]?
    var lastBusTm: String?
    var lastBusTmLow: [String: String]?
    var length: String?
    var nextBus: String?
    var stBegin: String?
    var stEnd: String?
    var term: String?
    // var type: BusType?
    // var status: BusStatus?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.busRouteId <- map["busRouteId"]
        self.busRouteNm <- map["busRouteNm"]
        self.busRouteType <- map["busRouteType"]
        self.firstBusTm <- map["firstBusTm"]
        self.firstBusTmLow <- map["firstBusTmLow"]
        self.lastBusTm <- map["lastBusTm"]
        self.lastBusTmLow <- map["lastBusTmLow"]
        self.length <- map["length"]
        self.nextBus <- map["nextBus"]
        self.stBegin <- map["stBegin"]
        self.stEnd <- map["stEnd"]
        self.term <- map["term"]
    }
    
}

//enum BusType {
//    case blueBus
//    case greenBus
//    case greenTownBus
//    case yellowBus
//    case redBus
//
//    var busTypeColor: UIColor {
//        switch self {
//        case .blueBus:
//            return UIColor.blue
//        case .greenBus:
//            return UIColor.green
//        case.greenTownBus:
//            return UIColor.green
//        case .yellowBus:
//            return UIColor.yellow
//        case.redBus:
//            return UIColor.red
//        }
//    }
//}
//
//enum BusStatus {
//    case busy
//    case normal
//    case free
//
//    var busStatusImage: UIImage {
//        switch self {
//        case .busy:
//            return UIImage(named: "")!
//        case .normal:
//            return UIImage(named: "")!
//        case .free:
//            return UIImage(named: "")!
//        }
//    }
//}
