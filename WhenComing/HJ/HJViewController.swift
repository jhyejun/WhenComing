//
//  HJViewController.swift
//  WhenComing
//
//  Created by 장혜준 on 25/04/2019.
//  Copyright © 2019 장혜준. All rights reserved.
//

import Foundation

class HJViewController: UIViwController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.topItem?.title = ""
        self.navigationController?.navigationBar.tintColor = .flatBlack
        
        self.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBar.isHidden = false
        self.tabBarController?.tabBar.isHidden = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    func addSubViews(views: [UIView]) {
        views.forEach {
            self.view.addSubview($0)
        }
    }
}
