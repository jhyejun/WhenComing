//
//  SettingTableViewCell.swift
//  WhenComing
//
//  Created by 장혜준 on 19/09/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit

class SettingTableViewCell: HJTableViewCell, Updatable {
    // MARK: - Constatnt
    struct Constant {
        // TableViewCell
        static let cellVerticalInset: CGFloat = 16
        static let cellHorizontalInset: CGFloat = 20
    }
    
    typealias T = Setting
    
    let titleLabel: UILabel = UILabel().then {
        $0.textColor = theme().settingCellTitleTextColor
        $0.font = $0.font.withSize(theme().defaultTextSize)
    }
    let contentLabel: UILabel = UILabel().then {
        $0.textColor = theme().settingCellContentTextColor
        $0.font = $0.font.withSize(theme().defaultTextSize)
    }
    
    // MARK: - Initialize Method
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .default, reuseIdentifier: SettingTableViewCell.reuseIdentifierName)
        
        selectionStyle = .none
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = nil
        contentLabel.text = nil
    }
    
    // MARK: - PrepareLayout
    override func prepareView() {
        super.prepareView()
        
        addSubviews([titleLabel, contentLabel])
    }
    
    override func prepareConstraints() {
        super.prepareConstraints()
        
        titleLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(SettingTableViewCell.Constant.cellVerticalInset)
            make.leading.equalToSuperview().inset(SettingTableViewCell.Constant.cellHorizontalInset)
        }
        
        contentLabel.snp.makeConstraints { make in
            make.top.bottom.equalTo(titleLabel)
            make.trailingMargin.equalToSuperview().inset(SettingTableViewCell.Constant.cellHorizontalInset)
        }
    }
    
    // MARK: - Updatable
    func update(data: Setting) {
        titleLabel.text = data.title
        contentLabel.text = data.content
        accessoryType = data.isDisclosure ? .disclosureIndicator : .none
        
//        if data.isDisclosure {
//            contentLabel.snp.remakeConstraints { make in
//                make.top.bottom.equalTo(titleLabel)
//                make.trailingMargin.equalToSuperview().inset(10)
//            }
//        }
    }
}
