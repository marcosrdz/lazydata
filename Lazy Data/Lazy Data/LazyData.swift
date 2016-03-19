//
//  LazyData.swift
//  Lazy Data
//
//  Created by Marcos Rodriguez on 3/13/16.
//  Copyright © 2016 Marcos Rodriguez Vélez. All rights reserved.
//

import Foundation
import CoreData

public class LazyData: NSObject {
    
    // MARK: - Singleton
    /*This is the instance, of LazyData, that will be used all the time. */
    public static let sharedInstance = LazyData()
    private var dataModelName: String = ""
    
    private lazy var managedObjectModel: NSManagedObjectModel = {
        let modelURL = NSBundle(forClass: self.dynamicType).URLForResource(LazyData.sharedInstance.dataModelName, withExtension: "momd")!
        return NSManagedObjectModel(contentsOfURL: modelURL)!
    }()
    
    public class func allEntities() -> [NSEntityDescription]? {
        return LazyData.sharedInstance.managedObjectModel.entities
    }
    
    public class func dataModel(name name: String) {
        LazyData.sharedInstance.dataModelName = name
    }
    
    public class func insertObject(entityName entityName: String, dictionary: [String: AnyObject]) {
        let entityDescription = NSEntityDescription.entityForName(entityName, inManagedObjectContext: LazyData.sharedInstance.managedObjectContext)
        
        for (key, value) in dictionary {
            let object = NSManagedObject(entity: entityDescription!, insertIntoManagedObjectContext: LazyData.sharedInstance.managedObjectContext)
            object.willAccessValueForKey(key)
            object.willChangeValueForKey(key)
            object.setValue(value, forKeyPath: key)
            object.didChangeValueForKey(key)
            LazyData.sharedInstance.managedObjectContext.insertObject(object)
        }
        LazyData.save()
    }
    
    // MARK: - Core Data Boilerplate Code
    
    lazy var applicationDocumentsDirectory: NSURL = {
        return NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).last!
    }()
    
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: LazyData.sharedInstance.managedObjectModel)
        
        let persistentStoreURL = LazyData.sharedInstance.applicationDocumentsDirectory.URLByAppendingPathComponent("\(self.dataModelName).sqlite")
        
        do {
            try coordinator.addPersistentStoreWithType(NSSQLiteStoreType,
                configuration: nil,
                URL: persistentStoreURL,
                options: [NSMigratePersistentStoresAutomaticallyOption: true,
                    NSInferMappingModelAutomaticallyOption: true])
        } catch {
            fatalError("Persistent store error! \(error)")
        }
        
        return coordinator
    }()
    
    lazy var managedObjectContext: NSManagedObjectContext = {
        let managedObjectContext = NSManagedObjectContext(concurrencyType: .MainQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = sharedInstance.persistentStoreCoordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    public class func save() {
        if LazyData.sharedInstance.managedObjectContext.hasChanges {
            do {
                try LazyData.sharedInstance.managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                abort()
            }
        }
    }

    
}