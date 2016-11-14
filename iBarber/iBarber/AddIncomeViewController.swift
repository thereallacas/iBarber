//
//  AddIncomeViewController.swift
//  iBarber
//
//  Created by Macbook Pro on 10/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit

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

class AddIncomeViewController: UIViewController {
    
    
    @IBAction func backgroundTouchUpInside(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    @IBOutlet weak var inputNameTextFieldForIncome: UITextField!
    
    @IBOutlet weak var nameSuggestionTableView: UITableView!
    
    @IBOutlet weak var TopConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var inputMoneyTextField: UITextField!
    
    var constantForPortrait: CGFloat?
    var constantForLandScape: CGFloat?
    var constantForPortraitWithKeyboard : CGFloat?
    var constantForLandScapeWithKeyboard : CGFloat?
    
    var autoCompletePossibilities = ["Hutter Iván", "Márkusné Eta", "Balog Erika", "Timár Laci", "Oláh Árpád", "Mészáros Lajos"]
    var autoComplete = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameSuggestionTableView.delegate = self
        inputNameTextFieldForIncome.delegate = self
        constantForPortrait = TopConstraint.constant
        constantForLandScape = constantForPortrait!/4
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
        print("keyboardwillshow")
        
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
        print("keyboardwillhide")
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

