//
//  CalendarTableViewController.swift
//  iBarber
//
//  Created by Macbook Pro on 16/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit
import EventKit

class CalendarTableViewController: UITableViewController {

    @IBOutlet var calendarsTableView: UITableView!
    
    let eventStore = EKEventStore()
    
    var calendars: [EKCalendar]?
    
    override func viewWillAppear(_ animated: Bool) {
        checkCalendarAuthorizationStatus()
    }
    
    func checkCalendarAuthorizationStatus() {
        let status = EKEventStore.authorizationStatus(for: EKEntityType.event)
        
        switch (status) {
        case EKAuthorizationStatus.notDetermined:
            // This happens on first-run
            requestAccessToCalendar()
        case EKAuthorizationStatus.authorized:
            // Things are in line with being able to show the calendars in the table view
            loadCalendars()
            refreshTableView()
        case EKAuthorizationStatus.restricted, EKAuthorizationStatus.denied:
            // We need to help them give us permission
            requestAccessToCalendar()
        }
    }
    
    func requestAccessToCalendar() {
        eventStore.requestAccess(to: EKEntityType.event, completion: {
            (accessGranted: Bool, error: Error?) in
            
            if accessGranted == true {
                DispatchQueue.main.async(execute: {
                    self.loadCalendars()
                    self.refreshTableView()
                })
            } else {
                let alertController = UIAlertController(title: "Error", message: "You have to give permission to the iBarber to access your Calendars", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Go to settings", style: .default, handler: {
                    action in
                    let openSettingsUrl = URL(string: UIApplicationOpenSettingsURLString)
                    UIApplication.shared.openURL(openSettingsUrl!)
                }))
                alertController.addAction(UIAlertAction(title: "I don't want to use this feature", style: .cancel, handler: {
                    action in
                    self.navigationController?.popViewController(animated: true)
                }))
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
    
    func loadCalendars() {
        self.calendars = eventStore.calendars(for: EKEntityType.event)
    }
    
    func refreshTableView() {
        calendarsTableView.isHidden = false
        calendarsTableView.reloadData()
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let calendars = self.calendars {
            return calendars.count
        }
        
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "calendarCell")!
        
        if let calendars = self.calendars {
            let calendarName = calendars[(indexPath as NSIndexPath).row].title
            cell.textLabel?.text = calendarName
        } else {
            cell.textLabel?.text = "Unknown Calendar Name"
        }
        
        return cell
    }

    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

