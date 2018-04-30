//
//  FoodTableViewController.swift
//  foodpedia
//
//  Created by Fakhrus Ramadhan on 03/04/18.
//  Copyright © 2018 Fakhrus Ramadhan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import HexColors

class FoodTableViewController: UITableViewController {
    
    var foodData = Hits()
    var foodIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        let search = UISearchController(searchResultsController: nil)
        search.searchResultsUpdater = self as! UISearchResultsUpdating
        
        
        self.navigationItem.searchController = search
        
        callNetwork(keyword : "Chicken")
      
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return foodData.count
    }
    
    // TABLE HEIGHT
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        if indexPath.row == 0{
//            //.... return height whatever you want for indexPath.row
//            return 40
//        }else {
//            return 30
//        }
        
        return 130
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cellIdentifier = "foodTableCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FoodTableViewCell  else {
            fatalError("The dequeued cell is not an instance of MovieTableViewCell.")
        }
        
        // Configure the cell...
        
        let food = foodData[indexPath.row].recipe
        
        let foodImageURL = URL(string: food.image)
        cell.iv_foodImage.af_setImage(withURL: foodImageURL!)
        
        cell.lb_foodTitle.text = food.label
        cell.lb_foodCalories.text = "Calories  :  \(Int(food.calories))"
        
        let warna : UIColor = UIColor("#badc58")!
        cell.v_foodCell.layer.borderColor = warna.cgColor
        cell.v_foodCell.layer.borderWidth = 1

        return cell
    }

    
    func callNetwork(keyword : String) {
        
//        alertLoading()
        
        let params : Parameters = [
            "q":"\(keyword)",
            "app_id":"\(APP_ID)",
            "app_key":"\(APP_KEY)"
        ]
    
        let urlString = "\(BASE_URL)\(Search)"
        
        Alamofire.request(urlString, parameters: params).responseJSON { (response) in
            
            let result = response.data
            
            do {
                let foodResult = try JSONDecoder().decode(Food.self, from: result!)
                
//                print(response.response!.statusCode)
                print(response)
                
                    
                    self.foodData = foodResult.hits
                    self.tableView.reloadData()
//                    self.tableView.separatorStyle = .none

//                self.dismiss(animated: true, completion: nil)
            }catch let error {
                print("error message \(error)")
//                self.dismiss(animated: true, completion: nil)
            }
        }
    }
 
    //SET ON CLICK at food cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.foodIndex = indexPath.row
        performSegue(withIdentifier: "showDetail", sender: self)
    }
    // PREPARE SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.foodData = self.foodData
            destination.foodIndex = self.foodIndex

        }
    }
    
    func alertLoading () {
        let alert = UIAlertController(title: "Loading", message: "Tunggu sebentar ...", preferredStyle: .alert)

        self.present(alert, animated: true, completion: nil)  //Show Alert Dialog
    }
    
    
    // SLIDE OPTION
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
//        let delete = UITableViewRowAction(style: .destructive, title: "Delete") { (action, indexPath) in
//            // delete item at indexPath
//            self.foodData.remove(at: indexPath.row)
//            tableView.deleteRows(at: [indexPath], with: .fade)
//        }
        
        let bookmark = UITableViewRowAction(style: .normal, title: "Bookmark") { (action, indexPath) in
            // save item at indexPath
            
            
            let foodName = self.foodData[indexPath.row].recipe.label
            let foodCalories = self.foodData[indexPath.row].recipe.calories
            let foodImage = self.foodData[indexPath.row].recipe.image
            
            if CoreDataHandler.saveObjectFood(foodName: foodName, foodCalories: Int32(foodCalories), foodImage: foodImage) {
                
                AlertHelper.alertPopUp(title: "Food Bookmark", description: "your food has been saved in collection", viewController: self)
            }else {
                AlertHelper.alertPopUp(title: "Info", description: "fail to collect your food", viewController: self)
            }
        }
        
        // color literal
        bookmark.backgroundColor = #colorLiteral(red: 0.9529411793, green: 0.6862745285, blue: 0.1333333403, alpha: 1)
        
//        return [delete, bookmark]
        return [bookmark]

        
    }
    

}

// search and reload
extension FoodTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text, !text.isEmpty {
            
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) { // change 2 to desired number of seconds
                // Your code with delay
                self.callNetwork(keyword : searchController.searchBar.text!)
            }
        }
        else {
         
        }
        self.tableView.reloadData()
    }
}
