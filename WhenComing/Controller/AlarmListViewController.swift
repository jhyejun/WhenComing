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
    
    @IBAction func touchedAddBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "goSetAlarmViewController", sender: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backIndicatorImage = UIImage(named: "nav_back")
        self.navigationController?.navigationBar.backIndicatorTransitionMaskImage = UIImage(named: "nav_back")
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
    
}

extension AlarmListViewController : UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("AlarmListTableViewCell", owner: self, options: nil)?.first as! AlarmListTableViewCell
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 305
    }
    
}
