//
//  HJViewController.swift
//  WhenComing
//
//  Created by 장혜준 on 05/06/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class HJViewController: UIViewController, PrepareLayout {
    // MARK: - UI Property
    let navigationView: UIView = UIView(frame: .zero).then {
        let settingButton: UIButton = UIButton(type: .custom)
        let searchButton: UIButton = UIButton(type: .custom)
        let plusButton: UIButton = UIButton(type: .custom)
        let titleView: UIView = UIView(frame: .zero).then {
            let iconImageView: UIImageView = UIImageView(image: UIImage(named: "icon_sliceAppIcon"))
            let titleLabel: UILabel = UILabel(frame: .zero)
            
            titleLabel.text = "언제오나"
            
            $0.addSubViews([iconImageView, titleLabel])
            
            iconImageView.snp.makeConstraints { make in
                make.top.leading.bottom.equalToSuperview()
            }
            
            titleLabel.snp.makeConstraints { make in
                make.centerY.equalTo(iconImageView)
                make.leading.equalTo(iconImageView.snp.trailing).offset(7)
                make.trailing.equalToSuperview()
            }
        }
        
        settingButton.setImage(UIImage(named: "icon_setting"), for: .normal)
        searchButton.setImage(UIImage(named: "icon_search"), for: .normal)
        plusButton.setImage(UIImage(named: "icon_plus"), for: .normal)
        
        $0.addSubViews([settingButton, searchButton, plusButton, titleView])
        
        settingButton.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().inset(20)
        }
        
        plusButton.snp.makeConstraints { make in
            make.centerY.equalTo(settingButton)
            make.trailing.equalToSuperview().inset(20)
        }
        
        searchButton.snp.makeConstraints { make in
            make.centerY.equalTo(plusButton)
            make.trailing.equalTo(plusButton.snp.leading).offset(-24)
        }
        
        titleView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    // MARK: - View LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        prepareConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - PrepareLayout Method
    func prepareView() {
        view.addSubViews([navigationView])
    }
    
    func prepareConstraints() {
        navigationView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(65)
        }
    }
}
