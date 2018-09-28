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
                return
            }
        }
    }
    
    static func getArrivalInfo() {
        
    }
    
}
