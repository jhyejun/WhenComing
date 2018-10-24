//
//  APIManager.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 8. 20..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import Alamofire
import AlamofireObjectMapper

struct APIManager: APIService {
    
    static func getBusStopList(query: String, _ completion: @escaping (DataResponse<BusStopData>) -> Void) {
        guard let encodeString: String = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("Failed Encode [getBusStopList] : \(query)")
            return
        }
        let urlString: String = self.url("/seoul/" + encodeString)

        Alamofire.request(urlString, method: .get).validate(statusCode: 200 ..< 500).responseObject { (response: DataResponse<BusStopData>) in
            switch response.result {
            case .success:
                completion(response)
                
            case .failure(let error):
                print("Failed Request [getBusStopList] : \(error)")
                print("Failed Request [getBusStopList URL] : \(urlString)")
                return
            }
        }
    }
    
    static func getBusList(arsId: String, _ completion: @escaping (DataResponse<BusData>) -> Void) {
        let urlString: String = self.url("/seoul/list/" + arsId)
        
        Alamofire.request(urlString, method: .get).validate(statusCode: 200 ..< 500).responseObject { (response: DataResponse<BusData>) in
            switch response.result {
            case .success:
                completion(response)
                
            case .failure(let error):
                print("Failed Request [getBusList] : \(error)")
                print("Failed Request [getBusList URL] : \(urlString)")
                return
            }
        }
    }
    
    static func getArrivalInfo(arsId: String, busRouteName: String, _ completion: @escaping (DataResponse<ArrivalInfo>) -> Void) {
        let urlString: String = self.url("/seoul/\(arsId)/\(busRouteName)")
        
        Alamofire.request(urlString, method: .get).validate(statusCode: 200 ..< 500).responseObject { (response: DataResponse<ArrivalInfo>) in
            switch response.result {
            case .success:
                completion(response)
                
            case .failure(let error):
                print("Failed Request [getArrivalInfo] : \(error)")
                print("Failed Request [getArrivalInfo URL] : \(urlString)")
                return
            }
        }
    }
    
    
    static func registerAlarm(arsId: String, busRouteId: String, busRouteName: String, alarmTime: String, alarmDay: String, _ completion: @escaping (DataResponse<Any>) -> Void) {
        let urlString: String = self.url("/alarm")
        
        let parameters: Parameters = [
            "arsId" : arsId,
            "busRouteId" : busRouteId,
            "bus" : busRouteName,
            "alarm_time" : alarmTime,
            "day" : alarmDay,
            "device_id" : uuid
        ]
        
        Alamofire.request(urlString, method: .post, parameters: parameters).validate(statusCode: 200 ..< 500).responseJSON { resp in
            switch resp.result {
            case .success:
                completion(resp)
                
            case .failure(let error):
                print("Failed Request [registerAlarm] : \(error)")
                print("Failed Request [registerAlarm Parameter] : \(parameters)")
                return
            }
        }
    }
    
    static func updateAlarm(alarmId: String, arsId: String, busRouteId: String, busRouteName: String, alarmTime: String, alarmDay: String, _ completion: @escaping (DataResponse<Any>) -> Void) {
        let urlString: String = self.url("/update")
        
        let parameters: Parameters = [
            "id" : alarmId,
            "arsId" : arsId,
            "busRouteId" : busRouteId,
            "bus" : busRouteName,
            "alarm_time" : alarmTime,
            "day" : alarmDay,
            "device_id" : uuid
        ]
        
        Alamofire.request(urlString, method: .post, parameters: parameters).validate(statusCode: 200 ..< 500).responseJSON { (resp) in
            switch resp.result {
            case .success:
                completion(resp)
                
            case .failure(let error):
                print("Failed Request [updateAlarm] : \(error)")
                print("Failed Request [updateAlarm Parameter] : \(parameters)")
                return
            }
        }
    }
    
    static func deleteAlarm(alarmId: String, _ completion: @escaping (DataResponse<Any>) -> Void) {
        let urlString: String = self.url("/destroy/\(alarmId)")
        
        Alamofire.request(urlString, method: .delete).validate(statusCode: 200 ..< 500).responseJSON { (resp) in
            switch resp.result {
            case .success:
                completion(resp)
                
            case .failure(let error):
                print("Failed Request [deleteAlarm] : \(error)")
                print("Failed Request [deleteAlarm URL] : \(urlString)")
                return
            }
        }
    }
    
    static func getAlarm(deviceId: String, alarmId: String, _ completion: @escaping (DataResponse<AlarmData>) -> Void) {
        let urlString: String = self.url("/alarm/\(deviceId)/\(alarmId)")
        
        Alamofire.request(urlString, method: .get).validate(statusCode: 200 ..< 500).responseObject { (response: DataResponse<AlarmData>) in
            switch response.result {
            case .success:
                completion(response)
                
            case .failure(let error):
                print("Failed Request [getAlarm] : \(error)")
                print("Failed Request [getAlarm URL] : \(urlString)")
                return
            }
        }
    }
    
    static func getAllAlarm(deviceId: String, _ completion: @escaping (DataResponse<AlarmData>) -> Void) {
        let urlString: String = self.url("/list/\(deviceId)")
        
        Alamofire.request(urlString, method: .get).validate(statusCode: 200 ..< 500).responseObject { (response: DataResponse<AlarmData>) in
            switch response.result {
            case .success:
                completion(response)
                
            case .failure(let error):
                print("Failed Request [getAllAlarm] : \(error)")
                print("Failed Request [getAllAlarm URL] : \(urlString)")
                return
            }
        }
    }
    
}
