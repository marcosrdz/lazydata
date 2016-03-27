//
//  LazyDataTableViewController.swift
//  Lazy Data
//
//  Created by Marcos Rodriguez on 3/26/16.
//  Copyright © 2016 Marcos Rodriguez Vélez. All rights reserved.
//

import Foundation
import UIKit
import CoreData

protocol LazyDataTableViewDataSource: class {
    
    func lazyDataCellForRowAtIndexPath(indexPath: NSIndexPath) -> UITableViewCell
    
    func lazyDataCellIdentifierForRowAtIndexPath(indexPath: NSIndexPath) -> String
    
    func lazyDataCanEditRowAtIndexPath(indexPath: NSIndexPath) -> Bool
    
    func lazyDataContentDidChange()
    
}

class LazyDataTableViewController: NSObject, NSFetchedResultsControllerDelegate, UITableViewDataSource {
    
    private var fetchedResultsController: NSFetchedResultsController
    private var tableView: UITableView
    weak var dataSource: LazyDataTableViewDataSource?
    
    // MARK: - Initializer
    
    init?(tableView: UITableView, fetchedResultsController: NSFetchedResultsController) {
        do {
            try fetchedResultsController.performFetch()
            self.tableView = tableView
            self.fetchedResultsController = fetchedResultsController
            super.init()
            self.tableView.dataSource = self
            self.fetchedResultsController.delegate = self
        }
        catch {
            print("Unable to initialize. There was an error when running performFetch() on the referenced fetchedResultsController.")
            return nil
        }
    }
    
    // MARK: - UITableViewDataSource
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultsController.sections?[section].numberOfObjects ?? 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return fetchedResultsController.sections?.count ?? 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        guard let cellIdentifier = dataSource?.lazyDataCellIdentifierForRowAtIndexPath(indexPath) else {
            fatalError("LazyDataTableViewController dataSource has not been set.")
        }
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return dataSource?.lazyDataCanEditRowAtIndexPath(indexPath) ?? false
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return fetchedResultsController.sectionIndexTitles[section]
    }
    
    func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return fetchedResultsController.sectionIndexTitles
    }
    
    // MARK: - NSFetchedResultsControllerDelegate
    
    func controllerWillChangeContent(controller: NSFetchedResultsController) {
        tableView.beginUpdates()
    }
    
    func controller(controller: NSFetchedResultsController, didChangeObject anObject: AnyObject, atIndexPath indexPath: NSIndexPath?, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath?) {
        switch type {
        case .Insert:
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
        case .Delete:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
        case .Update:
            tableView.reloadRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
        case .Move:
            tableView.deleteRowsAtIndexPaths([indexPath!], withRowAnimation: .Automatic)
            tableView.insertRowsAtIndexPaths([newIndexPath!], withRowAnimation: .Automatic)
        }
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        tableView.endUpdates()
        dataSource?.lazyDataContentDidChange()
    }
    
}