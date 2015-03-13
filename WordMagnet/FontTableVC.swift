//
//  FontTableVC.swift
//  WordMagnet
//
//  Created by Jason  on 3/11/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class FontTableVC: UITableViewController {
    
     var fontArray = [(name: "HelveticaNeue UltraLight", value: "HelveticaNeue-UltraLight"),
    (name: "Chalkduster", value: "Chalkduster"), (name: "Avenir Black", value: "Avenir-Black"), (name: "Cochin", value: "Cochin")]
    
    var fontChosen: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return fontArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel.text = fontArray[indexPath.row].name
        
        return cell
    }
    
    override func tableView(tableView: UITableView,didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        fontChosen = fontArray[indexPath.row].value
        
        let data = ["font": fontChosen!]
        
        NSNotificationCenter.defaultCenter().postNotificationName(myFontChange, object: self, userInfo: data)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
