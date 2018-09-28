//
//  MemeDetailViewController.swift
//  MemeMe
//
//  Created by Kbotei on 9/25/18.
//  Copyright © 2018 Kbotei. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    var meme: Meme!

    override func viewDidLoad() {
        super.viewDidLoad()

        imageView.image = meme.memedImage
        
        // Hide tab bar using method found at https://stackoverflow.com/questions/28777943/hide-tab-bar-in-ios-swift-app
        tabBarController?.tabBar.isHidden = true
    }
    
    // Changed share button to allow for edit functionality.
    @IBAction func editMeme(_ sender: Any) {
        presentMemeCreator(with: meme)
    }
}
