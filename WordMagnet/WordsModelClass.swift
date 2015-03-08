//
//  WordsModelClass.swift
//  WordMagnet
//
//  Created by Student on 3/2/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import Foundation

class WordsModelClass
{
    private var myData = [String:[String]]()
    
    //Arrays of words to choose from
    //var tech: [String] = []
    //var pirate: [String] = []
    //var space: [String] = []
    
    //Screen size/offset related variable
    var xOffSet = CGFloat()
    var yOffSet = CGFloat()
    var position = CGPoint(x: 40, y: 40)
    var screenSize: CGFloat?
    
    var listChoosen:String?
    
    init()
    {
        listChoosen = "Tech"
        
        myData["tech"] = ["Tech","could","cloud","bot","bit","ask","a","geek","flame","file","ed","ed","create","like","lap","is","ing","I","her"
            ,"drive","get","soft","screen","protect","online","meme","to","they","that","space","source","y","write"
            ,"while"]
        
        myData["pirate"] = ["Pirate","ship", "blunderer", "hook", "treasure", "captain", "sea", "parrot", "pegleg", "hook", "chest", "island", "cannon", "flag", "map", "compass", "scurvy", "plunder", "aargh", "earring", "booty", "gold", "mate", "buccaneer", "blackbeard", "beard", "steal", "rum", "skull", "crossbones"]
        
        myData["space"] = ["Space", "planets", "stars", "galaxy", "moon", "black", "hole", "warp", "orbit", "spaceship", "rocket", "deep", "flying", "asteroid", "celestial", "cosmic", "atmosphere", "gravity", "meteorite", "solar", "sun", "nebula", "satellite", "comet", "astronaut", "explore", "votage"]
    }

    func alignWords(l: UILabel, word: String )->UILabel
    {

        l.backgroundColor = UIColor.whiteColor()
        l.text = "\(word)  "
        l.textAlignment = .Center
        l.sizeToFit()
        var test = position.x
            
        l.frame = CGRectMake(position.x + xOffSet, position.y + yOffSet, l.frame.width, l.frame.height)
            
        //giving the right side of the sreen a 10% padding and checking to see if the words go past this
        if (position.x + xOffSet + l.frame.width > screenSize! - screenSize!/10)
        {
            yOffSet += l.frame.size.height + 50
            position.x = 40
            xOffSet = 0
                
            l.frame = CGRectMake(position.x + xOffSet, position.y + yOffSet, l.frame.width, l.frame.height)
                
        }
            
        xOffSet += l.frame.size.width + 10
        l.userInteractionEnabled = true
        
        return l
    }
    
    func arrayForCategory(category: String) -> [String]{
        return myData[category]! ?? [String]()
    }
    
   }

var arrayList = WordsModelClass()