//
//  ListSetViewController.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 4. 10..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit

class AlarmListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.separatorStyle = .none
        
    }
}

extension AlarmListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // let cell = Bundle.main.loadNibNamed("AlarmListNotSetTableViewCell", owner: self, options: nil)?.first as! AlarmListNotSetTableViewCell
        let cell = Bundle.main.loadNibNamed("AlarmListTableViewCell", owner: self, options: nil)?.first as! AlarmListTableViewCell
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
}
