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
    @IBOutlet weak var stopView: UIView!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var busView: UIView!
    @IBOutlet weak var busBtn: UIButton!
    @IBOutlet weak var timerPicker: UIDatePicker!
    @IBOutlet weak var dayStackView: UIStackView!
    
    var from: String = ""
    var borderColor: CGColor = UIColor(red: 221, green: 221, blue: 221, alpha: 1).cgColor
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)

        self.regionView.layer.borderWidth = 1
        self.regionView.layer.borderColor = self.borderColor
        
        self.stopView.layer.borderWidth = 1
        self.stopView.layer.borderColor = self.borderColor
        
        self.busView.layer.borderWidth = 1
        self.busView.layer.borderColor = self.borderColor
        
        self.timerPicker.setValue(UIColor(red: 12, green: 31, blue: 120, alpha: 1), forKey: "textColor")
        self.timerPicker.subviews[0].subviews[1].backgroundColor = UIColor(red: 54, green: 80, blue: 206, alpha: 1)
        self.timerPicker.subviews[0].subviews[2].backgroundColor = UIColor(red: 54, green: 80, blue: 206, alpha: 1)
        self.timerPicker.layer.borderWidth = 1
        self.timerPicker.layer.borderColor = self.borderColor
        
        self.dayStackView.layer.borderWidth = 1
        self.dayStackView.layer.borderColor = self.borderColor
    }
    
    @IBAction func touchedStopBtn(_ sender: UIButton) {
        self.from = "stop"
        performSegue(withIdentifier: "goSetAlarmDetail", sender: nil)
    }
    
    @IBAction func touchedBusBtn(_ sender: UIButton) {
        self.from = "bus"
        performSegue(withIdentifier: "goSetAlarmDetail", sender: nil)
    }
    
    @IBAction func selectedDayBtn(_ sender: UIButton) {
        sender.isSelected = sender.isSelected ? false : true
        sender.backgroundColor = sender.isSelected ? UIColor(red: 54, green: 80, blue: 206, alpha: 1) : UIColor.white
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goSetAlarmDetail" {
            if let vc = segue.destination as? SetAlarmDetailViewController {
                vc.from = self.from
            }
        }
    }

}
