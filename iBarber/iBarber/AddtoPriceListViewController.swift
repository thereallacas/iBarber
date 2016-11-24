//
//  AddtoPriceListViewController.swift
//  iBarber
//
//  Created by Macbook Pro on 23/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit

class AddtoPriceListViewController: UIViewController {

    
    @IBOutlet weak var addpricelistnametextfield: UITextField!
    
    @IBOutlet weak var addpricelistpricetextfield: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func AddTOPriceListTouchUpInside(_ sender: AnyObject) {
        
        if (addpricelistpricetextfield.text! == "" || addpricelistpricetextfield.text! == ""){
            let alertController = UIAlertController(title: "Error", message: "One or more field is empty.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                NSLog("OK Pressed")
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        if (Int(addpricelistpricetextfield.text!)==nil){
            let alertController = UIAlertController(title: "Error", message: "Invalid phone number format", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                NSLog("OK Pressed")
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        if (addpricelistnametextfield.text! != "" && addpricelistpricetextfield.text! != "" && Int(addpricelistpricetextfield.text!) != nil) {
        let name = addpricelistnametextfield.text!
        let price = Int(addpricelistpricetextfield.text!)!
        let pricetag = 🗄.object(ofType: 💯.self, forPrimaryKey: name)
        
        if pricetag == nil{
            let pricetoadd = 💯(value: ["operation": name, "price": price])
            try! 🗄.write {
                () -> Void in
                🗄.add(pricetoadd)
            }
        }
        }
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
