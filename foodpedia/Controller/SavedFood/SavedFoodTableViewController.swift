//
//  SavedFoodTableViewController.swift
//  foodpedia
//
//  Created by Fakhrus Ramadhan on 23/04/18.
//  Copyright © 2018 Fakhrus Ramadhan. All rights reserved.
//

import UIKit

class SavedFoodTableViewController: UITableViewController {
    
    var foodSavedData = [SavedFoodModel]()
    var loadSavedData = CoreDataHandler.fetchFoodObject()!
    
    var foodIndex = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.loadCoreData()
        self.tableView.reloadData()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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
        return self.foodSavedData.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cellIdentifier = "savedFoodDataCell"
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? SavedFoodTableViewCell  else {
            fatalError("The dequeued cell is not an instance of SavedFoodTableViewCell.")
        }
        
        cell.lb_savedName.text = self.foodSavedData[indexPath.row].foodName!
        cell.lb_savedCalories.text = "\(Int(self.foodSavedData[indexPath.row].foodCalories!)) Calories"
        
        let urlImage = URL(string : self.foodSavedData[indexPath.row].foodImage!)
        cell.iv_savedImage.af_setImage(withURL: urlImage!)

        
        return cell
    }
    
    func loadCoreData () {
        
        
        
        for i in loadSavedData {
            
            let objectFood = SavedFoodModel(foodName: i.foodName!, foodCalories: Double(i.foodCalories), foodImage: i.foodImage!)
            
            self.foodSavedData.append(objectFood)
            
        }
        
    }
    
    // TABLE HEIGHT
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 130
    }
    
    // SLIDE DELETE
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.foodSavedData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            CoreDataHandler.deleteObjectFood(objectIndex: loadSavedData[indexPath.row])
            self.tableView.reloadData()
        }
    }
    
    //SET ON CLICK at food cell
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.foodIndex = indexPath.row
        performSegue(withIdentifier: "showDetailFromSavedFood", sender: self)
    }
    // PREPARE SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.foodSavedData = self.foodSavedData
            destination.foodIndex = self.foodIndex
            
        }
    }

    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
