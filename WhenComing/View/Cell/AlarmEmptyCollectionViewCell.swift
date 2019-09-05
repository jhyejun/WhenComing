//
//  AlarmEmptyCollectionViewCell.swift
//  WhenComing
//
//  Created by 장혜준 on 05/09/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit

class AlarmEmptyCollectionViewCell: HJCollectionViewCell {
    private let separatorView: UIView = UIView().then {
        
    }
    private let plusImageView: UIImageView = UIImageView().then {
        
    }
    private let descLabel: UILabel = UILabel().then {
        $0.text = "알람 추가하기"
        $0.font = $0.font.withSize(theme().defaultTextSize)
        $0.textColor = theme().textGrayColor
        $0.textAlignment = .center
    }
    
    override init() {
        super.init()
    }
    
    override func prepareView() {
        addSubViews([separatorView, plusImageView, descLabel])
    }
    
    override func prepareConstraints() {
        separatorView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.height.equalTo(1)
        }
        
        plusImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(36)
            make.leading.trailing.equalToSuperview().inset(10)
            make.centerX.equalToSuperview()
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(plusImageView.snp.bottom).offset(15)
            make.leading.trailing.equalTo(plusImageView)
            make.centerX.equalTo(plusImageView)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
