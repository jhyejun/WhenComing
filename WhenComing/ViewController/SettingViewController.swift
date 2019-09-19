//
//  SettingViewController.swift
//  WhenComing
//
//  Created by 장혜준 on 19/09/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import UIKit

class SettingViewController: HJViewController {
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
            homeButton.setImage(UIImage(named: "icon_home"), for: .normal)
            
            $0.addSubviews([backButton, homeButton])
        }
    }
}
