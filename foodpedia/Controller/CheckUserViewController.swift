//
//  CheckUserViewController.swift
//  foodpedia
//
//  Created by Fakhrus Ramadhan on 25/04/18.
//  Copyright © 2018 Fakhrus Ramadhan. All rights reserved.
//

import UIKit

class CheckUserViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        checkLoggedIn()
    }
    
    
    func checkLoggedIn() {
        
        print("WILL CHECK CORE DATA")
        
        if CoreDataHandler.detectIsNil() {
            // perform segue move to home
            performSegue(withIdentifier: "toWelcomeVC", sender: self)
            
            print("GO TO WELCOME VC")
        } else {
            // perform segue move to home
            performSegue(withIdentifier: "toHomeVC", sender: self)
            print("GO TO HOME VC")
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // UNWIND - TAKE ACTION FROM A VIEW CONTROLLER THAT HAS BEEN EXIT
    @IBAction func prepareForUnwind(segue: UIStoryboardSegue) {
        
    }

}
