//
//  Protocol.swift
//  WhenComing
//
//  Created by 장혜준 on 09/10/2018.
//  Copyright © 2018 장혜준. All rights reserved.
//

import Foundation

protocol APIService {
    
}

protocol SendBackDetailData {
    func sendBackBusStopData(id: String, name: String)
    func sendBackBusData(idList: [String], nameList: [String], typeList: [String])
}

protocol SendBackAlarmData {
    func sendBackAlarmData(alarmId: String?, arsId: String, busId: String, busName: String, alarmTime: String, alarmDay: String)
}
