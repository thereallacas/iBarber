//
//  AddIncomeViewController.swift
//  iBarber
//
//  Created by Macbook Pro on 10/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit

class AddIncomeViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate, UITableViewDataSource{
    

   
    @IBOutlet weak var inputNameTextField: UITextField!
    
    
    @IBOutlet weak var nameSuggestionTableView: UITableView!
    
    
    
    
    
    var autoCompletePossibilities = ["jani", "dezső", "laci", "lali"]
    var autoComplete = [String]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        inputNameTextField.delegate = self
        nameSuggestionTableView.delegate = self

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK - TableViewDataSource
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let index = indexPath.row as Int
        cell.textLabel!.text = autoComplete[index]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoComplete.count
    }
    
    
    
    // MARK - UITextFieldDelegate
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool{
        
        let substring = (textField.text! as NSString).replacingCharacters(in: range, with: string)
        
        searchAutocompleteEntriesWithSubstring(substring: substring)
        return true
    }
    
    func searchAutocompleteEntriesWithSubstring(substring: String)
    {
        autoComplete.removeAll(keepingCapacity: false)
       
        for key in autoCompletePossibilities {
            let myString : NSString! = key as NSString
            let substringRange : NSRange = myString.range(of: substring)
            if (substringRange.location == 0){
                autoComplete.append(key)
            }
           nameSuggestionTableView.reloadData()
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
