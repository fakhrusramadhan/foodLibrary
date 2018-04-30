//
//  RegisterViewController.swift
//  foodpedia
//
//  Created by Fakhrus Ramadhan on 10/04/18.
//  Copyright © 2018 Fakhrus Ramadhan. All rights reserved.
//

import UIKit

class RegisterViewController: UIViewController {
    
    @IBOutlet weak var tf_username: UITextField!
    
    @IBOutlet weak var tf_password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func moveToHome(_ sender: Any) {
        
        // Get data from textfield
        let username = tf_username.text
        let password = tf_password.text
        
        // Save data to coredata
        CoreDataHandler.saveObject(username: username!, password: password!)
        
        // perform segue move to home
        performSegue(withIdentifier: "moveToHomeFromRegister", sender: self)
        
    }
    
    
    // PREPARE SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? FoodTableViewController {
            
        }
    }
    
    
    @IBAction func backToWelcome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
