//
//  AlarmEmptyCollectionViewCell.swift
//  WhenComing
//
//  Created by 장혜준 on 05/09/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit

class AlarmEmptyCollectionViewCell: HJCollectionViewCell {
    // MARK: - Constatnt
    struct Constant {
        // CollectionViewCell
        static let cellBorderColor: UIColor = .rgba(155, 164, 211, 0.6)
        static let cellBorderWidth: CGFloat = 1
        static let cellCornerRadius: CGFloat = 10
        
        static let plusImageName: String = "icon_plusLarge"
        static let descLabelText: String = "알람 추가하기"
        
        static let plusImageViewTopInset: CGFloat = 36
        static let plusImageViewWidthRatio: CGFloat = 0.4625
        static let plusImageViewHeightRatio: CGFloat = 0.411
        static let descLabelTopOffset: CGFloat = 15
        static let descLabelLeadingInset: CGFloat = 10
    }
    
    // MARK: - UI Property
    private let plusImageView: UIImageView = UIImageView().then {
        $0.image = UIImage(named: AlarmEmptyCollectionViewCell.Constant.plusImageName)
    }
    private let descLabel: UILabel = UILabel().then {
        $0.text = AlarmEmptyCollectionViewCell.Constant.descLabelText
        $0.font = $0.font.withSize(theme().defaultTextSize)
        $0.textColor = theme().defaultTextGrayColor
        $0.textAlignment = .center
    }
    
    // MARK: - Initialize Method
    override init(frame: CGRect) {
        super.init(frame: .zero)
        
        setBorder(color: AlarmEmptyCollectionViewCell.Constant.cellBorderColor, width: AlarmEmptyCollectionViewCell.Constant.cellBorderWidth)
        setCornerRadius(AlarmEmptyCollectionViewCell.Constant.cellCornerRadius)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - PrepareLayout Method
    override func prepareView() {
        addSubviews([plusImageView, descLabel])
    }
    
    override func prepareConstraints() {
        plusImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(AlarmEmptyCollectionViewCell.Constant.plusImageViewTopInset)
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().multipliedBy(AlarmEmptyCollectionViewCell.Constant.plusImageViewWidthRatio)
            make.height.equalToSuperview().multipliedBy(AlarmEmptyCollectionViewCell.Constant.plusImageViewHeightRatio)
        }
        
        descLabel.snp.makeConstraints { make in
            make.top.equalTo(plusImageView.snp.bottom).offset(AlarmEmptyCollectionViewCell.Constant.descLabelTopOffset)
            make.leading.trailing.equalToSuperview().inset(AlarmEmptyCollectionViewCell.Constant.descLabelLeadingInset)
            make.centerX.equalTo(plusImageView)
        }
    }
}
