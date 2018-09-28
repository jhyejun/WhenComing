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
    @IBOutlet weak var textfieldClearButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var isBusStop: Bool = true
    var arsId: String!
    var stName: String!
    
    var busStopList = [BusStop]()
    var busList = [Bus]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        self.detailSearchView.layer.borderWidth = 1
        self.detailSearchView.layer.borderColor = UIColor(red: 187, green: 187, blue: 187, alpha: 1).cgColor
        
        self.detailImageView.image = self.isBusStop ? UIImage(named: "stationIconBlue") : UIImage(named: "busIconBlueRenew")
        
        self.textfieldClearButton.isHidden = self.isBusStop ? false : true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
        if !self.isBusStop {
            APIManager.getBusList(arsId: "23572") { (resp) in
                guard let value = resp.value?.busList else {
                    print("Failed request in SetAlarmDetailViewController [getBusList] : \(resp)")
                    return
                }
                
                self.busList = value
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        guard let query = detailSearchTF.text else {
            print("Bad Value in SetAlarmDetailViewController [detailSearchTF] : \(detailSearchTF.text!)")
            return
        }
        
        APIManager.getBusStopList(query: query) { (resp) in
            guard let value = resp.value?.busStopList else {
                print("Failed request in SetAlarmDetailViewController [getBusStopList] : \(resp)")
                return
            }
            
            self.busStopList = value
            self.tableView.reloadData()
        }
    }
    
}

extension SetAlarmDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let rowCount: Int = self.isBusStop ? busStopList.count : busList.count
        return rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SetAlarmDetailTableViewCell", owner: self, options: nil)?.first as! SetAlarmDetailTableViewCell
        cell.selectionStyle = .none
        cell.backgroundColor = UIColor.clear
        
        cell.indicatorImageView.image = self.isBusStop ? UIImage(named: "stationIconGray") : UIImage(named: "busIconGrayRenew")
        cell.titleLabel.text = self.isBusStop ? self.busStopList[indexPath.row].stNm : self.busList[indexPath.row].busRouteNm
        cell.descLabel.text = self.isBusStop ? self.busStopList[indexPath.row].arsId : self.busList[indexPath.row].busRouteType
        cell.busAlarmSwitch.isHidden = self.isBusStop ? true : false
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isBusStop {
            self.arsId = self.busStopList[indexPath.row].arsId
            self.stName = self.busStopList[indexPath.row].stNm
        }
    }
    
}
