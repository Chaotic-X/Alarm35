//
//  AlarmDetailTableViewController.swift
//  Alarm 35
//
//  Created by Alex Lundquist on 7/27/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import UIKit

class AlarmDetailTableViewController: UITableViewController {
  
  //MARK: -Outlets
  @IBOutlet weak var alarmTimePicker: UIDatePicker!
  @IBOutlet weak var alarmNameTextField: UITextField!
  @IBOutlet weak var enableButton: UIButton!
  
  //MARK: -Properties
  var receivedAlarm: Alarm? {
    didSet{
        loadViewIfNeeded()
        self.updateView()
    }
  }
  
  var alarmIsOn: Bool = true
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  //MARK: -Hepler functions
  func updateView() {
    guard let receivedAlarm = receivedAlarm else { return }
    alarmTimePicker.date = receivedAlarm.alarmTime
    alarmNameTextField.text = receivedAlarm.alarmName
    alarmIsOn = receivedAlarm.alarmSwitch
    setUpEnableButton()
  }
  
  func setUpEnableButton() {
    switch alarmIsOn {
      case true:
        enableButton.setTitle("Enable", for: .normal)
      case false:
//        alarmEnabledButton.backgroundColor = UIColor.gray
        enableButton.setTitle("Disable", for: .normal)
    }
  }
  
  //MARK: -Actions
  @IBAction func saveButtonTapped(_ sender: Any) {
    guard let alarmName = alarmNameTextField.text, !alarmName.isEmpty else { return }
    if let alarm = receivedAlarm {
      AlarmController.sharedInstance.updateAlarm(alarmToUpdate: alarm, nameToUpdate: alarmName, timeToUpdate: alarmTimePicker.date, switchUpdate: alarmIsOn)
    }else{
      AlarmController.sharedInstance.createAlarm(alarmName: alarmName, alarmTime: alarmTimePicker.date, alarmSwitch: alarmIsOn)
    }
    navigationController?.popViewController(animated: true)
  }
  
  
  @IBAction func enableButtonTapped(_ sender: Any) {
     if let enableAlarm = receivedAlarm {
      AlarmController.sharedInstance.toggleIsOn(for: enableAlarm)
      alarmIsOn = enableAlarm.alarmSwitch
     }else {
      alarmIsOn.toggle()
    }
    setUpEnableButton()
  }

} //End of Class
