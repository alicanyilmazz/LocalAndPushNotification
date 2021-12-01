//
//  ViewController.swift
//  LocalAndPushNotification
//
//  Created by alican on 27.11.2021.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var dateTextField: UITextField!
    
    private var notificationDate : DateComponents!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dateTextField.delegate = self
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
    
    
    @IBAction func setFullDateNotification(_ sender: UIButton) {
        LocalNotificationManager.setNotification(notificationDate, repeats: false, title: "Ohh My Gosh", body: "This is a exact notification", userInfo: ["aps" : ["father":"linus torvalds"]])
        
    }
}

extension ViewController : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIDatePicker().createDatePicker(_vc: self, textField: &dateTextField)
    }
    
    @objc func cancelButtonClick(){
        self.dateTextField.resignFirstResponder()
    }
   
    @objc func doneButtonClick(){
        if let dateAndTimePicker = self.dateTextField.inputView as? UIDatePicker{
            self.dateTextField.text = DateFormatter().convertDateToString(date: dateAndTimePicker.date)
            self.notificationDate = Calendar.current.dateComponents([.minute , .hour , .day , .month , .year], from: dateAndTimePicker.date)
        }
        self.dateTextField.resignFirstResponder()
    }
    
    @objc func datePickerHandler(datePicker : UIDatePicker){
        // You can use it to capture changes.
    }
}

