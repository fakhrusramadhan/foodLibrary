//
//  LoginViewController.swift
//  foodpedia
//
//  Created by Fakhrus Ramadhan on 17/04/18.
//  Copyright © 2018 Fakhrus Ramadhan. All rights reserved.
//

import UIKit
import UserNotifications
import GoogleSignIn

class LoginViewController: UIViewController, UNUserNotificationCenterDelegate, GIDSignInUIDelegate {
    
    @IBOutlet weak var tf_username: UITextField!
    @IBOutlet weak var tf_password: UITextField!
    
    var username : String?
    var password : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        GIDSignIn.sharedInstance().uiDelegate = self
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func moveToHome(_ sender: Any) {
        
        if (tf_username.text?.isEmpty)! || (tf_password.text?.isEmpty)! {
            AlertHelper.alertPopUp(title: "Peringatan", description: "Mohon lengkapi form terlebih dahulu", viewController: self)
            
            
        }else {
            // Get data from textfield
            self.username = tf_username.text
            self.password = tf_password.text
            
            // Save data to coredata
            //        CoreDataHandler.saveObject(username: username!, password: password!)
            
            // perform segue move to home
            performSegue(withIdentifier: "moveToHomeFromLogin", sender: self)
            
            pushNotif()
            
        }
    }
    
    
    @IBAction func backToWelcome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func pushNotif() {
        
        UNUserNotificationCenter.current().getNotificationSettings { (notificationSettings) in
            switch notificationSettings.authorizationStatus {
            case .notDetermined:
                // Request Authorization
                print("Request Authorization")
                self.requestAuthorization(completionHandler: { (success) in
                    guard success else { return }
                    
                    // Schedule Local Notification
                })
            case .authorized:
                // Schedule Local Notification
                print("Schedule Local Notification")
                self.scheduleLocalNotification()
            case .denied:
                print("Application Not Allowed to Display Notifications")
            }
        }
    }
    
    
    private func requestAuthorization(completionHandler: @escaping (_ success: Bool) -> ()) {
        // Request Authorization or Request Permission
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { (success, error) in
            if let error = error {
                print("Request Authorization Failed (\(error), \(error.localizedDescription))")
            }
            
            completionHandler(success)
        }
    }
    
    
    private func scheduleLocalNotification() {
        // Create Notification Content
        let notificationContent = UNMutableNotificationContent()
        
        // Configure Notification Content
        notificationContent.title = "FoodPedia"
        notificationContent.subtitle = "Hi, \(self.username!)"
        notificationContent.body = "Welcome To FoodPedia Apps!"
        notificationContent.badge = 1
        notificationContent.sound = UNNotificationSound.default()
        
        // Add Trigger
        let notificationTrigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        // Create Notification Request
        let notificationRequest = UNNotificationRequest(identifier: "localNotif", content: notificationContent, trigger: notificationTrigger)
        
        // Add Request to User Notification Center
        UNUserNotificationCenter.current().add(notificationRequest) { (error) in
            if let error = error {
                print("Unable to Add Notification Request (\(error), \(error.localizedDescription))")
            }
        }
    }
    
}
