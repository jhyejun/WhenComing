//
//  BusStopDataMapper.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 8. 20..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import ObjectMapper

struct BusStopData: Mappable {
    
    var uniqueId: String?
    var id: String?
    var name: String?
    var posX: String?
    var posY: String?
    var tmX: String?
    var tmY: String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.uniqueId <- map["data"]["arsId"]
        self.id <- map["data"]["stId"]
        self.name <- map["data"]["stNm"]
        self.posX <- map["data"]["posX"]
        self.posY <- map["data"]["posY"]
        self.tmX <- map["data"]["tmX"]
        self.tmY <- map["data"]["tmY"]
    }
    
}
