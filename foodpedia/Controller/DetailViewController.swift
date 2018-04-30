//
//  DetailViewController.swift
//  foodpedia
//
//  Created by Fakhrus Ramadhan on 04/04/18.
//  Copyright © 2018 Fakhrus Ramadhan. All rights reserved.
//

import UIKit
import AlamofireImage

class DetailViewController: UIViewController {
    
    
    
    @IBOutlet weak var iv_foodPhoto: UIImageView!
    @IBOutlet weak var lb_foodName: UILabel!
    @IBOutlet weak var lb_foodCalories: UILabel!
    
    @IBOutlet weak var lb_diet: UILabel!
    @IBOutlet weak var lb_health: UILabel!
    
    
    // Initialize Embeded TableViewController
    private var embeddedViewController: IngredientsTableViewController!
    
    var foodData = Hits()
    var foodIndex : Int = 0
    var foodSavedData = [SavedFoodModel]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if foodSavedData.count > 0 {
            lb_foodName.text = foodSavedData[foodIndex].foodName
            lb_foodCalories.text = "\(foodSavedData[foodIndex].foodCalories) Calories"
        }else {
            setFromPrepareSegue()
        }
    }
    
    
    func setFromPrepareSegue(){
        
        print(foodData[foodIndex].recipe.label)
        
        lb_foodName.text = foodData[foodIndex].recipe.label
        iv_foodPhoto.af_setImage(withURL: URL(string: "\(foodData[foodIndex].recipe.image)")!)
        
        lb_foodCalories.text = "\(Int(foodData[foodIndex].recipe.calories))"
        
        lb_diet.numberOfLines = foodData[foodIndex].recipe.dietLabels.count
        lb_diet.text = foodData[foodIndex].recipe.dietLabels.joined(separator: " • ")
        
        lb_health.numberOfLines = foodData[foodIndex].recipe.healthLabels.count
        lb_health.text = foodData[foodIndex].recipe.healthLabels.joined(separator: " • ")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? IngredientsTableViewController,
            segue.identifier == "embed_ingredientTableView" {
            self.embeddedViewController = vc
        }
        
        if let destination = segue.destination as? WebKitRecipeViewController {
            destination.foodName = self.foodData[foodIndex].recipe.label
            
        }
    }
    
    
    //view will appear mean data will be delivered to -
    //embeded vc before it shows the table (view did load)
    override func viewWillAppear(_ animated: Bool) {
        
        self.embeddedViewController.foodIndex = self.foodIndex
        self.embeddedViewController.foodData = self.foodData
        
    }
    
    // Action when seach on google button clicked
    @IBAction func bt_searchRecipe(_ sender: Any) {
        
        performSegue(withIdentifier: "moveToWebKit", sender: self)
        
    }
    
}

    

