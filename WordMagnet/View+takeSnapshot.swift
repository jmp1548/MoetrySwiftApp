//
//  View+takeSnapshot.swift
//  WordMagnet
//
//  Created by Jason  on 3/11/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import UIKit

extension UIView {
    func takeSnapshot() -> UIImage{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.mainScreen().scale)
        self.drawViewHierarchyInRect(self.bounds, afterScreenUpdates: true)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }
}


