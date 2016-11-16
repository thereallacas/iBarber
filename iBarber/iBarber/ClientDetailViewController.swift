//
//  ClientDetailViewController.swift
//  iBarber
//
//  Created by Macbook Pro on 16/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit

class ClientDetailViewController: UIViewController {
    
    @IBOutlet weak var clientImage: UIImageView!
    
    @IBOutlet weak var clientNameLabel: UILabel!
    
    @IBOutlet weak var clientPhoneNumberButton: UIButton!
    
    @IBOutlet weak var clientDescriptionTextField: UITextView!
    
    @IBOutlet weak var bookinCalendarButton: UIButton!
    
    var selectedClient : 💇!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clientNameLabel.text = selectedClient.name
        clientPhoneNumberButton.setTitle(String(selectedClient.phoneNumber), for: .normal)
        clientDescriptionTextField.text = selectedClient.desc
        if (selectedClient.picture=="NOIMAGE"){
            clientImage.image = UIImage(named: "samplepic")
        }
        else{
            clientImage.image = getImage(filename: selectedClient.picture)
        }
    }
    
    func getDirectoryPath() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
        let documentsDirectory = paths[0]
        return documentsDirectory
    }
    
    func getImage(filename: String)-> UIImage{
        let fileManager = FileManager.default
        let imagePath = (self.getDirectoryPath() as NSString).appendingPathComponent(filename)
        if fileManager.fileExists(atPath: imagePath){
            return UIImage(contentsOfFile: imagePath)!
        }
        else{
            print("No Image")
            return UIImage(named: "samplepic")!
        }
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
