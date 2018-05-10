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
    var dateArr : [String] = ["월", "화", "수", "목", "금", "토"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.alarmListView.layer.borderWidth = 1
        self.alarmListView.layer.borderColor = UIColor(red: 221, green: 221, blue: 221, alpha: 1).cgColor
        
        self.alarmTimeView.backgroundColor = alarmSwitch.isOn ? UIColor(red: 54, green: 80, blue: 206, alpha: 1) : self.offColor
        
        // stackView 셋팅
        self.dateArr.forEach { (value) in
            let label = UILabel().then {
                $0.font = UIFont(name: "AppleSDGothicNeo-Light", size: 13)
                $0.text = value
                $0.textColor = UIColor(red: 12, green: 31, blue: 120, alpha: 1)
            }
            
            self.dayStackView?.addArrangedSubview(label)
        }
        
        self.alarmSwitch.isOn = true
        self.alarmSwitch.tintColor = offColor
        self.alarmSwitch.layer.cornerRadius = self.alarmSwitch.frame.height / 2
        self.alarmSwitch.backgroundColor = offColor
        
        self.busTableView.delegate = self
        self.busTableView.dataSource = self
        self.busTableView.separatorStyle = .none
    }
    
    @IBAction func touchedAlarmSwitch(_ sender: UISwitch) {
        
    }
    
    func setAlarmListCell(data: Bus) {
        self.alarmTimeLabel.text = data.time
    }
    
}

extension AlarmListTableViewCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("AlarmListTableViewCell", owner: self, options: nil)?.first as! AlarmListTableViewCell
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // return 120
        return 30
    }
    
}
