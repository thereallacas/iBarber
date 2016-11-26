//
//  CalendarEventsViewController.swift
//  iBarber
//
//  Created by Macbook Pro on 17/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit
import EventKit

class CalendarEventsViewController: UITableViewController {

    var calendar: EKCalendar!
    var events: [EKEvent]?
    
    var selectedClient : 💇!
    
    func loadEvents() {
        
        // Create start and end date NSDate instances to build a predicate for which events to select
        var today = Date()
        today = today.addingTimeInterval(-10000)
        let endDate = today.addingTimeInterval(100000)
        
        let eventStore = EKEventStore()
            
        // Use an event store instance to create and properly configure an NSPredicate
        let eventsPredicate = eventStore.predicateForEvents(withStart: today, end: endDate, calendars: [calendar])
            
        // Use the configured NSPredicate to find and return events in the store that match
        self.events = eventStore.events(matching: eventsPredicate).sorted(){
                (e1: EKEvent, e2: EKEvent) -> Bool in
                return e1.startDate.compare(e2.startDate) == ComparisonResult.orderedAscending
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEvents()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    
    
    @IBOutlet var tableview: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        loadEvents()
        tableview.reloadData()
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
        // #warning Incomplete implementation, return the number of rows
        if let events = events {
            return events.count
        }
        
        return 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "EventCell")!
        let event  = events?[(indexPath as NSIndexPath).row]

        let startcomponents = Calendar.current.dateComponents([.month,.day,.minute,.hour], from: (event?.startDate)!)
        let endcomponents = Calendar.current.dateComponents([.minute,.hour], from: (event?.endDate)!)
        let startdatetext = String(describing: startcomponents.month!)+"."+String(describing: startcomponents.day!)+"-"+String(describing: startcomponents.hour!)+":"+String(describing: startcomponents.minute!)
        let enddatetext = String(describing: endcomponents.hour!)+":"+String(describing: endcomponents.minute!)
        cell.textLabel?.text = event?.title
        cell.detailTextLabel?.text = startdatetext+" - "+enddatetext
        return cell
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


    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier=="AddEventSegue"){
            let addeventviewcontroller = segue.destination as! AddEventViewController
            addeventviewcontroller.selectedClient = self.selectedClient
            addeventviewcontroller.calendar = self.calendar
        }
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }

}
