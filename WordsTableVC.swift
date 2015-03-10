//
//  WordsTableVC.swift
//  WordMagnet
//
//  Created by Student on 3/2/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation
import UIKit

class WordsTableVC: UITableViewController
{
    var wordArray = [(name: "Tech", value: "tech"), (name: "Pirate", value: "pirate"), (name: "Space", value: "space")]
    
    var list:String?
    override func viewDidLoad()
    {
        super.viewDidLoad()
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
        return wordArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel?.text = wordArray[indexPath.row].name
        
        return cell
    }
    
    override func tableView(tableView: UITableView,didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        list = wordArray[indexPath.row].value
        
        let data = ["listValue": list!]
        
        NSNotificationCenter.defaultCenter().postNotificationName(myWordListChange, object: self, userInfo: data)
        
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancelTapped(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
