//
//  TableViewController.swift
//  OnTheMap
//
//  Created by Rachel Schifano on 2/19/16.
//  Copyright © 2016 schifano. All rights reserved.
//

import Foundation
import UIKit

class TableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
    }
    
    // provide number of cells
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return UdacityClient.StudentInformation.locations.count
    }

    // populate table cells
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("StudentLocationTableViewCell") as UITableViewCell!
        let location = UdacityClient.StudentInformation.locations[indexPath.row]
        
        // Assign cell properties
        cell.textLabel?.text = "\(location.firstName) \(location.lastName)"
        cell.detailTextLabel?.text = location.mediaURL
        // FIXME: Add pin image
        
        return cell
    }
    
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // open URL
    }
}