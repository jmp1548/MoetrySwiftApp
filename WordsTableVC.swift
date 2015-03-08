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
    var wordPackages = [[String]]()
    //var model:WordsModelClass = WordsModelClass()
    
    var list:String?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        wordPackages.append(arrayList.arrayForCategory("tech"))
        wordPackages.append(arrayList.arrayForCategory("pirate"))
        wordPackages.append(arrayList.arrayForCategory("space"))
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
        
        return wordPackages.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        //cell.textLabel.text = colors[indexPath.row]
        let t = wordPackages[indexPath.row]
        let name = wordPackages[indexPath.row][0]
        cell.textLabel?.text = name
        
        return cell
    }
    
    override func tableView(tableView: UITableView,didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        list = wordPackages[indexPath.row][0]
        //dismissViewControllerAnimated(true, completion: nil)
        

    }
    
    @IBAction func cancelTapped(sender: AnyObject)
    {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
}
