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
    
    @IBOutlet weak var alarmTimeView: UIView!
    @IBOutlet weak var alarmTimeAPMLabel: UILabel!
    @IBOutlet weak var alarmTimeLabel: UILabel!
    @IBOutlet weak var dayStackView: UIStackView!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var alarmSettingButton: UIButton!
    @IBOutlet weak var busStopLabel: UILabel!
    @IBOutlet weak var busDirectionLabel: UILabel!
    
    var dateArr : [String] = ["월", "화", "수", "목", "금"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        alarmTimeView.backgroundColor = alarmSwitch.isOn ? UIColor(red: 54, green: 80, blue: 206, alpha: 1) : UIColor(red: 187, green: 187, blue: 187, alpha: 1)
        
        // stackView 셋팅
        dateArr.forEach { (value) in
            let label = UILabel().then {
                $0.font = UIFont(name: "AppleSDGothicNeo-Light", size: 13)
                $0.text = value
                $0.textColor = UIColor(red: 12/255, green: 31/255, blue: 120/255, alpha: 1)
            }
            
            self.dayStackView?.addArrangedSubview(label)
        }
    }
    
    func setAlarmListCell(data: Bus) {
        self.alarmTimeLabel.text = data.time
    }
    
}
