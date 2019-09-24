//
//  AlarmEmptyView.swift
//  WhenComing
//
//  Created by 장혜준 on 03/09/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit

class AlarmEmptyView: HJView {
    // MARK: - UI Property
    private let iconImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "icon_empty")
    }
    private let guideLabel: UILabel = UILabel().then {
        $0.text = "버스 도착시간이 알고싶다면\n알람을 추가해주세요!"
        $0.font = $0.font.withSize(theme().defaultTextSize)
        $0.textColor = theme().defaultTextGrayColor
        $0.numberOfLines = 2
        $0.textAlignment = .center
    }
    
    // MARK: - Initialize Method
    override init() {
        super.init()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PrepareLayout Method
    override func prepareView() {
        addSubviews([iconImageView, guideLabel])
    }
    
    override func prepareConstraints() {
        iconImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().multipliedBy(0.75)
        }
        
        guideLabel.snp.makeConstraints { make in
            make.centerX.equalTo(iconImageView)
            make.top.equalTo(iconImageView.snp.bottom).offset(20)
        }
    }
}
