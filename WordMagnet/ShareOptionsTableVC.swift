//
//  ShareOptionsTableVC.swift
//  WordMagnet
//
//  Created by Student on 3/10/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation
import UIKit


class ShareOptionsTableVC: UITableViewController
{
    var optionsArray = [(name: "ShareFaceBook", value: "Share on FaceBook"), (name: "ShareTwitter", value: "Share on Twitter"), (name: "UploadPhoto", value: "Choose your own background")]
    var optionsList:String?
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return optionsArray.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCellWithIdentifier("reuseIdentifier", forIndexPath: indexPath) as UITableViewCell
        
        cell.textLabel.text = optionsArray[indexPath.row].value
        
        return cell
    }
    
    override func tableView(tableView: UITableView,didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        optionsList = optionsArray[indexPath.row].name
        
        let d = ["Value": optionsList!]
        
        dismissViewControllerAnimated(true, completion:
        { () -> Void in
                NSNotificationCenter.defaultCenter().postNotificationName(mySharingOptions, object: self, userInfo: d)
        })
    }
    
}
