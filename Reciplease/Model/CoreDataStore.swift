//
//  CoreDataStore.swift
//  Reciplease
//
//  Created by Gilles Sagot on 30/08/2021.
//

import Foundation
import CoreData

enum StorageType {
    case persistent, inMemory
}

class CoreDataStore {

    
    let persistentContainer:NSPersistentContainer!
    
    
    init(_ storageType: StorageType = .persistent) {
        print("new init")
        self.persistentContainer = NSPersistentContainer(name: "Reciplease")
        
        if storageType == .inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: "/dev/null")
            self.persistentContainer.persistentStoreDescriptions = [description]
        }
        
        self.persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
    
    

}
