//
//  AlarmEmptyCollectionViewCell.swift
//  WhenComing
//
//  Created by 장혜준 on 05/09/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit

class AlarmEmptyCollectionViewCell: HJCollectionViewCell {
    // MARK: - UI Property
    private let plusImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: "icon_plusLarge")
    }
    private let descLabel: UILabel = UILabel().then {
        $0.text = "알람 추가하기"
        $0.font = $0.font.withSize(theme().defaultTextSize)
        $0.textColor = theme().textGrayColor
        $0.textAlignment = .center
    }
    
    // MARK: - Initialize Method
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setBorder(color: .rgba(155, 164, 211, 0.6), width: 1)
        setCornerRadius(10)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PrepareLayout Method
    override func prepareView() {
        addSubViews([plusImageView, descLabel])
    }
    
    override func prepareConstraints() {
        plusImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(36)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(0.4625)
            make.height.equalToSuperview().multipliedBy(0.411)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(plusImageView.snp.bottom).offset(15)
            make.leading.trailing.equalToSuperview().inset(10)
            make.centerX.equalTo(plusImageView)
        }
    }
}
