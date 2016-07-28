//
//  TweetersTableViewController.swift
//  SmashTag
//
//  Created by Carlos Rosario on 7/28/16.
//  Copyright © 2016 Carlos Rosario. All rights reserved.
//

import UIKit
import CoreData
class TweetersTableViewController: CoreDataTableViewController {

    // #stanford, #charizard, etc. whatever hashtag you are searching
    var mention: String? {
        didSet {
            updateUI()
        }
    }
    var managedObjectContext: NSManagedObjectContext? {
        didSet {
            updateUI()
        }
    }
    
    private func updateUI(){
        
        if let context = managedObjectContext where mention?.characters.count > 0{
            let request = NSFetchRequest(entityName: "TwitterUser")
            request.predicate = NSPredicate(format: "any tweets.text contains[c] %@ and !screenName beginswith[c] %@", mention!, "darkside")
            request.sortDescriptors = [NSSortDescriptor(key: "screenName", ascending: true, selector: #selector(NSString.localizedCaseInsensitiveCompare(_:)))]
             self.fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        }
        else {
            fetchedResultsController = nil
        }
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("TwitterUserCell", forIndexPath: indexPath)

        if let twitterUser = fetchedResultsController?.objectAtIndexPath(indexPath) as? TwitterUser {
            
            var screenName: String?
            
            twitterUser.managedObjectContext?.performBlockAndWait{
                screenName = twitterUser.screenName
            }
            cell.textLabel?.text = screenName
            
        }

        return cell
    }
}
