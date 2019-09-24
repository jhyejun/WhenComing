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

    let defaultTextGrayColor: UIColor = .rgb(170, 170, 170)
    let defaultBackgroundColor: UIColor = .rgb(242, 243, 250)
    
    let settingCellTitleTextColor: UIColor = .rgb(69, 76, 97)
    let settingCellContentTextColor: UIColor = .rgb(155, 155, 155)
    let settingTableSeparatorColor: UIColor = .rgb(214, 217, 230)
}

func theme() -> Theme {
    return Theme.shared
}
