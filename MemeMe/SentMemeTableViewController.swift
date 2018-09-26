//
//  SentMemeTableViewController.swift
//  MemeMe
//
//  Created by Kbotei on 9/22/18.
//  Copyright © 2018 Kbotei. All rights reserved.
//

import UIKit

class SentMemeTableViewController: UIViewController {
    var memes: [Meme]! {
        let object = UIApplication.shared.delegate
        let appDelegate = object as! AppDelegate
        return appDelegate.memes
    }

    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 100
        tableView.rowHeight = 100
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    @IBAction func addMemeButton(_ sender: Any) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let memeViewController = storyboard.instantiateViewController(withIdentifier: "CreateMeme") as! MemeViewController
        present(memeViewController, animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension SentMemeTableViewController: UITableViewDelegate {
    
}

extension SentMemeTableViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Count: \(memes.count)")
        return memes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "memeCell")!
        
        if memes.count > indexPath.row {
            let meme = memes[indexPath.row]
            cell.imageView?.image = meme.memedImage
            cell.textLabel?.text = "\(meme.topText) \(meme.bottomText)"
        }
        
        return cell
    }
}
