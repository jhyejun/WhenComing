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
    
    var alarmList = [Alarm]()
    var busArrivalInfo: [ArrivalInfo] = []
    
    var selectIndex: Int!
    var isUpdate: Bool = false
    
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
        
        NotificationCenter.default.addObserver(forName: NSNotification.Name(rawValue: ""), object: nil, queue: OperationQueue.main) { noti in
            
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
//        self.tableView.rowHeight = UITableView.automaticDimension
//        self.tableView.estimatedRowHeight = 140
        self.tableView.separatorStyle = .none
        self.tableView.contentInset = UIEdgeInsets(top: 16, left: 0, bottom: 0, right: 0)
    }
    
    func prepareAlarmData() {
        LoadingIndicator.shared.startIndicator()
        
        DispatchQueue.global(qos: .default).async {
            APIManager.getAllAlarm(deviceId: uuid) { (resp) in
                guard let value = resp.value?.alarmList else {
                    print("Failed request in AlarmListViewController [getAllAlarm] : \(resp)")
                    return
                }
                
                self.alarmList = value
                self.tableView.reloadData()
                LoadingIndicator.shared.stopIndicator()
            }
        }
    }
    
    func prepareArrivalInfoData() {
        for i in 0 ..< self.alarmList.count {
            let busList = self.alarmList[i].busRouteType?.components(separatedBy: ",") ?? [String]()
            let arsId = self.alarmList[i].arsId ?? ""
            
            for j in 0 ..< busList.count {
                APIManager.getArrivalInfo(arsId: arsId, busRouteName: busList[i]) { (resp) in
                    guard let value = resp.value?.arrivalInfo else {
                        print("Failed request in AlarmListTableViewCell [getArrivalInfo] : \(resp)")
                        return
                    }
                    
                    self.busArrivalInfo.append(value)
                }
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
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let row = alarmList.isEmpty ? 1 : alarmList.count
        return row
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if alarmList.isEmpty {
            let cell = Bundle.main.loadNibNamed("AlarmListNotSetTableViewCell", owner: self, options: nil)?.first as! AlarmListNotSetTableViewCell
            cell.selectionStyle = .none
            
            return cell
        }
        
        else {
            let cell = Bundle.main.loadNibNamed("AlarmListTableViewCell", owner: self, options: nil)?.first as! AlarmListTableViewCell
            cell.selectionStyle = .none
            cell.tag = indexPath.row
            
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
            cell.busTypeList = self.alarmList[indexPath.row].busRouteType?.components(separatedBy: ",") ?? [String]()
            cell.busList = self.alarmList[indexPath.row].bus?.components(separatedBy: ",") ?? [String]()
            cell.dayList = self.alarmList[indexPath.row].day?.components(separatedBy: ",") ?? [String]()
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if alarmList.isEmpty {
            return tableView.frame.height
        }

        else {
            // alarmListView Height (114) + busTableView Height (64 * busList count) + cell bottom insert (16)
            return CGFloat(114 + 62 * (self.alarmList[indexPath.row].bus?.components(separatedBy: ",").count ?? 0) + 16)
        }
    }
    
}
