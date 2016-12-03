//
//  AddEventViewController.swift
//  iBarber
//
//  Created by Macbook Pro on 24/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit
import EventKit
import RealmSwift


extension AddEventViewController: UIPickerViewDataSource,UIPickerViewDelegate{
    
    
    // The number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedOperation = pickerData[row]
        OPERATIONLABEL.text = pickerData[row]
    }
}


class AddEventViewController: UIViewController {

    var selectedClient: 💇!
    var calendar: EKCalendar!
    
    var pickerData = [String]()

    var selectedOperation:String!
    
    var startdate:NSDate!
    var enddate:NSDate!
    
    @IBOutlet weak var OPERATIONLABEL: UILabel!
    
    
    @IBOutlet weak var START: UIDatePicker!
    
    
    @IBOutlet weak var END: UIDatePicker!
    
    
    @IBOutlet weak var OPERATION: UIPickerView!
    
    @IBAction func SAVE(_ sender: AnyObject) {
        let eventStore = EKEventStore();
        
        // Use Event Store to create a new calendar instance
        if let calendarForEvent = eventStore.calendar(withIdentifier: self.calendar.calendarIdentifier)
        {
            let newEvent = EKEvent(eventStore: eventStore)
            
            newEvent.calendar = calendarForEvent
            newEvent.title = selectedClient.name
            newEvent.startDate = self.START.date
            newEvent.endDate = self.END.date
            newEvent.notes = "PhoneNumber: "+selectedClient.phoneNumber+" Operation: "+selectedOperation
            
            // Save the calendar using the Event Store instance
            
            do {
                try eventStore.save(newEvent, span: .thisEvent, commit: true)
                
                let alertController = UIAlertController(title: "Success", message: "Event successfully saved to your Calendar", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
                if let navController = self.navigationController {
                    navController.popViewController(animated: true)
                }
            } catch {
                let alert = UIAlertController(title: "Event could not save", message: (error as NSError).localizedDescription, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default, handler: nil)
                alert.addAction(OKAction)
                
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        OPERATION.delegate = self
        OPERATION.dataSource = self
        selectedOperation = "SAMPLE HAIRCUT"
        startdate = NSDate()
        enddate = startdate.addingTimeInterval(3600)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        let 🗄 = try! Realm()
        pickerData = 🗄.objects(💯.self).value(forKey: "operation") as! [String]
        OPERATION.reloadAllComponents()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
