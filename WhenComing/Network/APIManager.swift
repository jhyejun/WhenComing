//
//  APIManager.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 8. 20..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import Alamofire

struct APIManager: APIService {
    
    static func getBusStop(text: String) {
        let url = self.url("/seoul/" + text)
        
        // Alamofire.request(url, method: .get, encoding: URLEncoding.default)
    }
    
    static func getBusList() {
        
    }
    
    static func getArrivalInfo() {
        
    }
    
}
