//
//  clientTableViewController.swift
//  iBarber
//
//  Created by Macbook Pro on 14/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit
import RealmSwift

class clientTableViewController: UITableViewController {
    
    var 💇💇💇 : Results<💇>!
    
    @IBOutlet var clientTableView: UITableView!
    
    @IBOutlet weak var ClientSegmentedControl: UISegmentedControl!
    
    @IBAction func selectedSegmentChanged(_ sender: UISegmentedControl) {
        switch ClientSegmentedControl.selectedSegmentIndex
        {
        case 0:
           💇💇💇 = 💇💇💇.sorted(byProperty: "name")
        case 1:
            💇💇💇 = 💇💇💇.sorted(byProperty: "incomeCount", ascending: false)
        default:
            break; 
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        readclientAndUpdateUI()
    }
    
    
    func readclientAndUpdateUI(){
        let 🗄 = try! Realm()
        💇💇💇 = 🗄.objects(💇.self).sorted(byProperty: "name")
        self.clientTableView.setEditing(false, animated: true)
        self.clientTableView.reloadData()
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
        return 💇💇💇.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showClientDetail", sender: self.💇💇💇[indexPath.row])
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ClientCell") as! 💇Cell
        let client = self.💇💇💇[indexPath.row]
        cell.nameLabel.text = client.name
        cell.PhoneLabel.text = String(client.phoneNumber)
        return cell
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == "showClientDetail"){
            let clientDetailViewController = segue.destination as! ClientDetailViewController
            clientDetailViewController.selectedClient = sender as! 💇 }
        if (segue.identifier == "showAddClientDetail"){
            //canidie
        }
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let clientToBeDeleted = 💇💇💇[indexPath.row]
            let alertController = UIAlertController(title: "Warning", message: "Incomes for that client will also be deleted", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                NSLog("OK Pressed")
                let 🗄 = try! Realm()
                try!🗄.write({ () -> Void in
                    🗄.delete(clientToBeDeleted.incomes)
                })
                try!🗄.write({ () -> Void in
                    🗄.delete(clientToBeDeleted)
                })
                self.clientTableView.deleteRows(at: [indexPath], with: .fade)
                self.readclientAndUpdateUI()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel){
                UIAlertAction in
                NSLog("Cancel Pressed")
                self.readclientAndUpdateUI()
            }
            alertController.addAction(okAction)
            alertController.addAction(cancelAction)
            self.present(alertController, animated: true, completion: nil)
        }
    }
}
