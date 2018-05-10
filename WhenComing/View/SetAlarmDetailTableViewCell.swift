//
//  SetAlarmDetailTableViewCell.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 5. 9..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit

class SetAlarmDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var busAlarmSwitch: UISwitch!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.busAlarmSwitch.isOn = true
        self.busAlarmSwitch.tintColor = UIColor(red: 187, green: 187, blue: 187, alpha: 1)
        self.busAlarmSwitch.layer.cornerRadius = self.busAlarmSwitch.frame.height / 2
        self.busAlarmSwitch.backgroundColor = UIColor(red: 187, green: 187, blue: 187, alpha: 1)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
