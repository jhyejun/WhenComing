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

// MARK: = Setting
enum Setting: String, CaseIterable {
    case refresh = "자동 새로고침 간격"
    case infoSource = "정보 제공처"
    case versionInfo = "버전 정보"
    
    var title: String {
        return self.rawValue
    }
    
    var content: String? {
        switch self {
        case .refresh:
            return "30초"
            
        case .infoSource:
            return nil
            
        case .versionInfo:
            return "현재 1.1 / 최신 1.2"
        }
    }
    
    var isDisclosure: Bool {
        switch self {
        case .refresh, .infoSource:
            return true
            
        case .versionInfo:
            return false
        }
    }
}

// MARK: - SettingViewController
class SettingViewController: HJViewController {
    // MARK: - Property
    private let tableView: UITableView = UITableView(frame: .zero).then {
        $0.isScrollEnabled = false
        $0.separatorInset = .zero
    }
    
    private let dpBag: DisposeBag = DisposeBag()
    
    // MARK: - View LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SettingTableViewCell.self, forCellReuseIdentifier: SettingTableViewCell.reuseIdentifierName)
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
                self?.navigationController?.popToRootViewController(animated: true)
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
    
    // MARK: - PrepareLayout
    override func prepareView() {
        super.prepareView()
        
        view.addSubviews([tableView])
    }
    
    override func prepareConstraints() {
        super.prepareConstraints()
        
        if let view = navigationView {
            tableView.snp.makeConstraints { make in
                make.top.equalTo(view.snp.bottom)
                make.leading.trailing.bottom.equalToSuperview()
            }
        } else {
            tableView.snp.makeConstraints { make in
                make.edges.equalToSuperview()
            }
        }
    }
}

extension SettingViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForHeaderInSection section: Int) -> CGFloat {
        return 0.5
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForFooterInSection section: Int) -> CGFloat {
        return 0.5
    }
}

extension SettingViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Setting.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SettingTableViewCell = tableView.dequeueReusableCell(withIdentifier: SettingTableViewCell.reuseIdentifierName) as? SettingTableViewCell else {
            preconditionFailure("\(SettingTableViewCell.className) is failure")
        }
        
        if let data = Setting.allCases[safe: indexPath.row] {
            cell.update(data: data)
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return UIView().then {
            $0.setBorder(color: theme().settingTableSeparatorColor, width: 0.5)
        }
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView().then {
            $0.setBorder(color: theme().settingTableSeparatorColor, width: 0.5)
        }
    }
}
