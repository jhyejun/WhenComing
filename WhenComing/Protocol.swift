//
//  Protocol.swift
//  WhenComing
//
//  Created by 장혜준 on 03/09/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

protocol Updatable {
    associatedtype T
    
    func update(data: T)
}

protocol PrepareLayout {
    func prepareView()
    func prepareConstraints()
}
