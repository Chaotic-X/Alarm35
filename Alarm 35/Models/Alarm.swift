//
//  Alarm.swift
//  Alarm 35
//
//  Created by Alex Lundquist on 7/27/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import Foundation

class Alarm: Codable {
  
  var alarmName: String
  var alarmTime: Date
  var alarmSwitch: Bool
  var uuid: String
  var fireTimeAsString: String {
    let formatter = DateFormatter()
    formatter.dateStyle = .none
    formatter.timeStyle = .short
    return formatter.string(from: alarmTime)
  }
  
  init(alarmName: String, alarmTime: Date, alarmSwitch: Bool = true, uuid: String = UUID().uuidString) {
    self.alarmName = alarmName
    self.alarmTime = alarmTime
    self.alarmSwitch = alarmSwitch
    self.uuid = uuid
  }
}

extension Alarm: Equatable {
  static func == (lhs: Alarm, rhs: Alarm) -> Bool {
    return lhs.uuid == rhs.uuid
  }
}
