//
//  Meme.swift
//  MemeMe
//
//  Created by Kbotei on 8/25/18.
//  Copyright © 2018 Kbotei. All rights reserved.
//

import Foundation
import UIKit

struct Meme: Equatable {
    var topText: String
    
    var bottomText: String
    
    var originalImage: UIImage
    
    var memedImage: UIImage
    
    static func == (lhs: Meme, rhs: Meme) -> Bool {
        return lhs.topText == rhs.topText && lhs.bottomText == rhs.bottomText && lhs.originalImage.cgImage == rhs.originalImage.cgImage
    }
}
