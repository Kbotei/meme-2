//
//  ViewController.swift
//  MemeMe
//
//  Created by Kbotei on 8/21/18.
//  Copyright © 2018 Kbotei. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var actionButton: UIBarButtonItem!
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var navbar: UINavigationBar!
    @IBOutlet weak var toolbar: UIToolbar!
    @IBOutlet weak var topTextField: UITextField!
    @IBOutlet weak var bottomTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let memeTextAttributes:[String: Any] = [
            NSAttributedStringKey.foregroundColor.rawValue: UIColor.white,
            NSAttributedStringKey.font.rawValue: UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
            NSAttributedStringKey.strokeColor.rawValue: UIColor.black,
            NSAttributedStringKey.strokeWidth.rawValue: -4.0
        ]
        
        topTextField.defaultTextAttributes = memeTextAttributes
        topTextField.text = "TOP"
        topTextField.textAlignment = .center
        topTextField.delegate = self
        
        bottomTextField.defaultTextAttributes = memeTextAttributes
        bottomTextField.text = "BOTTOM"
        bottomTextField.textAlignment = .center
        bottomTextField.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraButton.isEnabled = UIImagePickerController.isSourceTypeAvailable(.camera)
    }

    @IBAction func shareMeme(_ sender: Any) {
        let memedImage = generateMemedImage()
        let meme = Meme(topText: "", bottomText: "", originalImage: imageView.image!, memedImage: memedImage)
    }
    
    @IBAction func selectImage(_ sender: Any) {
        guard let button = sender as? UIBarButtonItem else {
            print("Unknown button")
            return
        }
        
        let picker = UIImagePickerController()
        picker.sourceType = button.tag == 2 ? .camera : .photoLibrary
        picker.delegate = self
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        
    }
}

extension ViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
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

extension ViewController: UITextFieldDelegate {
    
}
