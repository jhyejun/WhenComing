//
//  SetAlarmViewController.swift
//  WhenComing
//
//  Created by 장혜준 on 2018. 4. 26..
//  Copyright © 2018년 장혜준. All rights reserved.
//

import UIKit

class SetAlarmViewController: UIViewController, SendBackDelegate {

    @IBOutlet weak var regionView: UIView!
    @IBOutlet weak var stopView: UIView!
    @IBOutlet weak var stopBtn: UIButton!
    @IBOutlet weak var busView: UIView!
    @IBOutlet weak var busBtn: UIButton!
    @IBOutlet weak var timerPicker: UIDatePicker!
    @IBOutlet weak var dayStackView: UIStackView!
    
    var borderColor: CGColor = UIColor(red: 221, green: 221, blue: 221, alpha: 1).cgColor
    var textColor: UIColor = UIColor(red: 12, green: 31, blue: 120, alpha: 1)
    var placeholderColor: UIColor = UIColor(red: 187, green: 187, blue: 187, alpha: 1)
    
    var isBusStop: Bool = true
    var arsId: String!
    var stName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.prepareNavigation()
        self.prepareView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if let busStopName = self.stName {
            self.stopBtn.setTitle(busStopName, for: .normal)
            self.stopBtn.setTitleColor(self.textColor, for: .normal)
        }
            
        else {
            self.stopBtn.setTitle("정류장을 선택하세요", for: .normal)
            self.stopBtn.setTitleColor(self.placeholderColor, for: .normal)
        }
        
        self.busBtn.isEnabled = self.stopBtn.currentTitle != "정류장을 선택하세요" ? true : false
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goSetAlarmDetail" {
            if let vc = segue.destination as? SetAlarmDetailViewController {
                vc.delegate = self
                vc.isBusStop = self.isBusStop
                
                if let id = self.arsId, let name = self.stName {
                    vc.arsId = id
                    vc.stName = name
                }
            }
        }
    }
    
    @IBAction func touchedStopBtn(_ sender: UIButton) {
        self.isBusStop = true
        performSegue(withIdentifier: "goSetAlarmDetail", sender: nil)
    }
    
    @IBAction func touchedBusBtn(_ sender: UIButton) {
        self.isBusStop = false
        performSegue(withIdentifier: "goSetAlarmDetail", sender: nil)
    }
    
    @IBAction func selectedDayBtn(_ sender: UIButton) {
        sender.isSelected = sender.isSelected ? false : true
        sender.backgroundColor = sender.isSelected ? UIColor(red: 54, green: 80, blue: 206, alpha: 1) : UIColor.white
    }
    
    @objc func touchedBackButton() {
        self.navigationController?.popViewController(animated: true)
    }
    
    func prepareNavigation() {
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "nav_back"), style: .plain, target: self, action: #selector(touchedBackButton))
    }
    
    func prepareView() {
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
    
    func sendBackBusStopData(id: String, name: String) {
        self.arsId = id
        self.stName = name
    }

}
