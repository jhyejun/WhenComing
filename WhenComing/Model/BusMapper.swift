//
//  Bus.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 4. 19..
//  Copyright © 2018년 장혜준. All rights reserved.
//

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
    var busRouteType: String? {
        didSet {
            switch busRouteType {
            case "1":
                busRouteType = "공항버스"
            case "2":
                busRouteType = "마을버스"
            case "3":
                busRouteType = "간선버스"
            case "4":
                busRouteType = "지선버스"
            case "5":
                busRouteType = "순환버스"
            case "6":
                busRouteType = "광역버스"
            case "7":
                busRouteType = "인천버스"
            case "8":
                busRouteType = "경기버스"
            case "9":
                busRouteType = "폐지"
            case "0":
                busRouteType = "공용"
            default:
                busRouteType = "버스"
            }
        }
    }
    var firstBusTm: String?
    var firstBusTmLow: [String: String]?
    var lastBusTm: String?
    var lastBusTmLow: [String: String]?
    var length: String?
    var nextBus: String?
    var stBegin: String?
    var stEnd: String?
    var term: String?
    
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
