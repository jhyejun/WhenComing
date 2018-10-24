//
//  ArrivalInfoMapper.swift
//  WhenComing
//
//  Created by 장혜준 on 09/10/2018.
//  Copyright © 2018 장혜준. All rights reserved.
//

import ObjectMapper

struct ArrivalInfo: Mappable {
    
    var adirection: String?
    var arrmsg1: String?
    var arrmsg2: String?
    var arsId: String?
    var busRouteId: String?
    var isFullFlag1: String?
    var isFullFlag2: String?
    var isLast1: String?
    var isLast2: String?
    var lastTm: String?
    var nxtStn: String?
    var congetion: String?
    var nextBus: String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.adirection <- map["adirection"]
        self.arrmsg1 <- map["arrmsg1"]
        self.arrmsg2 <- map["arrmsg2"]
        self.arsId <- map["arsId"]
        self.busRouteId <- map["busRouteId"]
        self.isFullFlag1 <- map["isFullFlag1"]
        self.isFullFlag2 <- map["isFullFlag2"]
        self.isLast1 <- map["isLast1"]
        self.isLast2 <- map["isLast2"]
        self.lastTm <- map["lastTm"]
        self.nxtStn <- map["nxtStn"]
        self.congetion <- map["congetion"]
        self.nextBus <- map["nextBus"]
    }
    
}
