//
//  incomeTableTableViewController.swift
//  iBarber
//
//  Created by Macbook Pro on 14/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit
import RealmSwift

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
        // or use capitalized(with: locale) if you want
    }
}


class incomeTableViewController: UITableViewController {
    
    var 💵💵💵 : Results<💵>!
    var sections : Dictionary<String, Array<💵>>!
    var sortedSections : Array<String>!
    
    @IBOutlet var incomeTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func readincomeAndUpdateUI(){
        💵💵💵 = 🗄.objects(💵.self)
        sections = Dictionary<String, Array<💵>>()
        sortedSections = Array<String>()
        💵💵💵 = 💵💵💵.sorted(byProperty: "time",ascending: false)
        for income in 💵💵💵
        {
            let key = dateSectionHeaderFormatter(dt: income.time)
            let incomesOnDatDay = sections[key]
            if incomesOnDatDay==nil {
                self.sections[key] = [income]
            }
            else {
                self.sections[key]?.append(income)
            }
        }
        self.sortedSections = [String](sections.keys)
        self.incomeTableView.setEditing(false, animated: true)
        self.incomeTableView.reloadData()
    }
    
    func dateSectionHeaderFormatter(dt: NSDate)->String{
        let calendar = NSCalendar.current
        let date = dt as Date
        let day = calendar.component(.day, from: date)
        let month = calendar.component(.month, from: date)
        let year = calendar.component(.year, from: date)
        return String(year)+"."+String(month)+"."+String(day)+", "+date.dayOfWeek()!
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readincomeAndUpdateUI()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sections.keys.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let count = sections[sortedSections[section]]!.count
        if count == 0 {
            return 1
        }
        else{
            return count
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sortedSections[section]
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "IncomeCell") as! 💵Cell
        let tableSection = sections[sortedSections[indexPath.section]]
        let incomerow = tableSection![indexPath.row]
        cell.Operation?.text = incomerow.operation
        cell.ClientName?.setTitle(incomerow.client?.name, for: .normal)
        let date = incomerow.time
        let calendar = NSCalendar.current
        let hour = calendar.component(.hour, from: date as Date)
        let minutes = calendar.component(.minute, from: date as Date)
        cell.Date?.text  = String(hour) + ":" + String(minutes)
        cell.Price?.text = String(incomerow.price) + " Ft"
        cell.Total?.text = String(incomerow.total) + " Ft"
        return cell
    }
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     
        var tableSection = sections[sortedSections[indexPath.section]]
        let incomeToBeDeleted = tableSection![indexPath.row]
        tableSection?.remove(at: indexPath.row)
        if tableSection?.count==0{
            sections.removeValue(forKey: sortedSections[indexPath.section])
        }
        
        try!🗄.write({ () -> Void in
            🗄.delete(incomeToBeDeleted)
        })
        self.readincomeAndUpdateUI()
     }
     }
    
    
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
        if segue.identifier == "showClientDetailFromIncome"{
            let vc = segue.destination as! ClientDetailViewController
            let senderbutton = sender as! UIButton
            let client = 🗄.object(ofType: 💇.self, forPrimaryKey: senderbutton.titleLabel?.text!)
            vc.selectedClient = client
     }
    
    }
}
