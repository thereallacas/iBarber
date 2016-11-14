//
//  AddClientViewController.swift
//  iBarber
//
//  Created by Macbook Pro on 12/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit

extension AddClientViewController: UITextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        if (textView.text == "Add description..."){
            textView.text = ""
            textView.textColor = UIColor.black
            
        }
        textView.becomeFirstResponder()
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        if (textView.text==""){
            textView.text="Add description..."
            textView.textColor = UIColor.gray
            
        }
        textView.resignFirstResponder()
    }
}

class AddClientViewController: UIViewController {
    
    
    @IBAction func onBackgroundTouchUpInside(_ sender: AnyObject) {
        view.endEditing(true)
    }
    @IBOutlet weak var TopConstraint: NSLayoutConstraint!
    
    var constant: CGFloat?
    
    @IBOutlet weak var inputNameTextField: UITextField!
    
    @IBOutlet weak var inputPhoneNumberTextField: UITextField!
    
    @IBOutlet weak var AddClientDescriptionTextView: UITextView!
    
    @IBOutlet weak var constraint: NSLayoutConstraint!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constant = TopConstraint.constant
        AddClientDescriptionTextView.delegate = self
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
        self.TopConstraint.constant = self.constant!
        if (inputNameTextField.isEditing){
            //do nothing xdd
        }
        else if (inputPhoneNumberTextField.isEditing){
            if let userInfo = notification.userInfo, let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue, let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
                UIView.animate(withDuration: duration, animations:{ self.TopConstraint.constant = self.TopConstraint.constant - keyboardSize.height/2})
            }
        }
        else if let userInfo = notification.userInfo, let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue, let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
            UIView.animate(withDuration: duration, animations:{ self.TopConstraint.constant = self.TopConstraint.constant - keyboardSize.height})
        }
    }
    
    func keyboardWillHide(notification: Notification) {
        if let userInfo = notification.userInfo,
            let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
            UIView.animate(withDuration: duration) {
                self.TopConstraint.constant = self.constant!
                self.view.layoutIfNeeded()
            }
        }}
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
