//
//  NSObject+ext.swift
//  MilitaryTO
//
//  Created by 장혜준 on 15/03/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

extension NSObject {
    class var className: String {
        return String(describing: self)
    }
    
    var className: String {
        return type(of: self).className
    }
    
    var propertyNames: [String] {
        return Mirror(reflecting: self).children.compactMap { $0.label }
    }
    
    var propertyValues: [Any] {
        return Mirror(reflecting: self).children.compactMap { $0.value }
    }
}
