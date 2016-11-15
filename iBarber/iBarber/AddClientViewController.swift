//
//  AddClientViewController.swift
//  iBarber
//
//  Created by Macbook Pro on 12/11/16.
//  Copyright © 2016 Macbook Pro. All rights reserved.
//

import UIKit
import RealmSwift

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
    
    
    @IBAction func clientSaveButtonTouchUpInside(_ sender: AnyObject) {
        let client = 💇(value: ["name":inputPhoneNumberTextField?.text,"desc":AddClientDescriptionTextView?.text,"phoneNumber":Int((inputPhoneNumberTextField?.text)!)])
        try! 🗄.write {
            () -> Void in
            🗄.add(client)
        }
    }
    
    
    @IBAction func onBackgroundTouchUpInside(_ sender: AnyObject) {
        view.endEditing(true)
    }
  
    @IBOutlet weak var TopConstraint: NSLayoutConstraint!
    
    var constantForPortrait: CGFloat?
    var constantForLandScape: CGFloat?
    
    @IBOutlet weak var inputNameTextField: UITextField!
    
    @IBOutlet weak var inputPhoneNumberTextField: UITextField!
    
    @IBOutlet weak var AddClientDescriptionTextView: UITextView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        constantForPortrait = TopConstraint.constant
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
    
    
    //TODO - delete stupidity AND MAYBE ORIENTATION CHECK FOR keyboardsize.height/x
    func keyboardWillShow(notification: Notification) {
        //self.TopConstraint.constant = self.constantForPortrait!
        if (inputNameTextField.isEditing){
            //do nothing xdd
        }
        else {
            if let userInfo = notification.userInfo, let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue, let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
                UIView.animate(withDuration: duration, animations:{
                    if (self.inputPhoneNumberTextField.isEditing){
                    self.TopConstraint.constant = self.TopConstraint.constant+self.constantForPortrait!-self.TopConstraint.constant - keyboardSize.height
                    }
                    else {
                        self.TopConstraint.constant = self.TopConstraint.constant+self.constantForPortrait!-self.TopConstraint.constant-keyboardSize.height
                    }
                })
            }
        }
    }
    
    func keyboardWillHide(notification: Notification) {
        if let userInfo = notification.userInfo,
            let duration = (userInfo[UIKeyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue {
            UIView.animate(withDuration: duration) {
                self.TopConstraint.constant = self.constantForPortrait!
                self.view.layoutIfNeeded()
            }
        }}
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
