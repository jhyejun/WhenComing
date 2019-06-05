//
//  APIManager.swift
//  WhenComing
//
//  Created by 장혜준 on 05/06/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation
import Alamofire

class APIManager {
    static let shared: APIManager = APIManager()
    
    func request() {
        
    }
}

func apiManager() -> APIManager {
    return APIManager.shared
}
