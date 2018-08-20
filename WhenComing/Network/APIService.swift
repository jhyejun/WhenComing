//
//  APIService.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 8. 20..
//  Copyright © 2018년 장혜준. All rights reserved.
//

protocol APIService {
    
}

extension APIService {
    
    static func url(_ path: String) -> String {
        return "http://hyukjin.net" + path
    }
    
}
