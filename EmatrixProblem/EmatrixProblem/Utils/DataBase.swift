//
//  DataBase.swift
//  EmatrixProblem
//
//  Created by ashok Mahawar on 24/11/19.
//  Copyright © 2019 ashok Mahawar. All rights reserved.
//

import Foundation
import CoreData
import UIKit

final class DataBase: NSObject {
    static let shared = DataBase.init()
    private override init() {
        //
    }
    
    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "EmatrixProblem")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    func insertUserInfomation(_ info :FriendInformation ) {
        let context = self.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "User", in: context)
        let user = NSManagedObject.init(entity: entity!, insertInto: context)
        do {
            user.setValue(info.emailID, forKey: "emaiID")
            user.setValue(info.lastName, forKey: "lname")
            user.setValue(info.firstName, forKey: "fname")
            user.setValue(info.imageUrl, forKey: "profileurl")
            user.setValue(info.profileImage, forKey: "profilepicture")
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        do {
            try context.save()
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
    }
    
    func fetchUserInformation() -> [FriendInformation]{
        let context = self.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        var data = [FriendInformation]()
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        do {
            let result = try context.fetch(request)
            for obj in result as! [NSManagedObject] {
                let friend : FriendInformation = .init(obj.value(forKey: "emaiID") as! String, obj.value(forKey: "fname") as! String, obj.value(forKey: "lname") as! String, obj.value(forKey: "profileurl") as! String)
                friend.updateImage(obj.value(forKey: "profilepicture") as? NSData ?? NSData.init())
                data.append(friend)
          }
            
        } catch {
            print("Failed")
        }
        
        return data
    }
    
    func deleteInformation(){
        let context = self.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "User")
        do {
            let result = try context.fetch(request)
            for obj in result as! [NSManagedObject] {
                context.delete(obj)
            }
            
        } catch {
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        do {
             try context.save()
         } catch {
             let nserror = error as NSError
             fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
         }
        
    }
    
}
