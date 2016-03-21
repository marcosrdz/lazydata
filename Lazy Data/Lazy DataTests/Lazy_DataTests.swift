//
//  Lazy_DataTests.swift
//  Lazy DataTests
//
//  Created by Marcos Rodriguez on 3/12/16.
//  Copyright © 2016 Marcos Rodriguez Vélez. All rights reserved.
//

import XCTest
@testable import LazyData

class LazyDataTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        LazyData.dataModel(name: "LazyDataTestModel")
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testInsert() {
        let entityName = "Person"
        LazyData.insertObject(entityName: entityName, dictionary: ["name": "Foo"])

        print("\nNew Entity ID: \(LazyData.fetchObjects(entityName: entityName)?.first?.valueForKeyPath( "id"))")
        print("\nNew Entity Name: \(LazyData.fetchObjects(entityName: entityName)?.first?.valueForKeyPath( "name"))")
        print("\n")
    }
    
    func testDeleteAllObjects() {
        print("Before deleting:")
        for entity in LazyData.allEntities()! {
            for object in LazyData.fetchObjects(entityName: entity.name!)! {
                print("\nID: \(object.valueForKeyPath("id"))")
                print("\nName: \(object.valueForKeyPath("name"))")
                print("\n")
            }
        }

        LazyData.deleteAllObjects()
        
        print("After deleting")
        for entity in LazyData.allEntities()! {
            for object in LazyData.fetchObjects(entityName: entity.name!)! {
                print("\nID: \(object.valueForKeyPath("id"))")
                print("\nName: \(object.valueForKeyPath("name"))")
                print("\n")
            }
        }
    }
    
    func testFetchedResultsControllerWithNoParameters() {
        LazyData.insertObject(entityName: "Person", dictionary: ["name": "Foo"])
        let controller = LazyData.fetchedResultsController(entityName: "Person")
        
        print("Controller: \(controller)")
    }
    
    func testFetchedResultsController() {
        LazyData.insertObject(entityName: "Person", dictionary: ["name": "Foo"])
        let controller = LazyData.fetchedResultsController(entityName: "Person", predicate: nil, fetchLimit: nil, offset: nil, sortBy: [NSSortDescriptor(key: "name", ascending: true)], separateSectionsByKey: "name", cacheName: nil)
        
        print("Controller: \(controller)")
    }
    
}
