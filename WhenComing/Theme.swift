//
//  Theme.swift
//  WhenComing
//
//  Created by 장혜준 on 03/09/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit

class Theme {
    private init() { }
    
    static let shared: Theme = Theme()
    
    let defaultTextSize: CGFloat = 15
    
    let textGrayColor: UIColor = .rgb(170, 170, 170)
}

func theme() -> Theme {
    return Theme.shared
}
