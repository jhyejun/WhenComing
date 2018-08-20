//
//  BusStopDataMapper.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 8. 20..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import ObjectMapper

struct BusStop: Mappable {
    
    var name: String?
    
    init?(map: Map) {
    }
    
    mutating func mapping(map: Map) {
        self.name <- map["name"]
    }
    
}
