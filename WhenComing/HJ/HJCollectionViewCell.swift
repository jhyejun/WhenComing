//
//  HJCollectionViewCell.swift
//  WhenComing
//
//  Created by 장혜준 on 05/09/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit

class HJCollectionViewCell: UICollectionViewCell, PrepareLayout {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .clear
        
        prepareView()
        prepareConstraints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareView() { }
    
    func prepareConstraints() { }
}
