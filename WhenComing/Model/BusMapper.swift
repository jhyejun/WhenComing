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
