//
//  HJViewController.swift
//  WhenComing
//
//  Created by 장혜준 on 05/06/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class HJViewController: UIViewController, PrepareLayout {
    // MARK: - View LifeCycle Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        prepareView()
        prepareConstraints()
    }
    
    // MARK: - PrepareLayout Method
    func prepareView() { }
    
    func prepareConstraints() { }
}
