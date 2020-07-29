//
//  AlarmController.swift
//  Alarm 35
//
//  Created by Alex Lundquist on 7/27/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import Foundation

class AlarmController {
  
  //MARK: -Shared Instance
  static let sharedInstance = AlarmController()
  
  var alarms: [Alarm] = []
  
  //MARK: -Mock Data
//  var mockAlarms: [Alarm] = {
//    let alarm1 = Alarm(alarmName: "alarm1", alarmTime: Date())
//    let alarm2 = Alarm(alarmName: "alarm2", alarmTime: Date())
//    let alarm3 = Alarm(alarmName: "alarm3", alarmTime: Date())
//    return [alarm1, alarm2, alarm3]
//  }()
  
  func toggleIsOn(for alarm: Alarm) {
    alarm.alarmSwitch.toggle()
  }
  
  //MARK: CRUD
  //Create
  func createAlarm(alarmName: String, alarmTime: Date, alarmSwitch: Bool) {
//    let newMockAlarm = Alarm(alarmName: alarmName, alarmTime: alarmTime, alarmSwitch: alarmSwitch)
//    mockAlarms.append(newMockAlarm)
    let newAlarm = Alarm(alarmName: alarmName, alarmTime: alarmTime, alarmSwitch: alarmSwitch)
    alarms.append(newAlarm)
    saveToPersistentStore()
  }
  //Read
  
  //Update
  func updateAlarm(alarmToUpdate: Alarm, nameToUpdate: String, timeToUpdate: Date, switchUpdate: Bool ) {
    alarmToUpdate.alarmName = nameToUpdate
    alarmToUpdate.alarmTime = timeToUpdate
    alarmToUpdate.alarmSwitch = switchUpdate
    saveToPersistentStore()
  }
  
  //Delete
  func deleteAlarm(alarmToDelete: Alarm) {
    guard let index = alarms.firstIndex(of: alarmToDelete) else { return }
    alarms.remove(at: index)
//    mockAlarms.remove(at: index)
    saveToPersistentStore()
  }
  //MARK: -Local Persistence
  //File object path
  func fileURL() -> URL {
    let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
    let documentDirectory = paths[0]
    let filename = "alarms.json"
    let fullURL = documentDirectory.appendingPathComponent(filename)
    return fullURL
  } //End of File path
  
  //Save to persistent store to JSON
  func saveToPersistentStore() {
    do {
      let data = try JSONEncoder().encode(alarms)
      print(data)
      print(String(data: data, encoding: .utf8)!)
      try data.write(to: fileURL())
    } catch let error {
      print("Error in \(#function) : \(error.localizedDescription) \n------\n \(error)")
    }
  }//End of Save
  
  //Load from persistent store from JSON
  func loadFromPersistentStore() {
    do {
      let data = try Data(contentsOf: fileURL())
      let alarmFromFIle = try JSONDecoder().decode([Alarm].self, from: data)
      self.alarms = alarmFromFIle
    }catch let error {
      print("Error loading data from disk \(error)")
      print("\(#file)\(#line)")
    }
  }//End of Load
} //End of Class
