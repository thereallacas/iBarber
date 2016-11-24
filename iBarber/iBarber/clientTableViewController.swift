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
        💇💇💇 = 🗄.objects(💇.self)
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
            try!🗄.write({ () -> Void in
                🗄.delete(clientToBeDeleted)
            })
            
            clientTableView.deleteRows(at: [indexPath], with: .fade)
            self.readclientAndUpdateUI()
        }
    }


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

}
