//
//  UITextField+Setup.swift
//  MemeMe
//
//  Created by Kbotei on 9/5/18.
//  Copyright © 2018 Kbotei. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setupTextField(text: String, delegate: UITextFieldDelegate, attributes: [String : Any]) {
        self.defaultTextAttributes = attributes
        self.text = text
        self.textAlignment = .center
        self.delegate = delegate
    }
}
