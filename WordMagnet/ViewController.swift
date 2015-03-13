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
let myFontChange = "fontChange"

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    var model:WordsModelClass = WordsModelClass()
    var listChoosen:String?
    var shareOptionChoosen:String?
    var path = FilePathInDocumentsDirectory("wordList.txt")
    var placingSavedWords:Bool?
    @IBOutlet weak var mySlider: UISlider!
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
        
        //NSNotificationCenter.defaultCenter().addObserver(self, selector: "rotate", name: UIDeviceOrientationDidChangeNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "wordChange:", name: myWordListChange, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "manageSharingOptions:", name: mySharingOptions, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "fontChange:", name: myFontChange, object: nil)
        
        if let data = UIImage(contentsOfFile: FilePathInDocumentsDirectory("mainview.png")){
                myImageView.image = data
            }
        
        if let words = String(contentsOfFile: path, encoding: NSUTF8StringEncoding, error: nil){
            listChoosen = words

        }

        if let labels = NSMutableArray(contentsOfFile: FilePathInDocumentsDirectory("labelPositions.plist"))
        {
            labelPositionsArray = labels
            placingSavedWords = true
            placeWords()
        }
        
    }
    
    override func viewWillTransitionToSize(size: CGSize, withTransitionCoordinator coordinator: UIViewControllerTransitionCoordinator) {
        if UIDevice.currentDevice().orientation.isLandscape.boolValue {
            placingSavedWords = false
            placeWords()
        } else {
            placingSavedWords = false
            placeWords()
        }
    }
    
    func wordChange(n: NSNotification)
    {
        let d = n.userInfo!
        listChoosen = d["listValue"] as? String
        
        placingSavedWords = false
        placeWords()
        saveLabelPositions(self)
    }
    
    func fontChange(n: NSNotification)
    {
        let d = n.userInfo!
        var font = d["font"] as? String
        
        for view in self.view.subviews
        {
            if(view.isKindOfClass(UILabel))
            {
                var l = view as UILabel
                
                if IS_IPAD{
                    l.font = UIFont(name: font!, size: 30)
                    l.sizeToFit()
                    
                } else {
                    l.font = UIFont(name: font!, size: 16)
                    l.sizeToFit()
                }
                
            }
        }
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
            var social = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            social.addImage(view.takeSnapshot())
            self.presentViewController(social, animated: true, completion: nil)
        }
        else if(shareOptionChoosen == "ShareTwitter")
        {
            var social = SLComposeViewController(forServiceType: SLServiceTypeTwitter)
            social.addImage(view.takeSnapshot())
            self.presentViewController(social, animated: true, completion: nil)
        }
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    //places words based on what word list is choosen from the start
    func placeWords()
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
        
        if placingSavedWords == true
        {
            for word in labelPositionsArray
            {
                var text = word["text"] as String
                var positionString = word["position"] as String
                var point = CGPointFromString(positionString)
                
                var l = UILabel()
                l.text = text
                l.backgroundColor = UIColor.whiteColor()
                l.textAlignment = .Center
                
                if(IS_IPAD)
                {
                    l.font = l.font.fontWithSize(30)
                    l.sizeToFit()
                    
                }
                else
                {
                    l.font = l.font.fontWithSize(16)
                    l.sizeToFit()
                    
                }
                l.center = point
                //l.frame = CGRectMake(point.x, point.y, l.frame.width, l.frame.height)
                l.userInteractionEnabled = true
                var panGesture = UIPanGestureRecognizer(target: self, action: "doPanGesture:")
                l.addGestureRecognizer(panGesture)
                view.addSubview(l)
            }
        }
        else
        {
            for word in arrayList.arrayForCategory(listChoosen!)
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
    
    
    func SaveImageAsPNG(image: UIImage, path: String) -> Bool{
        let pngData = UIImagePNGRepresentation(image)
        let result = pngData.writeToFile(path, atomically: true)
        return result
    }

    override func viewDidAppear(animated: Bool) {
        SaveImageAsPNG(myImageView.image!, path: FilePathInDocumentsDirectory("mainview.png"))
        
    }
    
    override func viewWillDisappear(animated: Bool)
    {
        lastWordList = listChoosen!
        lastWordList?.writeToFile(path, atomically: true, encoding: NSUTF8StringEncoding, error: nil)
        saveLabelPositions(self)
    }

}

