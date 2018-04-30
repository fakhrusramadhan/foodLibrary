//
//  ProfileViewController.swift
//  foodpedia
//
//  Created by Fakhrus Ramadhan on 17/04/18.
//  Copyright © 2018 Fakhrus Ramadhan. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var lb_usernameProfile: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if !CoreDataHandler.detectIsNil() {
            loadCoreData()
        }else {
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func loadSavedFood(_ sender: Any) {
        performSegue(withIdentifier: "mySavedFoodCollection", sender: self)
    }
    
    func loadCoreData () {
        
        let user : [User] = CoreDataHandler.fetchObject()!
        
        let username = user[0].username
        
        self.lb_usernameProfile.text = username
        
//        for i in user! {
//            print(i.username)
//        }
        

    }
    
    @IBAction func logoutAction(_ sender: Any) {
        CoreDataHandler.cleanDelete()
        
       
//        let storyboard = UIStoryboard(name:"Main", bundle: nil)
//
//        let goToWelcome = storyboard.instantiateViewController(withIdentifier: "WelcomeVC")
//
//       // Shut Down ViewController and go to Welcome Page
//        self.dismiss(animated: true, completion: {
//         self.present(goToWelcome, animated: true, completion: nil)
//        })
        
        self.performSegue(withIdentifier: "unwindLogout", sender: self)
        
    }
    
}
