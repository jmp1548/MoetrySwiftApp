//
//  DocumentSave.swift
//  WordMagnet
//
//  Created by Jason  on 3/11/15.
//  Copyright (c) 2015 Student. All rights reserved.
//

import Foundation

func DocumentsDirectory() -> String{
    return NSSearchPathForDirectoriesInDomains(NSSearchPathDirectory.DocumentDirectory, NSSearchPathDomainMask.UserDomainMask, true).first as String
}

func FilePathInDocumentsDirectory(fileName: String) -> String{
    return DocumentsDirectory().stringByAppendingPathComponent(fileName)
}