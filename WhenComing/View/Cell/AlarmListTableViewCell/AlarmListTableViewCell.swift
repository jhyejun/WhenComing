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
    
    var offColor: UIColor = UIColor(red: 187, green: 187, blue: 187, alpha: 1)
    
    var dayList: [String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.alarmListView.layer.borderWidth = 1
        self.alarmListView.layer.borderColor = UIColor(red: 221, green: 221, blue: 221, alpha: 1).cgColor
        
        self.alarmTimeView.backgroundColor = alarmSwitch.isOn ? UIColor(red: 54, green: 80, blue: 206, alpha: 1) : self.offColor
        
        for _ in 0 ..< 6 {
            let label = UILabel().then {
                $0.font = UIFont(name: "AppleSDGothicNeo-Light", size: 13)
                $0.textColor = UIColor(red: 12, green: 31, blue: 120, alpha: 1)
            }
            self.dayStackView?.addArrangedSubview(label)
        }
        
        self.alarmSwitch.isOn = true
        self.alarmSwitch.tintColor = offColor
        self.alarmSwitch.layer.cornerRadius = self.alarmSwitch.frame.height / 2
        self.alarmSwitch.backgroundColor = offColor
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        // stackView 셋팅
        if self.dayList.count == 7 {
            self.dayList.removeAll()
            self.dayList.append("매일")
        }
        
        for i in 0 ..< self.dayList.count {
            switch self.dayList[i] {
            case "1":
                (self.dayStackView.arrangedSubviews[i] as! UILabel).text = "월"
                
            case "2":
                (self.dayStackView.arrangedSubviews[i] as! UILabel).text = "화"
                
            case "3":
                (self.dayStackView.arrangedSubviews[i] as! UILabel).text = "수"
                
            case "4":
                (self.dayStackView.arrangedSubviews[i] as! UILabel).text = "목"
                
            case "5":
                (self.dayStackView.arrangedSubviews[i] as! UILabel).text = "금"
                
            case "6":
                (self.dayStackView.arrangedSubviews[i] as! UILabel).text = "토"
                
            case "7":
                (self.dayStackView.arrangedSubviews[i] as! UILabel).text = "일"
                
            default:
                (self.dayStackView.arrangedSubviews[i] as! UILabel).text = self.dayList[i]
            }
        }
    }
    
    @IBAction func touchedAlarmSwitch(_ sender: UISwitch) {
        let dayLabelList = self.dayStackView.arrangedSubviews.compactMap { $0 as? UILabel }
        _ = dayLabelList.map { $0.textColor = self.alarmSwitch.isOn ? UIColor(red: 12, green: 31, blue: 120, alpha: 1) : self.offColor }
        
        self.alarmTimeView.backgroundColor = self.alarmSwitch.isOn ? UIColor(red: 54, green: 80, blue: 206, alpha: 1) : self.offColor
        self.busStopLabel.textColor = self.alarmSwitch.isOn ? UIColor(red: 12, green: 31, blue: 120, alpha: 1) : self.offColor
        self.busDirectionLabel.textColor = self.alarmSwitch.isOn ? UIColor(red: 12, green: 31, blue: 120, alpha: 1) : self.offColor
    }
    
    @IBAction func touchedSettingButton(_ sender: UIButton) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "touchedSettingButton"), object: self.tag)
    }
}
