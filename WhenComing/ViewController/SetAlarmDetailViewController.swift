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
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var completeButtonHeight: NSLayoutConstraint!
    
    var delegate: SendBackDetailData?
    
    var isBusStop: Bool = true
    var arsId: String!
    var stName: String!
    var busStopList = [BusStop]()
    var busList = [Bus]()
    var busRouteIdList = [String]()
    var busRouteTypeList = [String]()
    var busRouteNameList = [String]()
    
    var changedSwitchTag = [Int: Bool]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareNavigation()
        self.prepareView()
        self.checkBusStop()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "valueChangedAlarmSwitch"), object: nil, queue: OperationQueue.main) { (noti) in
            let tag: Int = noti.userInfo!["indexPath"] as! Int
            self.changedSwitchTag[tag] = self.changedSwitchTag[tag] != nil ? !self.changedSwitchTag[tag]! : true
        }
    }
    
    @IBAction func textFieldDidChange(_ sender: UITextField) {
        guard let query = detailSearchTF.text else {
            print("Bad Value in SetAlarmDetailViewController [detailSearchTF] : \(detailSearchTF.text!)")
            return
        }
        
        if query == "" {
            self.busStopList.removeAll()
            self.tableView.reloadData()
        }
        
        else {
            APIManager.cancelRequest()
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
    }
    
    @IBAction func touchedCleanButton(_ sender: UIButton) {
        self.detailSearchTF.text = ""
        self.busStopList.removeAll()
        self.tableView.reloadData()
    }
    
    @IBAction func touchedCompleteButton(_ sender: UIButton) {
        self.busRouteIdList.removeAll()
        self.busRouteTypeList.removeAll()
        self.busRouteNameList.removeAll()
        
        for (key, val) in self.changedSwitchTag.sorted(by: { $0.0 < $1.0 }) {
            if val == true {
                self.busRouteIdList.append(self.busList[key].busRouteId!)
                self.busRouteTypeList.append(self.busList[key].busRouteType!)
                self.busRouteNameList.append(self.busList[key].busRouteNm!)
            }
        }
        
        delegate?.sendBackBusData(idList: self.busRouteIdList, nameList: self.busRouteNameList, typeList: self.busRouteTypeList)
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
            self.textFieldDidChange(self.detailSearchTF)
            
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
        self.completeButtonHeight.constant = self.isBusStop ? 0 : deviceSize.height * 0.0899
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
    
    func convertBusType(busType: String) -> String {
        switch busType {
        case "1":
            return "공항버스"
        case "2":
            return "마을버스"
        case "3":
            return "간선버스"
        case "4":
            return "지선버스"
        case "5":
            return "순환버스"
        case "6":
            return "광역버스"
        case "7":
            return "인천버스"
        case "8":
            return "경기버스"
        case "9":
            return "폐지"
        case "0":
            return "공용"
        default:
            return "버스"
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
        
        if self.isBusStop {
            let arsId = self.busStopList[indexPath.row].arsId ?? "오류"
            let nextStation = self.busStopList[indexPath.row].next_station ?? "오류"
            
            cell.indicatorImageView.image = UIImage(named: "stationIconGray")
            cell.titleLabel.text = self.busStopList[indexPath.row].stNm
            cell.titleLabel.textColor = UIColor(red: 54, green: 80, blue: 206, alpha: 1)
            cell.descLabel.text = arsId + " | " + nextStation + " 방면"
            cell.busAlarmSwitch.isHidden = true
        }
        
        else {
            cell.indicatorImageView.image = UIImage(named: "busIconGrayRenew")
            cell.titleLabel.text = self.busList[indexPath.row].busRouteNm
            cell.titleLabel.textColor = .getBusTextColor(busRouteType: self.busList[indexPath.row].busRouteType ?? "버스")
            cell.descLabel.text = self.convertBusType(busType: self.busList[indexPath.row].busRouteType ?? "")
            cell.busAlarmSwitch.isHidden = false
            cell.busAlarmSwitch.tag = indexPath.row
        }
        
        // 이미 체크한 버스들의 스위치를 온 시켜놓기
        if busRouteNameList.contains(cell.titleLabel.text ?? "") {
            cell.busAlarmSwitch.isOn = true
            self.changedSwitchTag[indexPath.row] = true
        }
        
        
        // 마지막 셀의 하단 구분선은 없애기
        if isBusStop {
            if indexPath.row == self.busStopList.count - 1 {
                cell.bottomView.isHidden = true
            }
        }
        
        else {
            if indexPath.row == self.busList.count - 1 {
                cell.bottomView.isHidden = true
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 69
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if isBusStop {
            delegate?.sendBackBusStopData(id: self.busStopList[indexPath.row].arsId!, name: self.busStopList[indexPath.row].stNm!, next_station: self.busStopList[indexPath.row].next_station!)
            self.navigationController?.popViewController(animated: true)
        }
        
        else {
            // self.performSegue(withIdentifier: "goBusDetail", sender: self)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
    
}
