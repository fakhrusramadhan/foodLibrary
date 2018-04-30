//
//  FoodCollectionViewController.swift
//  foodpedia
//
//  Created by Fakhrus Ramadhan on 09/04/18.
//  Copyright © 2018 Fakhrus Ramadhan. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

private let reuseIdentifier = "cell_food_grid"

class FoodCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var foodData = Hits()
    var foodIndex = 0
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        callNetwork(keyword : "Fish")

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func callNetwork(keyword : String) {
        
        
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

                self.foodData = foodResult.hits
                self.collectionView?.reloadData()
                
            }catch let error {
                print("error message \(error)")
            }
        }
    }

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return self.foodData.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! FoodCollectionViewCell
        // Configure the cell
        
        let imageURL = URL(string: self.foodData[indexPath.row].recipe.image)
        cell.iv_food_grid.af_setImage(withURL: imageURL!)
//        cell.lb_foodName_grid.text = self.foodData[indexPath.row].recipe.label
        cell.layer.cornerRadius = 10
    
        return cell
    }
    
    
    // STATIC CELL SIZE
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
//        let screenSize : CGRect = UIScreen.main.bounds
//
//        var widthCell = 0
//        var heightCell = 0
//
//        if screenSize.width == 320 {
//
//            widthCell = 130
//            heightCell = 130
//
//        }
//
//        if screenSize.width == 375 {
//
//            widthCell = 160
//            heightCell = 160
//
//        }
//
//        if screenSize.width == 414 {
//
//            widthCell = 180
//            heightCell = 180
//
//        }
//
//        if screenSize.width == 768 {
//
//            widthCell = 230
//            heightCell = 230
//
//        }
//
//        if screenSize.width == 834 {
//
//            widthCell = 250
//            heightCell = 250
//
//        }
//
//        if screenSize.width == 1024 {
//
//            widthCell = 310
//            heightCell = 310
//
//        }
//
//        return CGSize(width: widthCell, height: heightCell)
        
            let yourWidth = collectionView.bounds.width/3.0
            let yourHeight = yourWidth
            
            return CGSize(width: yourWidth, height: yourHeight)
    }
    
    //SET ON CLICK at food cell
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        self.foodIndex = indexPath.row
        performSegue(withIdentifier: "showDetailGrid", sender: self)
    }
    // PREPARE SEGUE
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.foodData = self.foodData
            destination.foodIndex = self.foodIndex
            
        }
    }
    
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let yourWidth = collectionView.bounds.width/3.0
//        let yourHeight = yourWidth
//
//        return CGSize(width: yourWidth, height: yourHeight)
//    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    
}
