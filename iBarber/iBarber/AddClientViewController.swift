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

extension AddClientViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        clientImageView.image = selectedImage
        dismiss(animated: true, completion: nil)
    }
}

class AddClientViewController: UIViewController {
    @IBAction func SelectImageTouchUpInside(_ sender: AnyObject) {
        let picker = UIImagePickerController()
        picker.delegate = self
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler: {
            action in
            picker.sourceType = .camera
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Photo Library", style: .default, handler: {
            action in
            picker.sourceType = .photoLibrary
            self.present(picker, animated: true, completion: nil)
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func clientSaveButtonTouchUpInside(_ sender: AnyObject) {
        
        if (inputNameTextField.text=="" || inputPhoneNumberTextField.text=="" ||
            AddClientDescriptionTextView.text==""){
            let alertController = UIAlertController(title: "Error", message: "One or more field is empty.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                NSLog("OK Pressed")
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        if (Int(inputPhoneNumberTextField.text!)==nil && !(inputPhoneNumberTextField.text!.contains("+"))){
            let alertController = UIAlertController(title: "Error", message: "Invalid phone number format", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                NSLog("OK Pressed")
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
        }
        if (inputNameTextField.text! != "" && inputPhoneNumberTextField.text! != "" && (Int(inputPhoneNumberTextField.text!) != nil || inputPhoneNumberTextField.text!.contains("+"))) {
            if (clientImageView.image==nil){
                imagePath = "NOIMAGE"
            }
            else{
                imagePath = inputNameTextField.text!+"client.jpg"
                saveImageDocumentDirectory(filename: imagePath)
            }
        let name = inputNameTextField.text!
        let desc = AddClientDescriptionTextView.text!
        let phonenumber = inputPhoneNumberTextField.text!
        
        let 🗄 = try! Realm()
        
            let client = 💇()
            client.name = name
            client.desc = desc
            client.phoneNumber = phonenumber
            client.picture = imagePath
        try! 🗄.write {
            () -> Void in
            🗄.add(client, update: true)
        }
            let alertController = UIAlertController(title: "Success", message: "Client saved to the database.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) {
                UIAlertAction in
                NSLog("OK Pressed")
            }
            alertController.addAction(okAction)
            self.present(alertController, animated: true, completion: nil)
            view.endEditing(true)
        }
    }
    
    @IBAction func onBackgroundTouchUpInside(_ sender: AnyObject) {
        view.endEditing(true)
    }
    
    
    @IBOutlet weak var selectImageButton: UIButton!
  
    @IBOutlet weak var TopConstraint: NSLayoutConstraint!
    
    var constantForPortrait: CGFloat?
    var constantForLandScape: CGFloat?
    
    @IBOutlet weak var inputNameTextField: UITextField!
    
    @IBOutlet weak var inputPhoneNumberTextField: UITextField!
    
    @IBOutlet weak var AddClientDescriptionTextView: UITextView!
    
    @IBOutlet weak var clientImageView: UIImageView!
    
    var imagePath: String!
    
    //MARK - IMAGESAVING
    
    func saveImageDocumentDirectory(filename: String){
        let fileManager = FileManager.default
        let paths = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString).appendingPathComponent(filename)
        let image = clientImageView.image
        print(paths)
        let imageData = UIImageJPEGRepresentation(image!, 0.5)
        fileManager.createFile(atPath: paths as String, contents: imageData, attributes: nil)
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
