//
//  AlarmListTableViewCell.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 4. 18..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit

class AlarmListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var alarmTimeView: UIView!
    @IBOutlet weak var alarmTimeAPMLabel: UILabel!
    @IBOutlet weak var alarmTimeLabel: UILabel!
    @IBOutlet weak var dayStackView: UIStackView!
    @IBOutlet weak var alarmSwitch: UISwitch!
    @IBOutlet weak var alarmSettingButton: UIButton!
    @IBOutlet weak var busStopLabel: UILabel!
    @IBOutlet weak var busDirectionLabel: UILabel!
    
    var dateArr : [String] = ["월", "화", "금", "목", "금"]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //stackView 셋팅
        dateArr.forEach { (value) in
            label.text = value
            self.dayStackView?.addArrangedSubview(label)
        }
    }
    
    func setAlarmListCell(data: Bus) {
        self.alarmTimeLabel.text = data.time
    }
    
}
