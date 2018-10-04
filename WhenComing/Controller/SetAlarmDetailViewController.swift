//
//  SetAlarmDetailViewController.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 5. 9..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit

protocol SendBackDelegate {
    func sendBackBusStopData(id: String, name: String)
    // func sendBackBusData(id: String, name: String)
}

class SetAlarmDetailViewController: UIViewController {

    @IBOutlet weak var detailSearchView: UIView!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailSearchTF: UITextField!
    @IBOutlet weak var textfieldClearButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var completeButton: UIButton!
    
    var delegate: SendBackDelegate?
    
    var isBusStop: Bool = true
    var arsId: String!
    var stName: String!
    var busStopList = [BusStop]()
    var busList = [Bus]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareNavigation()
        self.prepareView()
        self.checkBusStop()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "valueChangedAlarmSwitch"), object: nil, queue: OperationQueue.main) { (noti) in
            
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
            self.busStopList = self.busStopList.filter { $0.arsId != "0" }
            self.tableView.reloadData()
        }
    }
    
    @IBAction func touchedCleanButton(_ sender: UIButton) {
        self.detailSearchTF.text = ""
        self.busStopList.removeAll()
        self.tableView.reloadData()
    }
    
    @IBAction func touchedCompleteButton(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func touchedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func prepareNavigation() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back"), style: .plain, target: self, action: #selector(touchedBackButton))
    }
    
    func prepareView() {
        self.detailSearchView.layer.borderWidth = 1
        self.detailSearchView.layer.borderColor = UIColor(red: 187, green: 187, blue: 187, alpha: 1).cgColor
        
        self.detailImageView.image = self.isBusStop ? UIImage(named: "stationIconBlue") : UIImage(named: "busIconBlueRenew")
        
        if let name = self.stName {
            self.detailSearchTF.text = name
            
            if !self.isBusStop {
                self.detailSearchTF.isEnabled = false
            }
        }
        self.detailSearchTF.textColor = UIColor(red: 12, green: 31, blue: 120, alpha: 1)
        
        self.textfieldClearButton.isHidden = self.isBusStop ? false : true
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        
        self.completeButton.isHidden = self.isBusStop ? true : false
    }
    
    func checkBusStop() {
        if !self.isBusStop {
            guard let id = self.arsId else { return }
            
            APIManager.getBusList(arsId: id) { (resp) in
                guard let value = resp.value?.busList else {
                    print("Failed request in SetAlarmDetailViewController [getBusList] : \(resp)")
                    return
                }
                
                self.busList = value
                self.tableView.reloadData()
            }
        }
    }
    
    func getBusTextColor(busRouteType: String) -> UIColor {
        switch busRouteType {
        case "공항버스":
            return UIColor.blue
        case "마을버스":
            return UIColor.black
        case "간선버스":
            return UIColor(red: 54, green: 80, blue: 206, alpha: 1)
        case "지선버스":
            return UIColor(red: 86, green: 214, blue: 0, alpha: 1)
        case "순환버스":
            return UIColor.black
        case "광역버스":
            return UIColor(red: 255, green: 0, blue: 0, alpha: 1)
        case "인천버스":
            return UIColor.blue
        case "경기버스":
            return UIColor.blue
        case "폐지":
            return UIColor.gray
        case "공용":
            return UIColor.blue
        default: // "버스"
            return UIColor.blue
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
        cell.titleLabel.textColor = self.isBusStop ? UIColor(red: 54, green: 80, blue: 206, alpha: 1) : self.getBusTextColor(busRouteType: self.busList[indexPath.row].busRouteType ?? "버스")
        cell.descLabel.text = self.isBusStop ? self.busStopList[indexPath.row].arsId ?? "오류" + " | " + "방면" : self.busList[indexPath.row].busRouteType
        print(cell.busAlarmSwitch.isSelected)
        cell.busAlarmSwitch.isHidden = self.isBusStop ? true : false
        
        /* if isBusStop {
            if indexPath.row == self.busStopList.count - 1 {
                cell.bottomView.isHidden = true
            }
        }
        
        else {
            if indexPath.row == self.busList.count - 1 {
                cell.bottomView.isHidden = true
            }
        } */
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isBusStop {
            delegate?.sendBackBusStopData(id: self.busStopList[indexPath.row].arsId!, name: self.busStopList[indexPath.row].stNm!)
            self.navigationController?.popViewController(animated: true)
        }
        
        else {
            
        }
    }
    
}
