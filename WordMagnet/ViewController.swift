//
//  ViewController.swift
//  WordMagnet
//
//  Created by Student on 2/17/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit
import Social

let myWordListChange = "wordListChange"
let mySharingOptions = "sharingOptions"

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var model:WordsModelClass = WordsModelClass()
    var listChoosen:String?
    var shareOptionChoosen:String?
    
    //Image Picker related variables
    @IBOutlet weak var myImageView: UIImageView!
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        srandom(UInt32(time(nil)))
        model.screenSize = UIScreen.mainScreen().bounds.width
        view.backgroundColor = UIColor.orangeColor()
        listChoosen = "tech"
        placeWords()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updateScreen", name: UIDeviceOrientationDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "wordChange:", name: myWordListChange, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "manageSharingOptions:", name: mySharingOptions, object: nil)
    }
    
    func wordChange(n: NSNotification)
    {
        let d = n.userInfo!
        listChoosen = d["listValue"] as? String
        
        updateScreen()
    }
    
    //Will manage our sharing options(Uploading to FB, to Twitter, or uploading your own photo)
    func manageSharingOptions(n: NSNotification)
    {
        let d = n.userInfo!
        shareOptionChoosen = d["Value"] as? String
        
        if(shareOptionChoosen == "UploadPhoto")
        {
            if UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.SavedPhotosAlbum)
            {
                imagePicker.delegate = self
                imagePicker.sourceType = UIImagePickerControllerSourceType.SavedPhotosAlbum
                imagePicker.allowsEditing = false
                self.presentViewController(imagePicker, animated: true, completion: nil)
            }

        }
        else if(shareOptionChoosen == "ShareFaceBook")
        {
            UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
            view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            var social = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            social.addImage(image)
            self.presentViewController(social, animated: true, completion: nil)
        }
        else if(shareOptionChoosen == "ShareTwitter")
        {
            UIGraphicsBeginImageContextWithOptions(view.bounds.size, false, 0)
            view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            var social = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            social.addImage(image)
            self.presentViewController(social, animated: true, completion: nil)
        }
        
        
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
    
    
    //places words based on what word list is choosen from the start
    func placeWords()
    {
        if(listChoosen == "tech")
        {
            for word in arrayList.arrayForCategory("tech")
            {
                var l = UILabel()
                l = model.alignWords(l, word: word)
                
                var panGesture = UIPanGestureRecognizer(target: self, action: "doPanGesture:")
                l.addGestureRecognizer(panGesture)
                view.addSubview(l)
                
            }
        }
        else if(listChoosen == "pirate")
        {
            for word in arrayList.arrayForCategory("pirate")
            {
                var l = UILabel()
                l = model.alignWords(l, word: word)
                
                var panGesture = UIPanGestureRecognizer(target: self, action: "doPanGesture:")
                l.addGestureRecognizer(panGesture)
                view.addSubview(l)
                
            }
        }
        else if(listChoosen == "food")
        {
            for word in arrayList.arrayForCategory("food")
            {
                var l = UILabel()
                l = model.alignWords(l, word: word)
                
                var panGesture = UIPanGestureRecognizer(target: self, action: "doPanGesture:")
                l.addGestureRecognizer(panGesture)
                view.addSubview(l)
                
            }
        }
        else
        {
            for word in arrayList.arrayForCategory("space")
            {
                var l = UILabel()
                l = model.alignWords(l, word: word)
                
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
    
    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: [NSObject : AnyObject]!)
    {
        myImageView.image = image
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

