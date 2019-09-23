//
//  SettingViewController.swift
//  WhenComing
//
//  Created by 장혜준 on 19/09/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

private enum SettingList: String, CaseIterable {
    case refresh = "자동 새로고침 간격"
    case infoSource = "정보 제공처"
    case versionInfo = "버전 정보"
    
    var title: String {
        return self.rawValue
    }
}

class SettingViewController: HJViewController {
    private let tableView: UITableView = UITableView(frame: .zero).then {
        $0.backgroundColor = .black
    }
    
    private let dpBag: DisposeBag = DisposeBag()
    
    // MARK: - View LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - return NavigationView Method
    override func getNavigationView() -> UIView {
        return UIView(frame: .zero).then {
            let backButton: UIButton = UIButton(type: .custom)
            let homeButton: UIButton = UIButton(type: .custom)
            
            backButton.setTitle("<", for: .normal)
            backButton.setTitleColor(.black, for: .normal)
            homeButton.setImage(UIImage(named: "icon_home"), for: .normal)
            
            backButton.sizeToFit()
            
            backButton.rx.tap.subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: dpBag)
            homeButton.rx.tap.subscribe(onNext: { [weak self] _ in
                self?.navigationController?.popViewController(animated: true)
            }).disposed(by: dpBag)
            
            $0.addSubviews([backButton, homeButton])
            
            backButton.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(26)
                make.leading.equalToSuperview().offset(18)
                make.bottom.equalToSuperview().inset(21)
            }
            
            homeButton.snp.makeConstraints { make in
                make.top.equalToSuperview().inset(24)
                make.trailing.bottom.equalToSuperview().inset(20)
            }
        }
    }
}

extension SettingViewController: UITableViewDelegate {
    
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SettingList.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}
