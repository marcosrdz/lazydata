//
//  LazyData.swift
//  Lazy Data
//
//  Created by Marcos Rodriguez on 3/13/16.
//  Copyright © 2016 Marcos Rodriguez Vélez. All rights reserved.
//

import Foundation
import CoreData

class LazyData {
    
    // MARK: - Singleton
    /*This is the instance, of LazyData, that will be used all the time. */
    private static let instance: LazyData = LazyData()
    private var managedObjectContext: NSManagedObjectContext = NSManagedObjectContext(concurrencyType: .PrivateQueueConcurrencyType)
    
    
    // MARK: - Start the Managed Context, and other needed objects.
    class func start() {
        
    }
    
    // MARK: - Reset the Managed Context.
    class func reset() {
        
    }
    
    // MARK: - Delete all objects in Managed Context.
    class func deleteAllObjects() {
        
    }
    
}