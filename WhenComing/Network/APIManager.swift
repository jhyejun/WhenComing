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
    
    static func getBusStop(query: String, _ completion: @escaping (DataResponse<BusStopData>) -> Void) {
        guard let encodeString: String = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("Failed Encode [getBusStop] : \(query)")
            return
        }
        let urlString: String = self.url("/seoul/" + encodeString)

        Alamofire.request(urlString, method: .get, encoding: URLEncoding.default).validate(statusCode: 200 ..< 500).responseObject { (response: DataResponse<BusStopData>) in
            switch response.result {
            case .success:
                completion(response)
                
            case .failure(let error):
                print("Failed Request [getBusStop] : \(error)")
                return
            }
        }
    }
    
    static func getBusList(query: String, _ completion: @escaping (DataResponse<BusStopData>) -> Void) {
        guard let encodeString: String = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("Failed Encode [getBusStop] : \(query)")
            return
        }
        let urlString: String = self.url("/seoul/" + encodeString)
        
        Alamofire.request(urlString, method: .get, encoding: URLEncoding.default).validate(statusCode: 200 ..< 500).responseObject { (response: DataResponse<BusStopData>) in
            switch response.result {
            case .success:
                completion(response)
                
            case .failure(let error):
                print("Failed Request [getBusStop] : \(error)")
                return
            }
        }
    }
    
    static func getArrivalInfo() {
        
    }
    
}
