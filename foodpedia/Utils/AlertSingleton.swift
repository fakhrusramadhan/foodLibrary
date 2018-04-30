//
//  AlertSingleton.swift
//  foodpedia
//
//  Created by Fakhrus Ramadhan on 19/04/18.
//  Copyright © 2018 Fakhrus Ramadhan. All rights reserved.
//

import UIKit

class AlertHelper {
    
    static func alertPopUp(title:String, description:String, viewController:UIViewController) {
        let alertView = UIAlertController(title: title, message: description, preferredStyle: .alert)
        
        //actionsheet bottom popup || alert center popup
        
        let cancel = UIAlertAction(title: "OK", style: .default) { (action) in
            
            // style default blue, destructive red
            //do nothing dismiss
        }
        
        alertView.addAction(cancel)
        
        viewController.present(alertView, animated: true, completion: nil)
    }
    
}
