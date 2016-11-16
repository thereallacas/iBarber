//
//  AddIncomeViewController.swift
//  iBarber
//
//  Created by Macbook Pro on 10/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit
import RealmSwift

extension AddIncomeViewController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        let index = indexPath.row as Int
        cell.textLabel!.text = autoComplete[index]
        return cell
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autoComplete.count
    }
    
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat{
        return 20
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedCell : UITableViewCell = nameSuggestionTableView.cellForRow(at: indexPath)!
        inputNameTextFieldForIncome.text = selectedCell.textLabel!.text!
    }
}

extension AddIncomeViewController: UITextFieldDelegate{
    
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
}

extension AddIncomeViewController: UIPickerViewDataSource,UIPickerViewDelegate{
    
    
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
        priceOfSelectedOperation = priceData[row]
        pickerSelectionLabel.text = selectedOperation + ":" + String(priceOfSelectedOperation)
    }
}

class AddIncomeViewController: UIViewController {
    
    @IBAction func incomeSaveButtonTouchUpInside(_ sender: AnyObject) {
        
        let total = Int(inputMoneyTextField.text!)!
        let clientResult = 🗄.objects(💇.self).filter(NSPredicate(format: "name = %@", inputNameTextFieldForIncome.text!))
        
        var client : 💇!
        if (clientResult.isEmpty){
            client = 💇(value: ["name":inputNameTextFieldForIncome.text!])
        }
        else {
            client = clientResult.first!
        }
        
        let income = 💵(value: ["operation": selectedOperation,"price":priceOfSelectedOperation,"date":NSDate.init(),"client":client, "total":total])
        
        try! 🗄.write {
            () -> Void in
            🗄.add(income)
        }
    }
 
    @IBAction func onBackgroundTouchUpInside(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBOutlet weak var operationPickerView: UIPickerView!
    
    @IBOutlet weak var inputNameTextFieldForIncome: UITextField!
    
    @IBOutlet weak var nameSuggestionTableView: UITableView!
    
    @IBOutlet weak var TopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var inputMoneyTextField: UITextField!
    
    @IBOutlet weak var pickerSelectionLabel: UILabel!
    
    let pickerData: [String] = ["Férfi vágás","Férfi mosás vágás","Női mosás,vágás,szárítás"]
    let priceData: [Int] = [1460, 1880,3880]

    var constantForPortrait: CGFloat?
    var constantForLandScape: CGFloat?
    
    var selectedOperation: String = "Minta"
    var priceOfSelectedOperation : Int = 0
    
    var autoCompletePossibilities = ["Hutter Iván", "Márkusné Eta", "Balog Erika", "Timár Laci", "Oláh Árpád", "Mészáros Lajos"]
    var autoComplete = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameSuggestionTableView.delegate = self
        inputNameTextFieldForIncome.delegate = self
        operationPickerView.delegate = self
        operationPickerView.dataSource = self
        selectedOperation = pickerData[0]
        priceOfSelectedOperation = priceData[0]
        pickerSelectionLabel.text = pickerData[0]
        constantForPortrait = TopConstraint.constant
        constantForLandScape = constantForPortrait!/4
        print(constantForPortrait)
        print(constantForLandScape)
        autoCompletePossibilities = 🗄.objects(💇.self).value(forKey: "name") as! [String]
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(AddClientViewController.keyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AddClientViewController.keyboardWillHide), name: .UIKeyboardWillHide, object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func keyboardWillShow(notification: Notification) {
        if (inputNameTextFieldForIncome.isEditing){
            //do nothing xdd
        }
        else if (inputMoneyTextField.isEditing){
            if let userInfo = notification.userInfo, let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue, let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
                UIView.animate(withDuration: duration, animations:{
                    if (UIDevice.current.orientation.isPortrait){
                        self.TopConstraint.constant = self.TopConstraint.constant +
                            self.constantForPortrait!-self.TopConstraint.constant-keyboardSize.height/3
                    }
                    else {
                        self.TopConstraint.constant = self.TopConstraint.constant +
                            self.constantForLandScape!-self.TopConstraint.constant-keyboardSize.height/3
                    }
                 })
            }
        }
    }
    
    func keyboardWillHide(notification: Notification) {
        print(self.constantForPortrait)
        print(self.constantForLandScape)
        if let userInfo = notification.userInfo,
            let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
            UIView.animate(withDuration: duration) {
                if (UIDevice.current.orientation.isLandscape){
                    self.TopConstraint.constant = self.constantForLandScape!
                }
                else{
                    self.TopConstraint.constant = self.constantForPortrait!
                }
                self.view.layoutIfNeeded()
            }
        }}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

