//
//  ViewController.swift
//  WordMagnet
//
//  Created by Student on 2/17/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var words = ["could","cloud","bot","bit","ask","a","geek","flame","file","ed","ed","create","like","lap","is","ing","I","her"
         ,"drive","get","soft","screen","protect","online","meme","to","they","that","tech","space","source","y","write"
         ,"while"]
    
    var screenSize: CGFloat?
    
    var xOffSet = CGFloat()
    var yOffSet = CGFloat()
    
    var position = CGPoint(x: 40, y: 40)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        srandom(UInt32(time(nil)))
        screenSize = UIScreen.mainScreen().bounds.width
        placeWords()
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateScreen", name: UIDeviceOrientationDidChangeNotification, object: nil)
    }
    
    func updateScreen(){
        //screenSize = UIScreen.mainScreen().bounds.width
        println(screenSize!)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func placeWords()
    {
        view.backgroundColor = UIColor.orangeColor()
        for word in words
        {
            var l = UILabel()
            l.backgroundColor = UIColor.whiteColor()
            l.text = "\(word)  "
            l.textAlignment = .Center
            l.sizeToFit()
            var test = position.x
            
            l.frame = CGRectMake(position.x + xOffSet, position.y + yOffSet, l.frame.width, l.frame.height)
            
            if position.x + xOffSet > screenSize! - screenSize!/10{
                yOffSet += l.frame.size.height + 50
                position.x = 40
                xOffSet = 0
            
                l.frame = CGRectMake(position.x + xOffSet, position.y + yOffSet, l.frame.width, l.frame.height)
                
            }
            
            xOffSet += l.frame.size.width + 10
            
            view.addSubview(l)
            
            l.userInteractionEnabled = true
            var panGesture = UIPanGestureRecognizer(target: self, action: "doPanGesture:")
            l.addGestureRecognizer(panGesture)
        }
        
        
    }
    
    func doPanGesture(panGesture:UIPanGestureRecognizer)
    {
        var label = panGesture.view as UILabel
        var position = panGesture.locationInView(view)
        label.center = position
    }


}

