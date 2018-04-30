//
//  CoreDataHandler.swift
//  foodpedia
//
//  Created by Fakhrus Ramadhan on 17/04/18.
//  Copyright © 2018 Fakhrus Ramadhan. All rights reserved.
//

import UIKit
import CoreData

class CoreDataHandler: NSObject {

    // Call AppDelegate and Return NSManagedObjectContext
    private class func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        return appDelegate.persistentContainer.viewContext
    }
    
    // Save Object (User with atribute username and password)
    class func saveObject(username:String, password:String) -> Bool {
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(username, forKey: "username")
        manageObject.setValue(password, forKey: "password")
        
        do {
            try context.save()
            return true
        }catch {
            return false
        }
    }
    
    // Save Object (User with atribute username and password)
    class func saveObjectFood(foodName:String, foodCalories:Int32, foodImage:String) -> Bool {
        
        let context = getContext()
        let entity = NSEntityDescription.entity(forEntityName: "FoodCollection", in: context)
        let manageObject = NSManagedObject(entity: entity!, insertInto: context)
        
        manageObject.setValue(foodName, forKey: "foodName")
        manageObject.setValue(foodCalories, forKey: "foodCalories")
        manageObject.setValue(foodImage, forKey: "foodImage")

        
        do {
            try context.save()
            return true
        }catch {
            return false
        }
    }
    
    // Show All User Object In User Stack Array
    class func fetchObject() -> [User]? {
        let context = getContext()
        var user:[User]? = nil
        do {
            user = try context.fetch(User.fetchRequest())
            return user
        }catch {
            return user
        }
    }
    
    // Show All User Object In User Stack Array
    class func fetchFoodObject() -> [FoodCollection]? {
        let context = getContext()
        var food:[FoodCollection]? = nil
        do {
            food = try context.fetch(FoodCollection.fetchRequest())
            return food
        }catch {
            return food
        }
    }
    
    
    // Detect data is nil or not
    class func detectIsNil() -> Bool {
        let context = getContext()
        let resultEntity = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let data = try context.fetch(resultEntity)
            
            if data.count == 0{
                return true
            } else{
                return false
            }
        }catch {
            return true
        }
    }
    
    //MARK: - Video Part 2
    class func deleteObject(user: User) -> Bool {
        
        let context = getContext()
        context.delete(user)
        
        do {
            try context.save()
            return true
        }catch {
            return false
        }
        
    }
    
    //MARK: - Video Part 2
    class func deleteObjectFood(objectIndex : FoodCollection) -> Bool {
        
        let context = getContext()
        context.delete(objectIndex)
        
        do {
            try context.save()
            return true
        }catch {
            return false
        }
        
    }
    
    class func cleanDelete() -> Bool {
        let context = getContext()
        let delete = NSBatchDeleteRequest(fetchRequest: User.fetchRequest())
        
        do {
            try context.execute(delete)
            return true
        }catch {
            return false
        }
    }
    
    //MARK: - Video Part 3
    class func filterData() -> [User]? {
        let context = getContext()
        let fetchRequest:NSFetchRequest<User> = User.fetchRequest()
        var user:[User]? = nil
        
        let predicate = NSPredicate(format: "password contains[c] %@", "2")
        fetchRequest.predicate = predicate
        
        do {
            user = try context.fetch(fetchRequest)
            return user
            
        }catch {
            return user
        }
    }
}
