//
//  ListSetViewController.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 4. 10..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit

class AlarmListViewController: UIViewController, SendBackAlarmData {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var alarmList: [Alarm] = []
    
    var selectIndex: Int!
    var isUpdate: Bool = false
    var switchIsOn: Bool = false
    
    private var offColor: UIColor = UIColor(red: 187, green: 187, blue: 187, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareTableView()
        self.prepareAlarmData()
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: "touchedSettingButton"), object: nil, queue: OperationQueue.main) { noti in
            self.selectIndex = noti.object as? Int
            
            let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
            
            alert.addAction(UIAlertAction(title: "수정", style: UIAlertAction.Style.default, handler: { (action) in
                self.performSegue(withIdentifier: "goSetAlarmViewController", sender: nil)
            }))
            alert.addAction(UIAlertAction(title: "삭제", style: UIAlertAction.Style.destructive, handler: { (action) in
                APIManager.deleteAlarm(alarmId: self.alarmList[self.selectIndex].id!, { (resp) in
                    self.prepareAlarmData()
                    print("알람 삭제 성공")
                })
            }))
            alert.addAction(UIAlertAction(title: "취소", style: UIAlertAction.Style.cancel, handler: nil))
            
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func touchedAddBtn(_ sender: UIButton) {
        self.selectIndex = nil
        self.performSegue(withIdentifier: "goSetAlarmViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goSetAlarmViewController" {
            if let vc = segue.destination as? SetAlarmViewController {
                vc.isUpdate = self.isUpdate
                vc.delegate = self
                
                if !self.alarmList.isEmpty && self.selectIndex != nil {
                    vc.alarmId = self.alarmList[selectIndex].id
                    vc.arsId = self.alarmList[selectIndex].arsId
                    vc.stName = self.alarmList[selectIndex].ars_name
                    vc.busRouteIdList = self.alarmList[selectIndex].busRouteId?.components(separatedBy: ",") ?? [String]()
                    vc.busRouteTypeList = self.alarmList[selectIndex].busRouteType?.components(separatedBy: ",") ?? [String]()
                    vc.busRouteNameList = self.alarmList[selectIndex].bus?.components(separatedBy: ",") ?? [String]()
                    vc.alarmTime = self.alarmList[selectIndex].alarm_time
                    vc.alarmDay = self.alarmList[selectIndex].day?.components(separatedBy: ",") ?? [String]()
                }
            }
        }
    }
    
    func prepareTableView() {
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .none
        self.tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    func prepareAlarmData() {
        LoadingIndicator.shared.startIndicator()
        
        DispatchQueue.main.async {
            APIManager.getAllAlarm(deviceId: uuid) { (resp) in
                guard let value = resp.value?.alarmList else {
                    print("Failed request in AlarmListViewController [getAllAlarm] : \(resp)")
                    LoadingIndicator.shared.stopIndicator()
                    return
                }
                
                self.alarmList = value
                self.prepareArrivalInfoData()
            }
        }
    }
    
    func prepareArrivalInfoData() {
        let prepareDataGroup = DispatchGroup()
        let prepareDataQueue = DispatchQueue.global(qos: .default)
       
        prepareDataQueue.async {
            for i in 0 ..< self.alarmList.count {
                guard let arsId = self.alarmList[i].arsId else { return }
                self.alarmList[i].busTypeList = self.alarmList[i].busRouteType?.components(separatedBy: ",") ?? [String]()
                self.alarmList[i].busList = self.alarmList[i].bus?.components(separatedBy: ",") ?? [String]()
                self.alarmList[i].dayList = self.alarmList[i].day?.components(separatedBy: ",") ?? [String]()
                
                for j in 0 ..< self.alarmList[i].busList.count {
                    APIManager.getArrivalInfo(arsId: arsId, busRouteName: self.alarmList[i].busList[j]) { (resp) in
                        guard let value = resp.value?.arrivalInfo else {
                            print("Failed request in AlarmListViewController [getArrivalInfo] : \(resp)")
                            LoadingIndicator.shared.stopIndicator()
                            return
                        }
                        
                        self.alarmList[i].busArrivalInfoList.append(value)
                    }
                }
            }
        }
        
        prepareDataGroup.notify(queue: prepareDataQueue) {
            DispatchQueue.main.async {
                self.tableView.reloadData()
                LoadingIndicator.shared.stopIndicator()
            }
        }
    }
    
    func sendBackAlarmData(alarmId: Int?, arsId: String, ars_name: String, next_station: String, busId: String, busType: String, busName: String, alarmTime: String, alarmDay: String) {
        if alarmId == nil {
            APIManager.registerAlarm(arsId: arsId, ars_name: ars_name, next_station: next_station, busRouteId: busId, busRouteType: busType, busRouteName: busName, alarmTime: alarmTime, alarmDay: alarmDay) { (resp) in
                self.prepareAlarmData()
                print("알람 등록 성공")
            }
        }
        
        else {
            APIManager.updateAlarm(alarmId: alarmId!, arsId: arsId, ars_name: ars_name, next_station: next_station, busRouteId: busId, busRouteType: busType, busRouteName: busName, alarmTime: alarmTime, alarmDay: alarmDay) { (resp) in
                self.prepareAlarmData()
                print("알람 업데이트 성공")
            }
        }
    }
    
}

extension AlarmListViewController : UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return alarmList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let row = self.alarmList[section].busList.isEmpty ? 1 : self.alarmList[section].busList.count
        
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if alarmList.isEmpty {
            let cell = Bundle.main.loadNibNamed("AlarmListNotSetTableViewCell", owner: self, options: nil)?.first as! AlarmListNotSetTableViewCell
            cell.selectionStyle = .none
            
            return cell
        }
        
        else {
            if indexPath.row == 0 {
                let cell = Bundle.main.loadNibNamed("AlarmListTableViewCell", owner: self, options: nil)?.first as! AlarmListTableViewCell
                cell.selectionStyle = .none
                cell.tag = indexPath.row
                switchIsOn = cell.alarmSwitch.isOn
                
                if let alarmTimePieces = self.alarmList[indexPath.row].alarm_time?.components(separatedBy: ":") {
                    var hour = Int(alarmTimePieces[0]) ?? 0
                    
                    if hour < 12 && hour >= 0 {
                        cell.alarmTimeAPMLabel.text = "오전"
                        cell.alarmTimeLabel.text = String(format: "%02d", hour) + ":" + alarmTimePieces[1]
                    }
                        
                    else {
                        hour -= 12
                        cell.alarmTimeAPMLabel.text = "오후"
                        cell.alarmTimeLabel.text = String(format: "%02d", hour) + ":" + alarmTimePieces[1]
                    }
                }
                
                cell.busStopLabel.text = self.alarmList[indexPath.row].ars_name ?? ""
                cell.busDirectionLabel.text = (self.alarmList[indexPath.row].next_station ?? "오류") + " 방면"
                cell.arsId = self.alarmList[indexPath.row].arsId ?? ""
                
                return cell
            }
            
            else {
                let cell = Bundle.main.loadNibNamed("AlarmListBusTableViewCell", owner: self, options: nil)?.first as! AlarmListBusTableViewCell
                cell.selectionStyle = .none
                
                if self.switchIsOn {
                    cell.busNameLabel.text = self.alarmList[indexPath.section].busList.joined(separator: " ")
                    cell.busNameLabel.textColor = offColor
                    cell.firstBusStackView.isHidden = true
                    cell.firstBusStatusImageView.isHidden = true
                    cell.secondBusStackView.isHidden = true
                    cell.secondBusStatusImageView.isHidden = true
                    
                    return cell
                }
                
                cell.busNameLabel.text = self.alarmList[indexPath.section].busList[indexPath.row]
                cell.busNameLabel.textColor = .getBusTextColor(busRouteType: self.alarmList[indexPath.section].busTypeList[indexPath.row])
                cell.busNameLabel.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 20)
                
                // 첫번째 버스가 막차가 아닐 때
                if self.alarmList[indexPath.section].busArrivalInfoList[indexPath.row].isLast1 == "0" {
                    let firstBus = self.alarmList[indexPath.section].busArrivalInfoList[indexPath.row].arrmsg1?.components(separatedBy: "[")
                    let firstBusTime = firstBus?.first ?? "오류"
                    let firstBusCount = firstBus?.last ?? "오류?"
                    
                    cell.firstBusTimeLabel.text = firstBusTime
                    cell.firstBusCountLabel.text = firstBusCount != "운행종료" && firstBusCount != "곧 도착" ? String(firstBusCount.dropLast()) : firstBusCount
                    cell.firstBusStatusImageView.image = UIImage.getCongestionImage(congetion: self.alarmList[indexPath.section].busArrivalInfoList[indexPath.row].congetion ?? "")
                }
                    
                // 첫번째 버스가 막차일 때
                else {
                    
                }
                
                // 두번째 버스가 막차가 아닐 때
                if self.alarmList[indexPath.section].busArrivalInfoList[indexPath.row].isLast2 == "0" {
                    let secondBus = self.alarmList[indexPath.section].busArrivalInfoList[indexPath.row].arrmsg2?.components(separatedBy: "[")
                    let secondBusTime = secondBus?.first ?? "오류"
                    let secondBusCount = secondBus?.last ?? "오류?"
                    
                    cell.secondBusTimeLabel.text = secondBusTime
                    cell.secondBusCountLabel.text = secondBusCount != "운행종료" && secondBusCount != "곧 도착" ? String(secondBusCount.dropLast()) : secondBusCount
                    cell.secondBusStatusImageView.image = .getCongestionImage(congetion: self.alarmList[indexPath.section].busArrivalInfoList[indexPath.row].congetion ?? "")
                }
                    
                    // 두번째 버스가 막차일 때
                else {
                    
                }
                
                return cell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if alarmList.isEmpty {
            return tableView.frame.height
        }

        else {
            if indexPath.row == 0 {
                return 114
            }
                
            else {
                return 62
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        if alarmList.isEmpty {
            return tableView.frame.height
        }
            
        else {
            if indexPath.row == 0 {
                return 114
            }
            
            else {
                return 62
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 16
    }
    
}
