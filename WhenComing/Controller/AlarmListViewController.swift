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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareTableView()
        self.prepareAlarmData()
    }
    
    @IBAction func touchedAddBtn(_ sender: UIButton) {
        performSegue(withIdentifier: "goSetAlarmViewController", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goSetAlarmViewController" {
            if let vc = segue.destination as? SetAlarmViewController {
                vc.delegate = self
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
        APIManager.getAllAlarm(deviceId: uuid) { (resp) in
            guard let value = resp.value?.alarmList else {
                print("Failed request in AlarmListViewController [getAllAlarm] : \(resp)")
                return
            }
            
            self.alarmList = value
            self.tableView.reloadData()
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
                self.tableView.reloadData()
            })
        }
    }
    
    func sendBackAlarmData(arsId: String, busId: String, busName: String, alarmTime: String, alarmDay: String) {
        APIManager.registerAlarm(arsId: arsId, busRouteId: busId, busRouteName: busName, alarmTime: alarmTime, alarmDay: alarmDay) { (resp) in
            print("알람 등록 성공")
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
            
            cell.busStopLabel.text = self.alarmList[indexPath.row].arsId
            cell.busDirectionLabel.text = ""
            cell.busList = self.alarmList[indexPath.row].bus?.components(separatedBy: ",") ?? [String]()
            cell.dayList = self.alarmList[indexPath.row].day?.components(separatedBy: ",") ?? [String]()
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = alarmList.isEmpty ? tableView.frame.height : 305
        return height
    }
    
}
