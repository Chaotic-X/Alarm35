//
//  AlarmTableViewCell.swift
//  Alarm 35
//
//  Created by Alex Lundquist on 7/27/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import UIKit

protocol AlarmTableViewCellDelegate: class {
  func switchCellSwitchValueChanged(cell: AlarmTableViewCell)
}

class AlarmTableViewCell: UITableViewCell {

  //MARK: -Properties
  var alarm: Alarm? {
    didSet{
      self.updateViews()
    }
  }
  weak var delegate: AlarmTableViewCellDelegate?
  
  //MARK: -Outlets
  @IBOutlet weak var alarmTimeLabel: UILabel!
  @IBOutlet weak var alarmNameLabel: UILabel!
  @IBOutlet weak var alarmSwitch: UISwitch!
  
  //MARK: -Helper Methods
  func updateViews() {
    guard let alarm = alarm else { return }
    alarmTimeLabel.text = alarm.fireTimeAsString
    alarmNameLabel.text = alarm.alarmName
    alarmSwitch.isOn = alarm.alarmSwitch
  }
  
  //MARK: -Actions
  @IBAction func switchValueChanged(_ sender: Any) {
    delegate?.switchCellSwitchValueChanged(cell: self)
    AlarmController.sharedInstance.saveToPersistentStore()
  }
  
}
