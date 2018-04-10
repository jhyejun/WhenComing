//
//  ListSetViewController.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 4. 10..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit

class ListSetViewController: UIViewController {

    @IBOutlet weak var listView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.listView.layer.shadowColor = UIColor(red: 12/255, green: 31/255, blue: 120/255, alpha: 0.3).cgColor
        self.listView.layer.shadowOpacity = 1
        self.listView.layer.shadowOffset = CGSize.zero
        self.listView.layer.shadowRadius = 1
        
    }

}
