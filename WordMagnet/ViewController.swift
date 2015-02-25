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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        srandom(UInt32(time(nil)))
        placeWords()
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
            l.text = word
            l.sizeToFit()
            var x = CGFloat(random() % 280) + 20.0
            var y = CGFloat(random() % 300) + 30.0
            l.center = CGPointMake(x,y)
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

