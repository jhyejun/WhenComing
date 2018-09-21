//
//  APIManager.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 8. 20..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import Alamofire
import ObjectMapper

struct APIManager: APIService {
    
    static func getBusStop(query: String, _ completion: @escaping (DataResponse<String>) -> Void) {
        guard let encodeString: String = query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("Failed Encode [getBusStop] : \(query)")
            return
        }
        let urlString: String = self.url("/seoul/" + encodeString)

        Alamofire.request(urlString, method: .get, encoding: URLEncoding.default).validate(statusCode: 200 ..< 500).responseString { (response) in
            
            switch response.result {
            case .success:
                print(response.value)
                guard let value = BusStopData(JSONString: response.value!) else {
                    print("Failed String to JSON [getBusStop] : \(String(describing: response.value))")
                    return
                }
                print(value)
                // completion(response)
                
            case .failure(let error):
                print("Failed Request [getBusStop] : \(error)")
            }
        }
    }
    
    static func getBusList() {
        
    }
    
    static func getArrivalInfo() {
        
    }
    
}
