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
    }
    
    @IBAction func shareMeme(_ sender: Any) {
        let completionHandler: (UIActivity.ActivityType?, Bool, [Any]?, Error?) -> Void = { (activityType, completed, returnedItems, activityError) in
            self.navigationController?.popViewController(animated: true)
        }
        
        presentShareSheet(for: meme.memedImage, completionHandler: completionHandler)
    }
}
