//
//  AlarmListTableViewCell.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 4. 18..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit
import Then

class AlarmListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var alarmListView: UIView!
    @IBOutlet weak var alarmTimeView: UIView!
    @IBOutlet weak var alarmTimeAPMLabel: UILabel!
    @IBOutlet weak var alarmTimeLabel: UILabel!
    @IBOutlet weak var dayStackView: UIStackView!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var alarmSettingButton: UIButton!
    @IBOutlet weak var busStopLabel: UILabel!
    @IBOutlet weak var busDirectionLabel: UILabel!
    @IBOutlet weak var busTableView: UITableView!
    
    var offColor: UIColor = UIColor(red: 187, green: 187, blue: 187, alpha: 1)
    var busList: [String] = [String]()
    var dayList: [String] = [String]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.alarmListView.layer.borderWidth = 1
        self.alarmListView.layer.borderColor = UIColor(red: 221, green: 221, blue: 221, alpha: 1).cgColor
        
        self.alarmTimeView.backgroundColor = alarmSwitch.isOn ? UIColor(red: 54, green: 80, blue: 206, alpha: 1) : self.offColor
        
        self.alarmSwitch.isOn = true
        self.alarmSwitch.tintColor = offColor
        self.alarmSwitch.layer.cornerRadius = self.alarmSwitch.frame.height / 2
        self.alarmSwitch.backgroundColor = offColor
        
        self.busTableView.delegate = self
        self.busTableView.dataSource = self
        self.busTableView.separatorStyle = .none
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // stackView 셋팅
        if self.dayList.count == 7 {
            self.dayList.removeAll()
            self.dayList.append("매일")
        }
        
        self.dayList.forEach { (value) in
            let label = UILabel().then {
                $0.font = UIFont(name: "AppleSDGothicNeo-Light", size: 13)
                $0.textColor = UIColor(red: 12, green: 31, blue: 120, alpha: 1)
                
                switch value {
                case "1":
                    $0.text = "월"
                
                case "2":
                    $0.text = "화"
                    
                case "3":
                    $0.text = "수"
                    
                case "4":
                    $0.text = "목"
                    
                case "5":
                    $0.text = "금"
                    
                case "6":
                    $0.text = "토"
                    
                case "7":
                    $0.text = "일"
                    
                default:
                    $0.text = value
                }
            }
            
            self.dayStackView?.addArrangedSubview(label)
        }
    }
    
    @IBAction func touchedAlarmSwitch(_ sender: UISwitch) {
        let dayLabelList = self.dayStackView.arrangedSubviews.compactMap { $0 as? UILabel }
        _ = dayLabelList.map { $0.textColor = self.alarmSwitch.isOn ? UIColor(red: 12, green: 31, blue: 120, alpha: 1) : self.offColor }
        
        self.alarmTimeView.backgroundColor = self.alarmSwitch.isOn ? UIColor(red: 54, green: 80, blue: 206, alpha: 1) : self.offColor
        self.busStopLabel.textColor = self.alarmSwitch.isOn ? UIColor(red: 12, green: 31, blue: 120, alpha: 1) : self.offColor
        self.busDirectionLabel.textColor = self.alarmSwitch.isOn ? UIColor(red: 12, green: 31, blue: 120, alpha: 1) : self.offColor
        
        self.busTableView.isHidden = !self.busTableView.isHidden
    }
    
    @IBAction func touchedSettingButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "touchedSettingButton"), object: self.tag)
    }
    
    func setAlarmListCell(data: Bus) {
        // self.alarmTimeLabel.text = data.time
    }
    
}

extension AlarmListTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.busList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("AlarmListBusTableViewCell", owner: self, options: nil)?.first as! AlarmListBusTableViewCell
        cell.selectionStyle = .none
        
        cell.busNameLabel.text = self.busList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 62
    }
    
}
