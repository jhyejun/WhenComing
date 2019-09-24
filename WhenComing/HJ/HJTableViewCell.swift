//
//  HJTableViewCell.swift
//  WhenComing
//
//  Created by 장혜준 on 19/09/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit

class HJTableViewCell: UITableViewCell, PrepareLayout {
    // MARK: - Initialize Method
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
        
        prepareView()
        prepareConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PrepareLayout Method
    func prepareView() { }
    
    func prepareConstraints() { }
}
