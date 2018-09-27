//
//  ViewController.swift
//  MemeMe
//
//  Created by Kbotei on 8/21/18.
//  Copyright © 2018 Kbotei. All rights reserved.
//

import UIKit

class MemeViewController: UIViewController {

    @IBOutlet weak var shareButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    var memedImage: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let memeTextAttributes:[String: Any] = [
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.strokeWidth.rawValue: -4.0
        ]
        
        //Moved text field setup into an extension method
        topTextField.setupTextField(text: "TOP", delegate: self, attributes: memeTextAttributes)
        bottomTextField.setupTextField(text: "BOTTOM", delegate: self, attributes: memeTextAttributes)
        
        shareButton.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        subscribeToKeyboardNotifications()
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        guard imageView.image != nil else {
            let alert = UIAlertController(title: "Select an Image", message: "Please select an image before sharing.", preferredStyle: .alert)
            alert.addAction(.init(title: "Ok", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
            return
        }
        
        memedImage = generateMemedImage()
        
        let completionHandler: (UIActivity.ActivityType?, Bool, [Any]?, Error?) -> Void = { (activityType, completed, returnedItems, activityError) in
            if completed {
                self.save()
            }
            
            self.dismiss(animated: true, completion: nil)
        }
        
        presentShareSheet(for: memedImage, completionHandler: completionHandler)
    }
    
    
    @IBAction func selectCamera(_ sender: Any) {
        presentImagePicker(source: .camera)
    }
    
    @IBAction func selectImage(_ sender: Any) {
        presentImagePicker(source: .photoLibrary)
    }
    
    @IBAction func cancel(_ sender: Any) {
        imageView.image = nil
        topTextField.text = "TOP"
        bottomTextField.text = "BOTTOM"
        shareButton.isEnabled = false
        self.dismiss(animated: true, completion: nil)
    }
    
    func subscribeToKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: .UIKeyboardWillHide, object: nil)
    }
    
    func unsubscribeToKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: .UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if bottomTextField.isFirstResponder {
            view.frame.origin.y = -getKeyboardHeight(notification)
        }
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        view.frame.origin.y = 0
    }
    
    func getKeyboardHeight(_ notification: Notification) -> CGFloat {
        let keyboardSize = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        return keyboardSize.cgRectValue.height
    }
    
    func presentImagePicker(source: UIImagePickerControllerSourceType) {
        let picker = UIImagePickerController()
        picker.sourceType = source
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    func save() {
        let meme = Meme(topText: topTextField.text ?? "", bottomText: bottomTextField.text ?? "", originalImage: imageView.image!, memedImage: memedImage)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.memes.append(meme)
    }
}

extension MemeViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            shareButton.isEnabled = true
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func generateMemedImage() -> UIImage {
        toolbar.isHidden = true
        navbar.isHidden = true
        
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawHierarchy(in: self.view.frame, afterScreenUpdates: true)
        let memedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        toolbar.isHidden = false
        navbar.isHidden = false
        
        return memedImage
    }
}

extension MemeViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.text = ""
    }
    
    // Use technique found at Stack Overflow to dismiss the keyboard.
    // https://stackoverflow.com/questions/274319/how-do-you-dismiss-the-keyboard-when-editing-a-uitextfield
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}
