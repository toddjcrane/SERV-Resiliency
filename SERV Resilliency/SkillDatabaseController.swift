//
//  SkillDatabaseController.swift
//  SERV Resilliency
//
//  Created by Todd Crane on 6/9/15.
//  Copyright © 2015 Todd Crane. All rights reserved.
//

import Foundation
import UIKit
import CloudKit

class SkillDatabaseController: UITableViewController, ModelDelegate {
    let model: Model = Model.sharedInstance()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        model.delegate = self;
        model.refresh()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(model, action: "refresh", forControlEvents: .ValueChanged)
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Model.sharedInstance().items.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath)
        let object = Model.sharedInstance().items[indexPath.row]
        cell.textLabel!.text = object.name
        return cell
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        //if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let object = Model.sharedInstance().items[indexPath.item]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                print("object")
                print (object)
                controller.detailItem = object
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
                //  }
        }
    }
    
    func modelUpdated() {
    }
    
    func errorUpdating(error: NSError) {
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        configureView()
    }
    
    func configureView() {
        /*Model.sharedInstance().userInfo.loggedInToICloud() {
            accountStatus, error in
            let enabled = accountStatus == .Available || accountStatus == .CouldNotDetermine

        }*/
    }
}
