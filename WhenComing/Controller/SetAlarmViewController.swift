//
//  SetAlarmViewController.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 4. 26..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit

class SetAlarmViewController: UIViewController {

    @IBOutlet weak var regionView: UIView!
    @IBOutlet weak var selectRegionBtn: UIButton!
    @IBOutlet weak var stopView: UIView!
    @IBOutlet weak var selectStopBtn: UIButton!
    @IBOutlet weak var busView: UIView!
    @IBOutlet weak var selectBusBtn: UIButton!
    @IBOutlet weak var timerPicker: UIDatePicker!
    @IBOutlet weak var dayStackView: UIStackView!
    
    var borderColor: CGColor = UIColor(red: 221, green: 221, blue: 221, alpha: 1).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.regionView.layer.borderWidth = 1
        self.regionView.layer.borderColor = self.borderColor
        
        self.stopView.layer.borderWidth = 1
        self.stopView.layer.borderColor = self.borderColor
        
        self.busView.layer.borderWidth = 1
        self.busView.layer.borderColor = self.borderColor
        
        self.timerPicker.layer.borderWidth = 1
        self.timerPicker.layer.borderColor = self.borderColor
        
        self.dayStackView.layer.borderWidth = 1
        self.dayStackView.layer.borderColor = self.borderColor
    }

}
