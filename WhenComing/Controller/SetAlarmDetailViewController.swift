//
//  SetAlarmDetailViewController.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 5. 9..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit

class SetAlarmDetailViewController: UIViewController {

    @IBOutlet weak var detailSearchView: UIView!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailSearchTF: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    var isBusStop: Bool = true
    var busStopList = [BusStop]()
    var busList = [BusStop]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        self.detailSearchView.layer.borderWidth = 1
        self.detailSearchView.layer.borderColor = UIColor(red: 187, green: 187, blue: 187, alpha: 1).cgColor
        
        self.detailImageView.image = self.isBusStop ? UIImage(named: "stationIconBlue") : UIImage(named: "busIconBlueRenew")
        
        self.detailSearchTF.delegate = self
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
        APIManager.getBusStop(query: "강남역하나은행") { (resp) in
            guard let value = resp.value?.busStopList else {
                print("")
                return
            }
            
            self.busStopList = value
            self.busList = value
            self.tableView.reloadData()
        }
    }

}

extension SetAlarmDetailViewController: UITextFieldDelegate {
    
}

extension SetAlarmDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount: Int = self.isBusStop ? busStopList.count : busList.count
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SetAlarmDetailTableViewCell", owner: self, options: nil)?.first as! SetAlarmDetailTableViewCell
        cell.selectionStyle = .none
        
        cell.indicatorImageView.image = self.isBusStop ? UIImage(named: "stationIconGray") : UIImage(named: "busIconGrayRenew")
        cell.titleLabel.text = self.isBusStop ? self.busStopList[indexPath.row].name : self.busList[indexPath.row].name
        cell.descLabel.text = self.isBusStop ? self.busStopList[indexPath.row].uniqueId : self.busList[indexPath.row].uniqueId
        
        cell.backgroundColor = UIColor.clear
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
    
}
