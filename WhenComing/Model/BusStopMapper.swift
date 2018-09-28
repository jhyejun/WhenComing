//
//  BusStopDataMapper.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 8. 20..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import ObjectMapper

struct BusStopData: Mappable {
    
    var busStopList: [BusStop] = []
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.busStopList <- map["data"]
    }
    
}


struct BusStop: Mappable {
    
    var arsId: String?
    var stId: String?
    var stNm: String?
    var posX: String?
    var posY: String?
    var tmX: String?
    var tmY: String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.arsId <- map["arsId"]
        self.stId <- map["stId"]
        self.stNm <- map["stNm"]
        self.posX <- map["posX"]
        self.posY <- map["posY"]
        self.tmX <- map["tmX"]
        self.tmY <- map["tmY"]
    }
    
}
