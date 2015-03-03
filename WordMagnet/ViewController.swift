//
//  ViewController.swift
//  WordMagnet
//
//  Created by Student on 2/17/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var model:WordsModelClass = WordsModelClass()
    var listChoosen:String?
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        srandom(UInt32(time(nil)))
        model.screenSize = UIScreen.mainScreen().bounds.width
        view.backgroundColor = UIColor.orangeColor()
        listChoosen = "Tech"
        placeWords()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateScreen", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    func updateScreen()
    {
        model.screenSize = UIScreen.mainScreen().bounds.width
        model.xOffSet = 0
        model.yOffSet = 0
        
        for view in self.view.subviews
        {
            if(view.isKindOfClass(UILabel))
            {
                view.removeFromSuperview()
            }
        }
        placeWords()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func unwindToMain(segue:UIStoryboardSegue)
    {
        var vc = segue.sourceViewController as WordsTableVC
        listChoosen = vc.list
        self.updateScreen()
    }
    
    //places words based on what word list is choosen from the start
    func placeWords()
    {
        if(listChoosen == "Tech")
        {
            for word in model.tech
            {
                var l = UILabel()
                l = model.alignWords(l,word: word)
                
                var panGesture = UIPanGestureRecognizer(target: self, action: "doPanGesture:")
                l.addGestureRecognizer(panGesture)
                view.addSubview(l)
                
            }
        }
        else if(listChoosen == "Pirate")
        {
            for word in model.pirate
            {
                var l = UILabel()
                l = model.alignWords(l,word: word)
                
                var panGesture = UIPanGestureRecognizer(target: self, action: "doPanGesture:")
                l.addGestureRecognizer(panGesture)
                view.addSubview(l)
                
            }
        }
        else
        {
            for word in model.space
            {
                var l = UILabel()
                l = model.alignWords(l,word: word)
                
                var panGesture = UIPanGestureRecognizer(target: self, action: "doPanGesture:")
                l.addGestureRecognizer(panGesture)
                view.addSubview(l)
                
            }
        }
        
    }
    
    func doPanGesture(panGesture:UIPanGestureRecognizer)
    {
        var label = panGesture.view as UILabel
        var position = panGesture.locationInView(view)
        label.center = position
    }

}

