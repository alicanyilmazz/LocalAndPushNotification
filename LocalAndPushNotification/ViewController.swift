//
//  ViewController.swift
//  LocalAndPushNotification
//
//  Created by alican on 27.11.2021.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    @IBAction func setNotification(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Local Notification", message: "Did you create it?", preferredStyle: .actionSheet)
        let setLocalNotificationAction = UIAlertAction(title: "Set", style: .default) { (action) in
            LocalNotificationManager.setNotification(5, of: .seconds, repeats: false, title: "Control", body: "You must check our body action.", userInfo: ["aps" : ["hello" : "wordl"]])
        }
        let removeLocalNotificationAction = UIAlertAction(title: "Remove", style: .default) { (action) in
            LocalNotificationManager.cancel()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { (action) in
            
        }
        alertController.addAction(setLocalNotificationAction)
        alertController.addAction(removeLocalNotificationAction)
        alertController.addAction(cancelAction)
        self.present(alertController, animated: true, completion: nil)
        
    }
    
}

