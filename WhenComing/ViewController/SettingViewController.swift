//
//  SettingViewController.swift
//  WhenComing
//
//  Created by 장혜준 on 17/01/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation
import UIKit

class SettingViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let settingItem = [["자동 새로고침 간격", "위젯 설정"],
                       ["계정정보", "위치정보 이용동의"],
                       ["서비스 이용약관", "위치기반서비스 이용약관", "개인정보 처리방침", "정보 제공처", "버전정보"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
}

extension SettingViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return settingItem.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settingItem[section].count
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return UIScreen.main.bounds.height * 0.0149
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UIScreen.main.bounds.height * 0.0764
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = self.view.backgroundColor
        
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SettingTableViewCell", owner: self, options: nil)?.first as! SettingTableViewCell
        cell.selectionStyle = .none
        cell.titleLabel.text = settingItem[indexPath.section][indexPath.row]
        
        if settingItem[indexPath.section][indexPath.row] == "자동 새로고침 간격" {
            cell.descLabel.text = "30초"
        } else if settingItem[indexPath.section][indexPath.row] == "계정정보" {
            cell.descLabel.text = "계정이름"
        } else if settingItem[indexPath.section][indexPath.row] == "버전정보" {
            cell.descLabel.text = "현재 1.0 / 최신 1.0"
            cell.arrowImageView.isHidden = true
            cell.descLabelTrailingConstraint.constant = 16
        } else {
            cell.descLabel.isHidden = true
        }
        
        if indexPath.row == 0 {
            cell.topSeparatorView.isHidden = false
        }
        
        return cell
    }
}
