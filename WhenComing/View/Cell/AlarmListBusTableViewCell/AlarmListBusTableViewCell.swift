//
//  AlarmListBusTableViewCell.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 5. 11..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit

class AlarmListBusTableViewCell: UITableViewCell {

    @IBOutlet weak var busNameLabel: UILabel!
    @IBOutlet weak var firstBusStackView: UIStackView!
    @IBOutlet weak var firstBusTimeLabel: UILabel!
    @IBOutlet weak var firstBusCountLabel: UILabel!
    @IBOutlet weak var firstBusStatusImageView: UIImageView!
    @IBOutlet weak var secondBusStackView: UIStackView!
    @IBOutlet weak var secondBusTimeLabel: UILabel!
    @IBOutlet weak var secondBusCountLabel: UILabel!
    @IBOutlet weak var secondBusStatusImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
}
