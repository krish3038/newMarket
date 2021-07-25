//
//  ErrorHandler.swift
//  NewMarketServices
//
//  Created by admin on 19/03/18.
//  Copyright © 2018 virtusa. All rights reserved.
//

import Foundation

class ErrorHandler: NSObject {

    var errorDict = [String:Any]()

    static let sharedInstance: ErrorHandler = {
        let instance = ErrorHandler()
        
        if let bundlePath = Bundle.main.url(forResource: "ErrorCode", withExtension: "plist") {
            do {
                let data = try Data(contentsOf:bundlePath)
                instance.errorDict = try PropertyListSerialization.propertyList(from: data, options: [], format: nil) as! Dictionary
            } catch {
                print(error)
            }
        }
        
        return instance
    }()

    func getErrorDictionary(_ errorCode:String, _ featureName:String) -> [String:Any] {
        let errorDictionary:[String:Any] = (self.errorDict[featureName] as! [String : Any])[errorCode] as! [String : Any]
        return errorDictionary
    }

}
