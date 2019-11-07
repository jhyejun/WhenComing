//
//  HJViewController.swift
//  WhenComing
//
//  Created by 장혜준 on 05/06/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HJViewController: UIViewController, PrepareLayout {
    // MARK: - UI Property
    var navigationView: UIView?
    
    private let dpBag: DisposeBag = DisposeBag()
    
    // MARK: - View LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        navigationView = getNavigationView()
        
        prepareView()
        prepareConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.isHidden = true
    }
    
    // MARK: - return NavigationView Method
    func getNavigationView() -> UIView {
        return UIView(frame: .zero).then { view in
            view.backgroundColor = .white
            
            let settingButton: UIButton = UIButton(type: .custom)
            let searchButton: UIButton = UIButton(type: .custom)
            let plusButton: UIButton = UIButton(type: .custom)
            let titleView: UIView = UIView(frame: .zero).then {
                let iconImageView: UIImageView = UIImageView(image: UIImage(named: "icon_sliceAppIcon"))
                let titleLabel: UILabel = UILabel(frame: .zero)
                
                titleLabel.text = "언제오나"
                
                $0.addSubviews([iconImageView, titleLabel])
                
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
            
            settingButton.rx.tap.subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                let viewController: SettingViewController = SettingViewController()
                self.push(viewController: viewController)
            }).disposed(by: dpBag)
            plusButton.rx.tap.subscribe(onNext: { [weak self] _ in
                guard let self = self else { return }
                let viewController: AlarmSetViewController = AlarmSetViewController()
                self.push(viewController: viewController)
            }).disposed(by: dpBag)
            
            view.addSubviews([settingButton, searchButton, plusButton, titleView])
            
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
    }
    
    // MARK: - PrepareLayout Method
    func prepareView() {
        view.addSubviewOpt(navigationView)
    }
    
    func prepareConstraints() {
        navigationView?.snp.makeConstraints { make in
            make.top.equalTo(view.snp.topMargin)
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(65)
        }
    }
}
