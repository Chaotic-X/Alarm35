//
//  AlarmListTableViewController.swift
//  Alarm 35
//
//  Created by Alex Lundquist on 7/27/20.
//  Copyright © 2020 Alex Lundquist. All rights reserved.
//

import UIKit

class AlarmListTableViewController: UITableViewController {
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    AlarmController.sharedInstance.loadFromPersistentStore()
    tableView.reloadData()
  }
  
  // MARK: - Table view data source
  
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
//    return AlarmController.sharedInstance.mockAlarms.count
    return AlarmController.sharedInstance.alarms.count
  }
  
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = tableView.dequeueReusableCell(withIdentifier: "alarmCell", for: indexPath) as? AlarmTableViewCell else { return UITableViewCell() }
//    let mockAlarm = AlarmController.sharedInstance.mockAlarms[indexPath.row]
    let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
    cell.delegate = self
//    cell.alarm = mockAlarm
    cell.alarm = alarm
    
    return cell
  }
  
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
      if editingStyle == .delete {
//        let alarmToDelete = AlarmController.sharedInstance.mockAlarms[indexPath.row]
        let alarmToDelete = AlarmController.sharedInstance.alarms[indexPath.row]
        AlarmController.sharedInstance.deleteAlarm(alarmToDelete: alarmToDelete)
        tableView.deleteRows(at: [indexPath], with: .fade)
      }
    }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if segue.identifier == "updateAlarm" {
      guard let indexPath = tableView.indexPathForSelectedRow,
        let destinationVC = segue.destination as? AlarmDetailTableViewController else { return }
//      let alarmToSend = AlarmController.sharedInstance.mockAlarms[indexPath.row]
      let alarmToSend = AlarmController.sharedInstance.alarms[indexPath.row]
      destinationVC.receivedAlarm = alarmToSend
    }
  }
}

extension AlarmListTableViewController: AlarmTableViewCellDelegate {
  func switchCellSwitchValueChanged(cell: AlarmTableViewCell) {
    guard let indexPath = tableView.indexPath(for: cell) else { return }
//    let alarm = AlarmController.sharedInstance.mockAlarms[indexPath.row]
    let alarm = AlarmController.sharedInstance.alarms[indexPath.row]
    AlarmController.sharedInstance.toggleIsOn(for: alarm)
  }
  
  
}

