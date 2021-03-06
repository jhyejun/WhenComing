//
//  HJView.swift
//  WhenComing
//
//  Created by 장혜준 on 03/09/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit

class HJView: UIView, PrepareLayout {
    // MARK: - Initialize Method
    init() {
        super.init(frame: .zero)
        
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
