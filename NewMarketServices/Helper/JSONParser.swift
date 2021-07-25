//
//  JSONParser.swift
//  BTWLMSEE
//
//  Created by VirtusaPolaris on 17/03/16.
/*******************************************************************************
 * Copyright (c) 2016 BT Harlequins
 *
 * All rights reserved. This program and the accompanying materials are
 * the confidential property of BT Harlequins. It must not be copied,
 * reproduced, modified, altered, or circulated to any third party, in
 * any form or media, without the prior written consent of BT Harlequins
 *******************************************************************************/

import Foundation

public class JSONParser {

//    class func parse(file:String) -> Dictionary<String, AnyObject>? {
//        let pathPath: String = Bundle.main.path(forResource: file, ofType: "json")!
//        if (FileManager.default.fileExists(atPath: pathPath)) {
//            if let data = NSData(contentsOfFile: pathPath) {
//                let dataString = NSString(data: data, encoding:NSUTF8StringEncoding) as! String
//                return dataString.toDictionary()!
//            }
//
//        }
//        return nil
//    }
    /*
     class func parse(file:String) -> Dictionary<String, AnyObject>? {
     let pathPath: String = NSBundle.mainBundle().pathForResource(file, ofType: "json")!
     if (NSFileManager.defaultManager().fileExistsAtPath(pathPath)) {
     if let data = NSData(contentsOfFile: pathPath) {
     let dataString = NSString(data: data, encoding:NSUTF8StringEncoding) as! String
     return dataString.toDictionary()!
     }
     }
     return nil
     }
     */
    
//    /**
//     Get the JSON File content as Dictionary<String,AnyObject> from the passed file name.
//     */
//    class func getJSONDictionaryFromFile(fileName: String,
//                                         bundle:Bundle? = Bundle.main) -> Dictionary<String,AnyObject>? {
//        if let string: String = JSONParser.getJSONStringFromFile(fileName: fileName) {
//            return string.toDictionary()
//        }
//        return nil
//    }
//
//    /**
//     Get the JSON File content as String from the passed file name.
//     */
//    class func getJSONStringFromFile(fileName: String,
//                                     bundle:Bundle? = Bundle.main) -> String? {
//        if let data = JSONParser.getDataFromFile(fileName: fileName,
//                                                      fileExtension: "json",
//                                                      bundle: bundle)
//        {
//            let dataString = NSString(data: data as Data, encoding:NSUTF8StringEncoding) as! String
//            return dataString;
//        }
//        return nil
//    }
    
//    let familyNames :[String] = UIFont.familyNames
//    for  familyName in familyNames {
//    print(familyName);
//    let fontNames:[String] = UIFont.fontNames(forFamilyName: familyName)
//    for fontName in fontNames {
//    print(fontName);
//    }
//    }
    
    class func getDataFromFile(fileName: String,
                                fileExtension ext: String,
                                bundle:Bundle? = Bundle.main) -> NSData? {
        let path: String = bundle!.path(forResource: fileName, ofType: ext)!
        if (FileManager.default.fileExists(atPath: path)) {
            if let data = NSData(contentsOfFile: path) {
                return data
            }
        }
        return nil
    }
}
