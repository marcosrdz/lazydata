//
//  LazyData+Insert.swift
//  Lazy Data
//
//  Created by Marcos Rodriguez on 3/13/16.
//  Copyright © 2016 Marcos Rodriguez Vélez. All rights reserved.
//

import Foundation
import CoreData

extension LazyData {

    public func insertObject(entityName entityName: String, dictionary: [String: AnyObject]) {
        let entityDescription = NSEntityDescription()
        entityDescription.name = entityName
        
        for (key, value) in dictionary {
            let object = NSManagedObject(entity: entityDescription, insertIntoManagedObjectContext: LazyData.sharedInstance.managedObjectContext)
            object.setValue(value, forKey: key)
            
            LazyData.sharedInstance.managedObjectContext.insertObject(object)
        }
        LazyData.save()
    }
    
}