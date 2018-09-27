//
//  UIViewController+ShareSheet.swift
//  MemeMe
//
//  Created by Kbotei on 9/26/18.
//  Copyright © 2018 Kbotei. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func presentShareSheet(for memedImage: UIImage, completionHandler: @escaping (UIActivity.ActivityType?, Bool, [Any]?, Error?) -> Void) {
        let shareSheet = UIActivityViewController(activityItems: [memedImage], applicationActivities: nil)
        shareSheet.completionWithItemsHandler = completionHandler
        
        // Prevent ipad crash - see chosen answer notes section
        // https://stackoverflow.com/questions/35931946/basic-example-for-sharing-text-or-image-with-uiactivityviewcontroller-in-swift
        shareSheet.popoverPresentationController?.sourceView = self.view
        present(shareSheet, animated: true, completion: nil)
    }
}
